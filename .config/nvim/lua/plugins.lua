-- =============================================================================
-- THEMES (transparent-friendly)
-- =============================================================================
vim.pack.add({
    { src = "https://github.com/scottmckendry/cyberdream.nvim" },
    { src = "https://github.com/rebelot/kanagawa.nvim" },
    { src = "https://github.com/sainnhe/gruvbox-material" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
    { src = "https://codeberg.org/ziglang/zig.vim" },
    { src = "https://github.com/stevearc/aerial.nvim" },
    { src = "https://github.com/nvim-lualine/lualine.nvim" },
    { src = "https://github.com/NStefan002/screenkey.nvim" },
    { src = "https://github.com/y3owk1n/undo-glow.nvim" },
    { src = "https://github.com/ya2s/nvim-cursorline" },
    { src = "https://github.com/chentoast/marks.nvim" },
    { src = "https://github.com/mcauley-penney/visual-whitespace.nvim" },
    { src = "https://github.com/sitiom/nvim-numbertoggle" },
    { src = "https://github.com/r4ppz/lspeek.nvim" },
    { src = "https://github.com/seblyng/roslyn.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/ibhagwan/fzf-lua" },
    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("^1") },
    { src = "https://github.com/akinsho/toggleterm.nvim" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" }
})

--- Clear solid backgrounds on sign/git highlight groups so transparent themes
--- don't leave opaque slabs in the sign column.
local function apply_transparent_signs()
	local groups = {
		"SignColumn",
		"FoldColumn",
		"LineNr",
		"CursorLineNr",
		"GitSignsAdd",
		"GitSignsChange",
		"GitSignsDelete",
		"GitSignsTopdelete",
		"GitSignsChangedelete",
		"GitSignsUntracked",
		"GitSignsAddNr",
		"GitSignsChangeNr",
		"GitSignsDeleteNr",
		"GitSignsTopdeleteNr",
		"GitSignsChangedeleteNr",
		"GitSignsUntrackedNr",
		"GitSignsAddLn",
		"GitSignsChangeLn",
		"GitSignsDeleteLn",
		"GitSignsAddCul",
		"GitSignsChangeCul",
		"GitSignsDeleteCul",
		"GitSignsStagedAdd",
		"GitSignsStagedChange",
		"GitSignsStagedDelete",
		"GitSignsStagedTopdelete",
		"GitSignsStagedChangedelete",
		"GitSignsStagedUntracked",
		"DiagnosticSignError",
		"DiagnosticSignWarn",
		"DiagnosticSignInfo",
		"DiagnosticSignHint",
		"DiagnosticSignOk",
	}

	for _, name in ipairs(groups) do
		local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
		if ok and hl then
			hl.bg = nil
			hl.ctermbg = nil
			vim.api.nvim_set_hl(0, name, hl)
		end
	end
end

vim.api.nvim_create_autocmd("ColorScheme", {
	group = vim.api.nvim_create_augroup("TransparentSigns", { clear = true }),
	callback = function()
		-- Defer so theme + plugin highlight links settle first
		vim.schedule(apply_transparent_signs)
	end,
})

-- Kanagawa
require("kanagawa").setup({
	compile = false,
	transparent = true,
	dimInactive = false,
	terminalColors = true,
	colors = {
		theme = {
			all = {
				ui = {
					bg_gutter = "none",
				},
			},
		},
	},
	overrides = function(colors)
		local theme = colors.theme
		return {
			NormalFloat = { bg = "none" },
			FloatBorder = { bg = "none" },
			FloatTitle = { bg = "none" },
			NormalDark = { fg = theme.ui.fg_dim, bg = "none" },

			LineNr = { bg = "none" },
			CursorLineNr = { bg = "none" },
			SignColumn = { bg = "none" },
			FoldColumn = { bg = "none" },
			StatusLine = { bg = "none" },
			StatusLineNC = { bg = "none" },
			TabLine = { bg = "none" },
			TabLineFill = { bg = "none" },

			-- Gitsigns: keep fg colors, no solid gutter
			GitSignsAdd = { fg = theme.vcs.added, bg = "none" },
			GitSignsChange = { fg = theme.vcs.changed, bg = "none" },
			GitSignsDelete = { fg = theme.vcs.removed, bg = "none" },
			GitSignsTopdelete = { fg = theme.vcs.removed, bg = "none" },
			GitSignsChangedelete = { fg = theme.vcs.changed, bg = "none" },
			GitSignsUntracked = { fg = theme.vcs.added, bg = "none" },

			-- Soft solid bg so winblend can blend (bg=none makes winblend a no-op)
			Pmenu = { fg = theme.ui.fg, bg = theme.ui.bg_p1 },
			PmenuSel = { fg = theme.ui.fg, bg = theme.ui.bg_p2 },
			PmenuSbar = { bg = theme.ui.bg_m1 },
			PmenuThumb = { bg = theme.ui.bg_p2 },
			BlinkCmpMenu = { fg = theme.ui.fg, bg = theme.ui.bg_p1 },
			BlinkCmpMenuBorder = { fg = theme.ui.float.fg_border, bg = theme.ui.bg_p1 },
			BlinkCmpMenuSelection = { fg = theme.ui.fg, bg = theme.ui.bg_p2 },
			BlinkCmpDoc = { fg = theme.ui.fg, bg = theme.ui.bg_p1 },
			BlinkCmpDocBorder = { fg = theme.ui.float.fg_border, bg = theme.ui.bg_p1 },
			BlinkCmpSignatureHelp = { fg = theme.ui.fg, bg = theme.ui.bg_p1 },
			BlinkCmpSignatureHelpBorder = { fg = theme.ui.float.fg_border, bg = theme.ui.bg_p1 },
		}
	end,
})

-- Gruvbox Material (set globals before colorscheme)
vim.g.gruvbox_material_background = "medium"
vim.g.gruvbox_material_foreground = "material"
vim.g.gruvbox_material_enable_italic = true
vim.g.gruvbox_material_better_performance = 1
-- 0 = off, 1 = soft, 2 = hard (more UI groups transparent)
vim.g.gruvbox_material_transparent_background = 2
vim.g.gruvbox_material_ui_contrast = "low"
vim.g.gruvbox_material_float_style = "dim"

--- Soft float bg for completion (needs a real color so winblend can blend).
local function apply_completion_float_hl()
	local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
	local pmenu = vim.api.nvim_get_hl(0, { name = "Pmenu", link = false })
	local psel = vim.api.nvim_get_hl(0, { name = "PmenuSel", link = false })
	local border = vim.api.nvim_get_hl(0, { name = "FloatBorder", link = false })

	-- Prefer Pmenu bg; fall back to a dim Normal-like color if theme cleared it
	local menu_bg = pmenu.bg
	local menu_fg = pmenu.fg or normal.fg
	local sel_bg = psel.bg
	local border_fg = border.fg or menu_fg

	if not menu_bg then
		-- Theme used fully transparent Pmenu; invent a soft panel from Visual/CursorLine
		local visual = vim.api.nvim_get_hl(0, { name = "Visual", link = false })
		local cursorline = vim.api.nvim_get_hl(0, { name = "CursorLine", link = false })
		menu_bg = visual.bg or cursorline.bg
	end
	if not sel_bg then
		local visual = vim.api.nvim_get_hl(0, { name = "Visual", link = false })
		sel_bg = visual.bg
	end

	local function set(name, hl)
		if hl.bg or hl.fg then
			vim.api.nvim_set_hl(0, name, hl)
		end
	end

	set("BlinkCmpMenu", { fg = menu_fg, bg = menu_bg })
	set("BlinkCmpMenuBorder", { fg = border_fg, bg = menu_bg })
	set("BlinkCmpMenuSelection", { fg = menu_fg, bg = sel_bg, bold = true })
	set("BlinkCmpDoc", { fg = menu_fg, bg = menu_bg })
	set("BlinkCmpDocBorder", { fg = border_fg, bg = menu_bg })
	set("BlinkCmpSignatureHelp", { fg = menu_fg, bg = menu_bg })
	set("BlinkCmpSignatureHelpBorder", { fg = border_fg, bg = menu_bg })
	-- Keep Pmenu in sync for any non-blink consumers
	if menu_bg then
		set("Pmenu", { fg = menu_fg, bg = menu_bg })
	end
	if sel_bg then
		set("PmenuSel", { fg = menu_fg, bg = sel_bg })
	end
end

vim.api.nvim_create_autocmd("ColorScheme", {
	group = vim.api.nvim_create_augroup("GruvboxMaterialTransparent", { clear = true }),
	pattern = "gruvbox-material",
	callback = function()
		local clear = { bg = "none", ctermbg = "none" }
		local extra = {
			"Normal",
			"NormalNC",
			"NormalFloat",
			"FloatBorder",
			"SignColumn",
			"FoldColumn",
			"LineNr",
			"CursorLineNr",
			"EndOfBuffer",
			"StatusLine",
			"StatusLineNC",
			"TabLine",
			"TabLineFill",
			"WinBar",
			"WinBarNC",
		}
		for _, name in ipairs(extra) do
			local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
			if ok and hl then
				vim.api.nvim_set_hl(0, name, vim.tbl_extend("force", hl, clear))
			else
				vim.api.nvim_set_hl(0, name, clear)
			end
		end
		apply_transparent_signs()
		apply_completion_float_hl()
	end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
	group = vim.api.nvim_create_augroup("CompletionFloatBlend", { clear = true }),
	callback = function()
		vim.schedule(apply_completion_float_hl)
	end,
})

-- Cyberdream (optional; already transparent-oriented)
pcall(function()
	require("cyberdream").setup({
		transparent = true,
		italic_comments = true,
		hide_fillchars = true,
		borderless_pickers = true,
	})
end)

-- Default theme (change to "gruvbox-material" or "cyberdream" as needed)
vim.cmd.colorscheme("kanagawa")
apply_transparent_signs()

-- =============================================================================
-- MASON
-- =============================================================================
vim.pack.add({
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
})

require("mason").setup({})
require("mason-lspconfig").setup({
	automatic_enable = true,
})

-- =============================================================================
-- ZIG
-- =============================================================================
vim.pack.add({
	"https://codeberg.org/ziglang/zig.vim",
})

vim.g.zig_fmt_parse_errors = 0
vim.g.zig_fmt_autosave = 0

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.zig", "*.zon" },
	callback = function()
		vim.lsp.buf.format()
	end,
})

