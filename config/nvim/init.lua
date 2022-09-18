require("packer_init")
require("plugins/nvim-cmp")
require("plugins/nvim-treesitter")
require("plugins/sniprun")
require("plugins/nvim-tree")
require("plugins/nvim-lspconfig")

local o = vim.o
local wo = vim.wo
local bo = vim.bo

o.swapfile = true
o.dir = '/tmp'

wo.number = true

bo.expandtab = true


vim.cmd[[colorscheme dracula]]


