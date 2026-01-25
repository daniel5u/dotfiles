vim.pack.add({
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
})

require('gitsigns').setup({ signcolumn = false })

vim.pack.add({
    { src = "https://github.com/nvim-tree/nvim-web-devicons.git" },
})

require('nvim-web-devicons').setup({
    variant = "dark",
    default = true,
    override_by_filename = {
        [".gitignore"] = {
            icon = "",
            color = "#f1502f",
            name = "Gitignore"
        }
    },
})

vim.pack.add({
    { src = "https://github.com/mason-org/mason.nvim" },
})

require("mason").setup({})

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
    },

    appearance = {
        nerd_font_variant = "mono",

        kind_icons = {
            Text = '󰉿',
            Method = '󰊕',
            Function = '󰊕',
            Constructor = '󰒓',

            Field = '󰜢',
            Variable = '󰆦',
            Property = '󰖷',

            Class = '󱡠',
            Interface = '󱡠',
            Struct = '󱡠',
            Module = '󰅩',

            Unit = '󰪚',
            Value = '󰦨',
            Enum = '󰦨',
            EnumMember = '󰦨',

            Keyword = '󰻾',
            Constant = '󰏿',

            Snippet = '󱄽',
            Color = '󰏘',
            File = '󰈔',
            Reference = '󰬲',
            Folder = '󰉋',
            Event = '󱐋',
            Operator = '󰪚',
            TypeParameter = '󰬛',
        },
    },

    completion = {
        documentation = {
            auto_show = false,
        },
        ghost_text = {
            enabled = true,
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
    { src = "https://github.com/akinsho/toggleterm.nvim" },
})

require("toggleterm").setup({
    size = 20,
    open_mapping = [[<c-\>]],
    direction = "float",
    float_opts = {
        border = "curved",
    },
})

local Terminal = require('toggleterm.terminal').Terminal

local extension = vim.fn.has("win32") == 1 and ".cmd" or ""
local gitui_path = vim.fn.stdpath("data") .. "/mason/bin/gitui" .. extension

local gitui = Terminal:new({
    cmd = "gitui",
    hidden = true,
    direction = "float",
    close_on_exit = false,
    float_opts = {
        border = "curved",
    },
    on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
    end,
})

function _gitui_toggle()
    gitui:toggle()
end

vim.keymap.set("n", "<leader>gg", "<cmd>lua _gitui_toggle()<CR>",
    { noremap = true, silent = true, desc = "Toggle GitUI" })

vim.pack.add({
    { src = "https://github.com/windwp/nvim-autopairs.git" }
})

require('nvim-autopairs').setup({
    enable_check_bracket_line = true,
    map_cr = true,
})

local Rule = require('nvim-autopairs.rule')

require('nvim-autopairs').add_rules({
    Rule('"""', '"""', 'python'),
    Rule("'''", "'''", 'python'),
})

vim.pack.add({
    { src = "https://github.com/windwp/nvim-ts-autotag.git" },
})

require('nvim-ts-autotag').setup({
    opt = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = true,
    }
})

vim.pack.add({
    { src = "https://github.com/marko-cerovac/material.nvim.git" },
})

require('material').setup({
    contrast = {
        terminal = false,
        sidebars = false,
        floating_windows = false,
        cursor_line = false,
        lsp_virtual_text = false,
    },

    lualine_style = "Stealth",

    disable = {
        background = true,
        colored_cursor = false,
    }
})
vim.cmd 'colorscheme material'

vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter.git" },
})

require('nvim-treesitter').setup({
    ensure_installed = {
        'rust', 'javascript', 'python', 'tsx', 'typescript',
        'zsh', 'astro', 'fish', 'html', 'json',
        'jsx', 'latex', 'lua', 'markdown', 'markdown_inline',
        'css', 'csv'
    },
    highlight = { enable = true },
    indent = { enable = true },
    autotag = { enable = true },
})

vim.pack.add({
    { src = "https://github.com/kevinhwang91/promise-async" }
})

vim.pack.add({
    { src = "https://github.com/kevinhwang91/nvim-ufo" }
})

local status, ufo = pcall(require, "ufo")

if not status then
    return
end

ufo.setup({
    provider_selector = function(bufnr, filetype, buftype)
        return { 'treesitter', 'indent' }
    end
})

vim.keymap.set('n', 'zR', ufo.openAllFolds, { desc = "Open all folds" })
vim.keymap.set('n', 'zM', ufo.closeAllFolds, { desc = "Close all folds" })
vim.keymap.set('n', 'zr', ufo.openFoldsExceptKinds, { desc = "Open folds except kinds" })
vim.keymap.set('n', 'zm', ufo.closeFoldsWith, { desc = "Close folds with" })

vim.pack.add({
    { src = 'https://github.com/neovim/nvim-lspconfig' },
})

vim.pack.add({
    { src = "https://github.com/stevearc/conform.nvim" }
})

require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },

        python = { "isort", "black" },

        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },

        ["*"] = { "codespell" },
    },
    format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
    }
})

vim.pack.add({
    { src = "https://github.com/JoosepAlviste/nvim-ts-context-commentstring" }
})

require('ts_context_commentstring').setup {
    enable_autocmd = false,
}

vim.pack.add({
    { src = "https://github.com/numToStr/Comment.nvim" }
})

require('Comment').setup({
    pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
})

vim.pack.add({
    { src = "https://github.com/kylechui/nvim-surround" }
})

require("nvim-surround").setup({})

vim.pack.add({
    { src = "https://github.com/NvChad/nvim-colorizer.lua" }
})

require('colorizer').setup({
    filetypes = { "*" },
    user_default_options = {
        tailwind = true,
        css = true,
        names = false,
    }
})

vim.pack.add({
    { src = "https://github.com/folke/trouble.nvim" }
})

require("trouble").setup({
    icons = true,
})

-- 快捷键推荐
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
