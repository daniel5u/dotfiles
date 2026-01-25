local keymap = vim.keymap.set
local s = { silent = true }
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "

keymap("n", "<space>", "<Nop>")
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "<Leader>w", "<cmd>w!<CR>", s)
keymap("n", "<Leader>q", "<cmd>q<CR>", s)
keymap("n", "<Leader>te", "<cmd>tabnew<CR>", s)
keymap("n", "<Leader>_", "<cmd>vsplit<CR>", s)
keymap("n", "<Leader>-", "<cmd>split<CR>", s)
keymap("n", "<Leader>1", "1gt")
keymap("n", "<Leader>2", "2gt")
keymap("n", "<Leader>3", "3gt")
keymap("n", "<Leader>4", "4gt")
keymap("n", "<Leader>5", "5gt")
keymap("n", "<Leader>6", "6gt")
keymap("n", "<Leader>7", "7gt")
keymap("n", "<Leader>fo", ":lua vim.lsp.buf.format()<CR>", s)
keymap("n", "<Leader>ps", "<cmd>lua vim.pack.update()<CR>")
keymap("n", "<Leader>ee", "<cmd>Lexplore %:p:h<CR>")
keymap("n", "<Leader>ff", "<cmd>FzfLua files<CR>")
keymap("n", "<Leader>fg", "<cmd>FzfLua live_grep<CR>")
keymap("n", "<Leader>gg", "<cmd>lua _gitui_toggle()<CR>", { noremap = true, silent = true, desc = "Toggle GitUI" })
keymap("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
keymap("v", "<Leader>p", '"_dP')
keymap("x", "y", [["+y]], s)
keymap("t", "<Esc>", "<C-\\><C-N>")

keymap("n", "gtd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
