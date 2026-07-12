return {
  {
    "mason-org/mason.nvim",
    opts = {
        registries = {
          "github:mason-org/mason-registry",
          -- "lua:mason_registry", -- "custom-registry" here is what you'd pass to require() the index module (see 1) above)
        }
    }
  },
  {
    "neovim/nvim-lspconfig",
    config = function ()
      vim.lsp.config('ruff', {
        init_options = {
          settings = {
            logLevel = 'debug',
          }
        }
      })
      vim.lsp.enable('ruff')
      vim.diagnostic.config({
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
        signs = true,        -- Show signs in the gutter
        underline = false,    -- Underline problematic text
        update_in_insert = false, -- Don't update diagnostics while typing
        severity_sort = true,
      })
    end,
    opts = {
      inlay_hints = { enabled = true },
    }
  },
  { 
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      { "neovim/nvim-lspconfig" },
    },
    opts = {
      ensure_installed = {
        "jsonls",
        "rust_analyzer",
        -- "r_language_server",
        "bashls",
        "ruff",
        -- "awk_ls",
        "html",
        "julials",
        "nextflow_ls",
        "ts_ls",
        "yamlls",
      },
    },
  },
}


-- return {
--   {
--     "neovim/nvim-lspconfig",
--     config = function ()
--       vim.lsp.enable('ruff')
--       require('lspconfig').ruff.setup {
--         init_options = {
--           settings = {
--             logLevel = 'debug',
--           }
--         }
--       }
--     end
--   }
-- }