vim.lsp.config["zls"] = {
	cmd = { "zls" },
	filetypes = { "zig" },
	root_markers = { "build.zig" },
	settings = {
		zls = {},
	},
}
vim.lsp.enable("zls")

-- =============================================================================
-- GIT: gitsigns + lazygit (toggleterm float)
-- =============================================================================
vim.pack.add({
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/akinsho/toggleterm.nvim" },
})

require("gitsigns").setup({
	signs = {
		add = { text = "│" },
		change = { text = "│" },
		delete = { text = "󰍵" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
		untracked = { text = "┆" },
	},
	signcolumn = true,
	numhl = false,
	linehl = false,
	word_diff = false,
	current_line_blame = false,
	attach_to_untracked = true,
	preview_config = {
		border = "rounded",
		style = "minimal",
		relative = "cursor",
		row = 0,
		col = 1,
	},
	on_attach = function(bufnr)
		local gs = require("gitsigns")
		local map = function(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, noremap = true, silent = true })
		end

		map("n", "]c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
			else
				gs.nav_hunk("next")
			end
		end, "Next git hunk")

		map("n", "[c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
			else
				gs.nav_hunk("prev")
			end
		end, "Prev git hunk")

		map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
		map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
		map("v", "<leader>hs", function()
			gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, "Stage hunk")
		map("v", "<leader>hr", function()
			gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, "Reset hunk")
		map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
		map("n", "<leader>hb", function()
			gs.blame_line({ full = true })
		end, "Blame line")
	end,
})

