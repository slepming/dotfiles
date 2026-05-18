vim.lsp.config('*', {
  capabilities = require('blink.cmp').get_lsp_capabilities()
})

vim.lsp.enable({
  "rust-analyzer",
  "lua_ls",
  "gopls",
})

vim.diagnostic.config({ virtual_text = true })
