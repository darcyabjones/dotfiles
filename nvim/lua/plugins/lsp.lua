return {
  { "williamboman/mason.nvim", opts = { ensure_installed = { "json", "pyright", "rust-analyzer", "sqlfluff", "r-languageserver", "bash-language-server" } }},
  { "williamboman/mason-lspconfig.nvim" },
  { "neovim/nvim-lspconfig" }
}
