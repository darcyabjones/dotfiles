vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- mouse stuff
vim.opt.mouse = 'a'
vim.opt.encoding = 'utf-8'
vim.opt.swapfile = true

vim.o.number = true
vim.opt.ruler = true
vim.wo.colorcolumn = '80'

vim.wo.wrap = true
-- this turns off physical line wrapping (ie: automatic insertion of newlines)
vim.opt.textwidth = 0
vim.opt.wrapmargin = 0

-- Update refreshtime in milliseconds
vim.opt.updatetime = 250

-- Do incremental searches
vim.opt.incsearch = true
vim.opt.showcmd = true

vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.wildmenu = true


-- Show some hidden characters
vim.wo.list = true
vim.opt.listchars = { tab = '˒ ', trail = '-'  }


-- Indentation defaults
vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4
vim.bo.tabstop = 4
vim.bo.expandtab = true

-- Indentation
vim.cmd [[
  autocmd Filetype html setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  autocmd Filetype yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  autocmd Filetype toml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  autocmd Filetype json setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  autocmd Filetype lua setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  autocmd Filetype rust setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  autocmd Filetype r setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
]]

-- Clipboard
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


require("config.lazy")