-- Re-apply after gitsigns defines its groups
vim.schedule(apply_transparent_signs)

require("toggleterm").setup({
	size = 20,
	open_mapping = nil,
	hide_numbers = true,
	shade_terminals = false,
	start_in_insert = true,
	insert_mappings = true,
	terminal_mappings = true,
	persist_size = true,
	direction = "float",
	close_on_exit = true,
	shell = vim.o.shell,
	float_opts = {
		border = "rounded",
		width = function()
			return math.floor(vim.o.columns * 0.92)
		end,
		height = function()
			return math.floor(vim.o.lines * 0.88)
		end,
		winblend = 0,
	},
	highlights = {
		Normal = { guibg = "NONE" },
		NormalFloat = { guibg = "NONE" },
		FloatBorder = { guibg = "NONE" },
	},
})

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
	cmd = "lazygit",
	dir = "git_dir",
	direction = "float",
	hidden = true,
	float_opts = {
		border = "rounded",
	},
	on_open = function(term)
		vim.cmd("startinsert!")
		vim.keymap.set("t", "<esc>", "<esc>", { buffer = term.bufnr, nowait = true })
	end,
	on_close = function()
		vim.cmd("startinsert!")
	end,
})

--- Open lazygit in a floating terminal (requires `lazygit` in PATH)
function _G.LazyGitToggle()
	if vim.fn.executable("lazygit") == 0 then
		vim.notify("lazygit not found in PATH", vim.log.levels.ERROR)
		return
	end
	lazygit:toggle()
