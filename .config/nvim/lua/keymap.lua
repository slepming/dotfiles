local keymap = vim.keymap

local function opts(extra)
	return vim.tbl_extend("force", { noremap = true, silent = true }, extra or {})
end

-- Tabs
keymap.set("n", "te", ":tabedit ")
keymap.set("n", "<tab>", ":tabnext<Return>", opts())
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts())

-- Navigation / UI
keymap.set("n", "<leader>a", ":AerialToggle<Return>", opts({ desc = "Aerial outline" }))
keymap.set("n", "<leader>e", "<Cmd>Explore<CR>", opts({ desc = "File explorer" }))
keymap.set("n", "<leader><leader>", "<Cmd>lua FzfLua.files()<CR>", opts({ desc = "Find files" }))
keymap.set("n", "<leader>/", "<Cmd>FzfLua live_grep<CR>", opts({ desc = "Live grep" }))

-- Git (LazyGitToggle is defined in plugins.lua)
keymap.set("n", "<leader>g", function()
	if type(_G.LazyGitToggle) == "function" then
		_G.LazyGitToggle()
	else
		vim.notify("LazyGit is not available yet", vim.log.levels.WARN)
	end
end, opts({ desc = "LazyGit" }))

-- LSP
keymap.set("n", "<leader>fo", function()
	vim.lsp.buf.format()
end, opts({ desc = "Format buffer" }))
keymap.set("n", "<leader>sa", function()
	vim.lsp.buf.code_action()
end, opts({ desc = "Code action" }))
keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts({ desc = "Code action" }))
keymap.set("n", "<leader>ci", vim.lsp.buf.incoming_calls, opts({ desc = "Incoming calls" }))
keymap.set("n", "<leader>i", function()
	vim.lsp.buf.implementation()
end, opts({ desc = "Go to implementation" }))

keymap.set("n", "sj", function()
	vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
end, opts({ desc = "Next error" }))

keymap.set("n", "<leader>j", function()
	vim.diagnostic.setloclist()
end, opts({ desc = "Diagnostics loclist" }))

keymap.set("n", "gD", function()
	vim.lsp.buf.declaration()
end, opts({ desc = "Go to declaration" }))
keymap.set("n", "gd", function()
	require("lspeek").peek_definition()
end, opts({ desc = "Peek definition" }))
keymap.set("n", "gr", function()
	vim.lsp.buf.references()
end, opts({ desc = "References" }))

-- Insert current filename at cursor
keymap.set("n", "<leader>f", function()
	local filename = vim.fn.expand("%:t")
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	local line = vim.api.nvim_get_current_line()
	if col < #line then
		col = col + 1
	end
	vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { filename })
end, opts({ desc = "Insert filename" }))
