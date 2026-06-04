-- THEMES
vim.pack.add({
	{ src = "https://github.com/scottmckendry/cyberdream.nvim" },
	{ src = "https://github.com/rebelot/kanagawa.nvim" },
})

require('kanagawa').setup({
	transparent = true,
    overrides = function(colors)
        return {
            LineNr = { bg = "NONE" },
            CursorLineNr = { bg = "NONE" },
            SignColumn = { bg = "NONE" },
            FoldColumn = { bg = "NONE" },
        }
    end,
})

-- MASON
vim.pack.add({
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" }
})

require("mason").setup({})

require("mason-lspconfig").setup {
    automatic_enable = true
}

-- CUSTOMIZATIONS

vim.pack.add({
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/NStefan002/screenkey.nvim" },
	{ src = "https://github.com/y3owk1n/undo-glow.nvim" },
	{ src = "https://github.com/ya2s/nvim-cursorline" },
	{ src = "https://github.com/chentoast/marks.nvim" },
	{ src = "https://github.com/mcauley-penney/visual-whitespace.nvim" },
	{ src = "https://github.com/sitiom/nvim-numbertoggle" },
	{ src = "https://github.com/r4ppz/lspeek.nvim" },
})

require("lspeek").setup( {
	window = {
		  width = 70,
		  height = 15,
		  border = "single",
		},

		-- Limits the number of stack preview windows.
		stack_limit = 5,

		-- LSP can return multiple definitions (e.g., overloaded functions).
		-- false = open vim.ui.select to pick one (default).
		-- true  = skip the picker and jump to the first result.
		select_first = false,

		-- Preview window is read-only.
		-- To edit the file, open it in a split or a new buffer.
		keymaps = {
		  close = "q",
		  split = "s",
		  vsplit = "v",
		  enter = "<CR>",
		},
})

require('marks').setup( {
  -- whether to map keybinds or not. default true
  default_mappings = true,
  -- which builtin marks to show. default {}
  builtin_marks = { ".", "<", ">", "^" },
  -- whether movements cycle back to the beginning/end of buffer. default true
  cyclic = true,
  -- whether the shada file is updated after modifying uppercase marks. default false
  force_write_shada = false,
  -- how often (in ms) to redraw signs/recompute mark positions. 
  -- higher values will have better performance but may cause visual lag, 
  -- while lower values may cause performance penalties. default 150.
  refresh_interval = 250,
  -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
  -- marks, and bookmarks.
  -- can be either a table with all/none of the keys, or a single number, in which case
  -- the priority applies to all marks.
  -- default 10.
  sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
  -- disables mark tracking for specific filetypes. default {}
  excluded_filetypes = {},
  -- disables mark tracking for specific buftypes. default {}
  excluded_buftypes = {},
  -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
  -- sign/virttext. Bookmarks can be used to group together positions and quickly move
  -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
  -- default virt_text is "".
  bookmark_0 = {
    sign = "⚑",
    virt_text = "hello world",
    -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
    -- defaults to false.
    annotate = false,
  },
  mappings = {}
})

require('nvim-cursorline').setup {
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
  }
}

require("undo-glow").setup({
  animation = {
    enabled = true,
    duration = 300,
  },
  highlights = {
    undo = { hl_color = { bg = "#693232" } },    -- Dark muted red
    redo = { hl_color = { bg = "#2F4640" } },    -- Dark muted green
    yank = { hl_color = { bg = "#7A683A" } },    -- Dark muted yellow
    paste = { hl_color = { bg = "#325B5B" } },   -- Dark muted cyan
    search = { hl_color = { bg = "#5C475C" } },  -- Dark muted purple
    comment = { hl_color = { bg = "#7A5A3D" } }, -- Dark muted orange
    cursor = { hl_color = { bg = "#333333" } },  -- Dark muted gray
  },
  priority = 2048 * 3,
})

local map = vim.keymap.set

map("n", "u", function() require("undo-glow").undo() end, { desc = "Undo with highlight", noremap = true })
map("n", "U", function() require("undo-glow").redo() end, { desc = "Redo with highlight", noremap = true })
map("n", "p", function() require("undo-glow").paste_below() end, { desc = "Paste below with highlight", noremap = true })
map("n", "P", function() require("undo-glow").paste_above() end, { desc = "Paste above with highlight", noremap = true })

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
  vim.schedule(function() vim.fn.setpos(".", pos) end)
  return require("undo-glow").comment()
end, { desc = "Toggle comment with highlight", expr = true, noremap = true })

map("o", "gc", function() require("undo-glow").comment_textobject() end, { desc = "Comment textobject with highlight", noremap = true })
map("n", "gcc", function() return require("undo-glow").comment_line() end, { desc = "Toggle comment line with highlight", expr = true, noremap = true })

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

require('lualine').setup()

vim.pack.add({
	{ src = "https://github.com/seblyng/roslyn.nvim" },
})

vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

require('nvim-treesitter').setup({
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

local actions = require('fzf-lua.actions')
require('fzf-lua').setup({
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
		}
	},
	actions = {
		files = {
			["ctrl-q"] = actions.file_sel_to_qf,
			["ctrl-n"] = actions.toggle_ignore,
			["ctrl-h"] = actions.toggle_hidden,
			["enter"]  = actions.file_edit_or_qf,
		}
	}
})

vim.pack.add({
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("^1") },
})

require('blink.cmp').setup({
	fuzzy = { implementation = 'prefer_rust_with_warning' },
	signature = { enabled = true },
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
		-- ["<C-e>"] = { "hide" },
	},

	appearance = {
		use_nvim_cmp_as_default = true,
		nerd_font_variant = "normal",
	},

	completion = {
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
		}
	},

	cmdline = {
		keymap = {
			preset = 'inherit',
			['<CR>'] = { 'accept_and_enter', 'fallback' },
		},
	},

	sources = { default = { "lsp" } }
})
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local bufnr = ev.buf
  end,
})