end

-- =============================================================================
-- UI / UX PLUGINS
-- =============================================================================
vim.pack.add({
	{ src = "https://github.com/stevearc/aerial.nvim" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/NStefan002/screenkey.nvim" },
	{ src = "https://github.com/y3owk1n/undo-glow.nvim" },
	{ src = "https://github.com/ya2s/nvim-cursorline" },
	{ src = "https://github.com/chentoast/marks.nvim" },
	{ src = "https://github.com/mcauley-penney/visual-whitespace.nvim" },
	{ src = "https://github.com/sitiom/nvim-numbertoggle" },
	{ src = "https://github.com/r4ppz/lspeek.nvim" },
})

require("aerial").setup()

require("lspeek").setup({
	window = {
		width = 70,
		height = 15,
		border = "single",
	},
	stack_limit = 5,
	select_first = false,
	keymaps = {
		close = "q",
		split = "s",
		vsplit = "v",
		enter = "<CR>",
		tab = "t",
	},
})

require("marks").setup({
	default_mappings = true,
	builtin_marks = { ".", "<", ">", "^" },
	cyclic = true,
	force_write_shada = false,
	refresh_interval = 250,
	sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
	excluded_filetypes = {},
	excluded_buftypes = {},
	mappings = {},
})

require("nvim-cursorline").setup({
	disable_filetypes = {},
	disable_buftypes = {},
	cursorline = {
		enable = true,
		timeout = 300,
		number = false,
	},
	cursorword = {
		enable = true,
		min_length = 3,
		hl = { underline = true },
	},
})

require("undo-glow").setup({
	animation = {
		enabled = true,
		duration = 450,
		animation_type = "fade",
	},
	-- Cohesive gray palette: soft mist → ash → charcoal
	highlights = {
		undo = { hl_color = { bg = "#6B6B6B" } }, -- medium gray flash
		redo = { hl_color = { bg = "#5A5A5A" } }, -- slightly darker
		yank = { hl_color = { bg = "#787878" } }, -- lighter silver
		paste = { hl_color = { bg = "#707070" } }, -- soft ash
		search = { hl_color = { bg = "#4E4E4E" } }, -- muted slate
		comment = { hl_color = { bg = "#555555" } },
		cursor = { hl_color = { bg = "#3A3A3A" } }, -- subtle charcoal
	},
	priority = 2048 * 3,
})

local map = vim.keymap.set

-- Soft gray pulse on undo/redo/paste (fade + a bit longer)
local gray_glow = {
	animation = {
		enabled = true,
		duration = 500,
		animation_type = "fade",
	},
}

map("n", "u", function()
	require("undo-glow").undo(gray_glow)
end, { desc = "Undo with highlight", noremap = true })
map("n", "U", function()
	require("undo-glow").redo(gray_glow)
end, { desc = "Redo with highlight", noremap = true })
map("n", "p", function()
	require("undo-glow").paste_below(gray_glow)
end, { desc = "Paste below with highlight", noremap = true })
map("n", "P", function()
	require("undo-glow").paste_above(gray_glow)
end, { desc = "Paste above with highlight", noremap = true })

map("n", "n", function()
	require("undo-glow").search_next({ animation = { animation_type = "strobe" } })
end, { desc = "Search next with highlight", noremap = true })

map("n", "N", function()
	require("undo-glow").search_prev({ animation = { animation_type = "strobe" } })
end, { desc = "Search prev with highlight", noremap = true })

map("n", "*", function()
	require("undo-glow").search_star({ animation = { animation_type = "strobe" } })
end, { desc = "Search star with highlight", noremap = true })

map("n", "#", function()
	require("undo-glow").search_hash({ animation = { animation_type = "strobe" } })
end, { desc = "Search hash with highlight", noremap = true })

map({ "n", "x" }, "gc", function()
	local pos = vim.fn.getpos(".")
	vim.schedule(function()
		vim.fn.setpos(".", pos)
	end)
	return require("undo-glow").comment()
end, { desc = "Toggle comment with highlight", expr = true, noremap = true })

map("o", "gc", function()
	require("undo-glow").comment_textobject()
end, { desc = "Comment textobject with highlight", noremap = true })
map("n", "gcc", function()
	return require("undo-glow").comment_line()
end, { desc = "Toggle comment line with highlight", expr = true, noremap = true })

local autocmd = vim.api.nvim_create_autocmd

autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	callback = function()
		require("undo-glow").yank()
	end,
})

