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
    { src = "https://github.com/akinsho/toggleterm.nvim" }
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

require('marks').setup({
    default_mappings = true,
    builtin_marks = { ".", "<", ">", "^" },
    cyclic = true,
    force_write_shada = false,
    refresh_interval = 250,
    sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
    excluded_filetypes = {},
    excluded_buftypes = {},
    bookmark_0 = {
        sign = "⚑",
        virt_text = "hello world",
        annotate = false,
    },
    mappings = {}
})

require('nvim-cursorline').setup({
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
})

require("undo-glow").setup({
    animation = {
        enabled = true,
        duration = 300,
    },
    highlights = {
        undo = { hl_color = { bg = "#693232" } },
        redo = { hl_color = { bg = "#2F4640" } },
        yank = { hl_color = { bg = "#7A683A" } },
        paste = { hl_color = { bg = "#325B5B" } },
        search = { hl_color = { bg = "#5C475C" } },
        comment = { hl_color = { bg = "#7A5A3D" } },
        cursor = { hl_color = { bg = "#333333" } },
    },
    priority = 2048 * 3,
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
        ["<TAB>"] = "󰌒", ["<CR>"] = "󰌑", ["<ESC>"] = "Esc", ["<SPACE>"] = "␣",
        ["<BS>"] = "󰌥", ["<DEL>"] = "Del", ["<LEFT>"] = "", ["<RIGHT>"] = "",
        ["<UP>"] = "", ["<DOWN>"] = "", ["<HOME>"] = "Home", ["<END>"] = "End",
        ["<PAGEUP>"] = "PgUp", ["<PAGEDOWN>"] = "PgDn", ["<INSERT>"] = "Ins",
        ["<F1>"] = "󱊫", ["<F2>"] = "󱊬", ["<F3>"] = "󱊭", ["<F4>"] = "󱊮",
        ["<F5>"] = "󱊯", ["<F6>"] = "󱊰", ["<F7>"] = "󱊱", ["<F8>"] = "󱊲",
        ["<F9>"] = "󱊳", ["<F10>"] = "󱊴", ["<F11>"] = "󱊵", ["<F12>"] = "󱊶",
        ["CTRL"] = "Ctrl", ["ALT"] = "Alt", ["SUPER"] = "󰘳", ["<leader>"] = "<leader>",
    },
    notify_method = "echo",
    log = {
        min_level = vim.log.levels.OFF,
        filepath = vim.fn.stdpath("data") .. "/screenkey_log",
    },
})

require('lualine').setup({
    sections = {
        lualine_x = { "aerial" },
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
    },
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

local Terminal = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({
    cmd = "lazygit",
    hidden = true,
    direction = "float",
    float_opts = {
        border = "single",
    },
    on_open = function(_)
        vim.cmd("startinsert!")
    end,
})

-- Глобальная функция, чтобы ее можно было вызвать из keymap.lua
function _G._lazygit_toggle()
    lazygit:toggle()
end
