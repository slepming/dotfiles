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
	vim.diagnostic.jump({ count = 1,severity = vim.diagnostic.severity.ERROR })
end, opts)

keymap.set("n", "<leader>j", function ()
	vim.diagnostic.setloclist()
end, opts)

keymap.set("n", "<leader>i", function ()
	vim.lsp.buf.implementation()
end, opts)

keymap.set("n", "<leader>e", "<Cmd>Explore<CR>", opts)
keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
keymap.set("n", "gd", function ()
	require("lspeek").peek_definition()
end, opts)
keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
keymap.set("n", "<leader><leader>", "<Cmd>lua FzfLua.files()<CR>", opts)
keymap.set("n", "<leader>/", "<Cmd>FzfLua live_grep<CR>", opts)
keymap.set("n", "<leader>ci", vim.lsp.buf.incoming_calls, opts)

vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)

keymap.set("n", "<leader>f", function()
    local filename = vim.fn.expand("%:t")
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local line = vim.api.nvim_get_current_line()
    if col < #line then
        col = col + 1
    end
    vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { filename })
end, opts)