autocmd("CursorMoved", {
	desc = "Highlight when cursor moved significantly",
	callback = function()
		require("undo-glow").cursor_moved({
			animation = { animation_type = "slide" },
		})
	end,
})

autocmd("FocusGained", {
	desc = "Highlight when focus gained",
	callback = function()
		---@type UndoGlow.CommandOpts
		local opts = {
			animation = { animation_type = "slide" },
		}

		opts = require("undo-glow.utils").merge_command_opts("UgCursor", opts)
		local pos = require("undo-glow.utils").get_current_cursor_row()

		require("undo-glow").highlight_region(vim.tbl_extend("force", opts, {
			s_row = pos.s_row,
			s_col = pos.s_col,
			e_row = pos.e_row,
			e_col = pos.e_col,
			force_edge = opts.force_edge == nil and true or opts.force_edge,
		}))
	end,
})

autocmd("CmdlineLeave", {
	desc = "Highlight when search cmdline leave",
	callback = function()
		require("undo-glow").search_cmd({
			animation = { animation_type = "fade" },
		})
	end,
})

require("screenkey").setup({
	win_opts = {
		row = vim.o.lines - vim.o.cmdheight - 1,
		col = vim.o.columns - 1,
		relative = "editor",
		anchor = "SE",
		width = 40,
		height = 3,
		border = "single",
		title = "Screenkey",
		title_pos = "center",
		style = "minimal",
		focusable = false,
		noautocmd = true,
	},
	hl_groups = {
		["screenkey.hl.key"] = { link = "Normal" },
		["screenkey.hl.map"] = { link = "Normal" },
		["screenkey.hl.sep"] = { link = "Normal" },
	},
	winblend = 0,
	compress_after = 3,
	clear_after = 3,
	emit_events = true,
	disable = {
		filetypes = {},
		buftypes = {},
		modes = {},
	},
	show_leader = true,
	group_mappings = false,
	display_infront = {},
	display_behind = {},
	filter = function(keys)
		return keys
	end,
	colorize = function(keys)
		return keys
	end,
	separator = " ",
	keys = {
		["<TAB>"] = "󰌒",
		["<CR>"] = "󰌑",
		["<ESC>"] = "Esc",
		["<SPACE>"] = "␣",
		["<BS>"] = "󰌥",
		["<DEL>"] = "Del",
		["<LEFT>"] = "",
		["<RIGHT>"] = "",
		["<UP>"] = "",
		["<DOWN>"] = "",
		["<HOME>"] = "Home",
		["<END>"] = "End",
		["<PAGEUP>"] = "PgUp",
		["<PAGEDOWN>"] = "PgDn",
		["<INSERT>"] = "Ins",
		["<F1>"] = "󱊫",
		["<F2>"] = "󱊬",
		["<F3>"] = "󱊭",
		["<F4>"] = "󱊮",
		["<F5>"] = "󱊯",
		["<F6>"] = "󱊰",
		["<F7>"] = "󱊱",
		["<F8>"] = "󱊲",
		["<F9>"] = "󱊳",
		["<F10>"] = "󱊴",
		["<F11>"] = "󱊵",
		["<F12>"] = "󱊶",
		["CTRL"] = "Ctrl",
		["ALT"] = "Alt",
		["SUPER"] = "󰘳",
		["<leader>"] = "<leader>",
	},
	notify_method = "echo",
	log = {
		min_level = vim.log.levels.OFF,
		filepath = vim.fn.stdpath("data") .. "/screenkey_log",
	},
})

