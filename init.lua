-- vim mappings
vim.opt.mouse = ""  -- disable mouse
vim.g.mapleader = "\\"
vim.keymap.set("n", "<Tab>", ":bprev<CR>", {noremap = true, silent = true})
vim.keymap.set("n", "<Space>", ":bnext<CR>", {noremap = true, silent = true})
vim.keymap.set("n", "<BS>", ":b#<CR>", {noremap = true, silent = true})
vim.keymap.set("n", "<leader><leader>", ":noh<CR>", {noremap = true, silent = true})
vim.keymap.set("n", "<leader>c", "I# <ESC>j", {noremap = true, silent = true})
vim.keymap.set("n", "x", '"_x', {noremap = true})
vim.keymap.set("n", "X", '"_X', {noremap = true})
vim.keymap.set("v", "x", '"_x', {noremap = true})
vim.keymap.set("n", "<leader>o", "o<ESC>k", {noremap = true, silent = true})
vim.keymap.set("n", "<leader>O", "O<ESC>j", {noremap = true, silent = true})
vim.keymap.set("n", "<leader>b", "oimport ipdb;ipdb.set_trace(context=5)<ESC>", {noremap = true, silent = true})
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>")  -- resize splits
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>")


-- run python file in tmux window 1
vim.api.nvim_set_keymap('n', '<leader>r', '', {
  noremap = true,
  silent = true,
  callback = function()
    local file = vim.fn.expand("%:p")
    local cmd = string.format('tmux select-window -t :1 \\; send-keys "python3 %s" Enter', file)
    vim.fn.jobstart(cmd)
  end,
})

-- vim plugins
require("config.lazy")


local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.lsp.start({
      name = "pylsp",
      cmd = { "pylsp" },
      capabilities = capabilities,
      root_dir = vim.fs.dirname(vim.fs.find({ "pyproject.toml", "setup.py", ".git" }, { upward = true })[1]),
    })
  end,
})

local cmp = require("cmp")
-- lsp autocomplete maps
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })


-- stop underlining warnings
vim.diagnostic.config({
  underline = {
    severity = { min = vim.diagnostic.severity.ERROR },
  },
})

-- vim options
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 4
vim.g.netrw_banner = 0  -- disable netrw banner
vim.opt.wrap = false  -- disable line wrapping
vim.opt.listchars = {tab = ">-", trail = "~", extends = ">", precedes = "<"}
vim.api.nvim_set_hl(0, "Whitespace", { fg = "#00ff00" })  -- bright green listchars
vim.cmd [[highlight MatchParen guibg=#4ECEDF guifg=#000000 gui=bold]]  -- clear blue matching brackets
vim.api.nvim_set_hl(0, 'Search', { bg = '#FFD700', fg = '#000000', bold = true })  -- clear yellow search term highlighting

