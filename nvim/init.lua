-- TODO:
-- restore session and dashboard and file file/grep from dashboard (https://youtu.be/NkQnPuidxWY?si=QpptKO67ySYQszGv)
--
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true
vim.opt.showmode = false

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- plugins
require("plugins.lazy")

-- encoding
-- vim.o.fileencoding = "utf-8"                  -- the encoding written to a file
-- commented out as this was creating errors on not modifable buffers

-- disable mouse
vim.opt.mouse = ""

-- numbering
vim.o.number = true -- show line numbers
vim.o.numberwidth = 2 -- set number column width to 2 (smart adjusts to more) {default 4}
vim.o.relativenumber = true

-- menu and completion
vim.o.completeopt = "menuone,noselect" -- menuone shows menu even if there is only one match, noselect forces to select manually (does not select by default)
vim.o.updatetime = 250 -- faster completion in coc.nvim by lowering CursorHold
vim.opt.shortmess:append("c") -- do not require enter confirmation for completion errors

-- search
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true -- makes ingorecase smart

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>") -- clear hlsearch on ESC press in normal mode

-- format
-- vim.o.smartindent = true -- is anyone using it with treesitter?
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2

-- history
vim.o.undofile = true

-- moves
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8

-- splits
vim.o.splitbelow = true
vim.o.splitright = true

-- graphics
vim.o.termguicolors = true
vim.o.background = "dark"
vim.o.cursorline = true
-- vim.o.signcolumn = "yes" -- always show signcolumn (git signs etc) even if there is nothing to show
-- vim.o.showtabline = 2 -- always show tabline
-- vim.o.guifont = SOMEFONT

-- ################################################################ keymaps
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true }) -- clear mappings from space
-- vim.keymap.set("n", "<leader>e", ":Lex 30<cr>", { desc = 'Open file explorer' }) -- commented out because I am using nvim tree

vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Resize with arrows
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>")
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>")

-- Be able to increment when <C-a> is taken by tmux. Rebing <C-x> for consistency
vim.keymap.set({ "n", "v" }, "<A-a>", "<C-a>")
vim.keymap.set({ "n", "v" }, "<A-x>", "<C-x>")

-- Keymaps for better default experience

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- trying to get sane base64 decode/encode

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
