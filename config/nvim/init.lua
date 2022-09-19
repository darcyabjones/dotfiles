require("packer_init")
require("plugins/nvim-cmp")
require("plugins/nvim-treesitter")
require("plugins/sniprun")
require("plugins/nvim-tree")
require("plugins/nvim-lspconfig")

local o = vim.o
local wo = vim.wo
local bo = vim.bo

-- vim.opt.termguicolors = true
-- o.term = "xterm-256color"

o.swapfile = true
o.dir = '/tmp'

-- mouse stuff
vim.opt.mouse = 'a'

-- line numbers
o.number = true
vim.opt.ruler = true

-- Refresh rate in milliseconds
vim.opt.updatetime = 250

-- do incremental searching
vim.opt.incsearch = true

-- display incomplete commands
vim.opt.showcmd = true

-- this enables "visual" wrap
wo.wrap = true

-- make it obvious where 80 chars is
wo.colorcolumn = 80

-- this turns off physical line wrapping (ie: automatic insertion of newlines)
vim.opt.textwidth=0
vim.opt.wrapmargin=0

vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.wildmenu = true

wo.list = true
vim.opt.listchars = { tab = '˒ ', trail = '-' }

vim.cmd[[colorscheme dracula]]

-- Indentation defaults
-- by default, the indent is 4 spaces.
bo.shiftwidth = 4
bo.softtabstop = 4
bo.tabstop = 4
bo.expandtab = true

vim.cmd [[
  autocmd Filetype html setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  autocmd Filetype yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  autocmd Filetype toml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  autocmd Filetype json setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  autocmd Filetype lua setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  autocmd Filetype rust setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  autocmd Filetype r setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
]]

wo.nocompatible = true

home = os.getenv("HOME")
in_wsl = os.getenv("WSL_DISTRO_NAME") ~= nil
vim.opt.clipboard = 'unnamedplus'

if in_wsl then
  vim.g.clipboard = {
    name = 'wsl clipboard',
    copy =  { ["+"] = { "clip.exe" },   ["*"] = { "clip.exe" } },
    paste = { ["+"] = { home .. "/.dotfiles/bin/nvim_paste.sh" }, ["*"] = { home .. "/.dotfiles/bin/nvim_paste.sh" } },
    cache_enabled = true
  }
end

in_tmux = os.getenv("TMUX") ~= nil
