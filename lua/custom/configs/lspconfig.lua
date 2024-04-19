local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local util = require "lspconfig/util"
local neotest = require "neotest"
local telescope = require "telescope"
local ht = require "haskell-tools"


vim.keymap.set('n', '<space>hs', ht.hoogle.hoogle_signature, opts)

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "clangd" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {"gopls"},
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
    },
  },
}

neotest.setup {
  -- ...,
  adapters = {
    -- ...,
    require('neotest-haskell') {
      -- Default: Use stack if possible and then try cabal
      build_tools = { 'stack', 'cabal' },
      -- Default: Check for tasty first and then try hspec
      frameworks = { 'tasty', 'hspec', 'sydtest' },
    },
    require("neotest-go"),
  },
}
telescope.load_extension('hoogle')