require("lualine").setup({
	options = {
		theme = "auto",
		globalstatus = true,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = { "toggleterm" },
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = {
			{
				"aerial",
				sep = " ) ",
				depth = nil,
				dense = false,
				dense_sep = ".",
				colored = true,
			},
		},
		lualine_z = { "location", "progress" },
	},
})

-- =============================================================================
-- LANGUAGE / TOOLING
-- =============================================================================
vim.pack.add({
	{ src = "https://github.com/seblyng/roslyn.nvim" },
})

vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

require("nvim-treesitter").setup({
	opts = {
		ensure_installed = {
			"rust",
			"ron",
			"cpp",
			"ninja",
			"rst",
			"cmake",
		},
	},
})

vim.pack.add({
	{ src = "https://github.com/ibhagwan/fzf-lua" },
})

local actions = require("fzf-lua.actions")
require("fzf-lua").setup({
	winopts = { backdrop = 85 },
	keymap = {
		builtin = {
			["<C-f>"] = "preview-page-down",
			["<C-b>"] = "preview-page-up",
			["<C-p>"] = "toggle-preview",
		},
		fzf = {
			["ctrl-a"] = "toggle-all",
			["ctrl-t"] = "first",
			["ctrl-g"] = "last",
			["ctrl-d"] = "half-page-down",
			["ctrl-u"] = "half-page-up",
		},
	},
	actions = {
		files = {
			["ctrl-q"] = actions.file_sel_to_qf,
			["ctrl-n"] = actions.toggle_ignore,
			["ctrl-h"] = actions.toggle_hidden,
			["enter"] = actions.file_edit_or_qf,
		},
	},
})

require("toggleterm").setup({
    direction = "float",
    float_opts = {
        border = "single",
        width = math.floor(vim.o.columns * 0.85),
        height = math.floor(vim.o.lines * 0.8),
        winblend = 0,
    },
    open_mapping = [[<C-\>]],
    hide_numbers = true,
    shade_terminals = true,
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    persist_size = true,
    close_on_exit = true,
})

require("blink.cmp").setup({
	fuzzy = { implementation = "prefer_rust_with_warning" },
	keymap = {
		preset = "default",
		["<C-space>"] = {},
		["<C-p>"] = {},
		["<Tab>"] = {},
		["<S-Tab>"] = {},
		["<C-y>"] = { "show", "show_documentation", "hide_documentation" },
		["<C-n>"] = { "select_and_accept" },
		["<C-k>"] = { "select_prev", "fallback" },
		["<C-j>"] = { "select_next", "fallback" },
		["<C-b>"] = { "scroll_documentation_down", "fallback" },
		["<C-f>"] = { "scroll_documentation_up", "fallback" },
		["<C-l>"] = { "snippet_forward", "fallback" },
		["<C-h>"] = { "snippet_backward", "fallback" },
	},

	appearance = {
		use_nvim_cmp_as_default = true,
		nerd_font_variant = "normal",
	},

	completion = {
		-- winblend: 0 = opaque, 100 = invisible. ~25 keeps text readable with soft glass look.
		menu = {
			border = "rounded",
			winblend = 25,
			winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
			window = {
				border = "rounded",
				winblend = 25,
				winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
			},
		},
	},

	signature = {
		enabled = true,
		window = {
			border = "rounded",
			winblend = 25,
			winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
		},
	},

	cmdline = {
		keymap = {
			preset = "inherit",
			["<CR>"] = { "accept_and_enter", "fallback" },
		},
	},

	sources = { default = { "lsp" } },
})

-- blink re-links menu groups on load; re-apply soft panel colors for winblend
vim.schedule(apply_completion_float_hl)
