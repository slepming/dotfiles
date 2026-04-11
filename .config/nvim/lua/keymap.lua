local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- TABS

keymap.set("n", "te", ":tabedit ")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)
keymap.set("n", "<leader>a", ":AerialToggle<Return>", opts)

keymap.set("n", "<leader>fo", ":lua vim.lsp.buf.format()<CR>", opts)

keymap.set("n", "<leader>sa", ":lua vim.lsp.buf.code_action()<CR>")

keymap.set("n", "sj", function()
	vim.diagnostic.goto_next()
end, opts)

keymap.set("n", "<leader>e", "<Cmd>Explore<CR>, opts")
vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader><leader>", "<Cmd>lua FzfLua.files()<CR>", opts)
keymap.set("n", "<leader>/", "<Cmd>FzfLua live_grep<CR>", opts)

vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
