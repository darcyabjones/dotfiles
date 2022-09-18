-----------------------------------------------------------
-- Treesitter configuration file
----------------------------------------------------------

-- Plugin: nvim-treesitter
-- url: https://github.com/nvim-treesitter/nvim-treesitter


local status_ok, nvim_treesitter = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
  return
end

-- See: https://github.com/nvim-treesitter/nvim-treesitter#quickstart
nvim_treesitter.setup {
  -- A list of parser names, or "all"
  ensure_installed = {
    'bash', 'make',
    'c', 'cpp', 'rust', 'lua',
    'css', 'html', 'javascript', 'typescript',
    'dockerfile',
    'yaml', 'json', 'toml',
    'bibtex', 'latex', 'markdown',
    'python', 'julia', 'perl', 'r', 'sql',
    'vim', 'regex'
  },
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  highlight = {
    -- `false` will disable the whole extension
    enable = true,
  },
  -- Enable = operator indentation fixing
  -- EXPERIMENTAL
  indent = {
    enable = true
  }
}

local opt = vim.opt
opt.foldmethod = "manual"
opt.foldexpr = "nvim_treesitter#foldexpr()"
