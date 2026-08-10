return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({
        "bash",
        "c",
        "diff",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "printf",
        "python",
        "query",
        "r",
        "regex",
        "rust",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
        "zsh",
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    init = function()
      -- Disable entire built-in ftplugin mappings to avoid conflicts.
      -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
      vim.g.no_plugin_maps = true
    end,
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = {
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = false,
          -- You can choose the select mode (default is charwise 'v')
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * method: eg 'v' or 'o'
          -- and should return the mode ('v', 'V', or '<c-v>') or a table
          -- mapping query_strings to modes.
          selection_modes = {
            ['@parameter.outer'] = 'v', -- charwise
            ['@function.outer'] = 'V', -- linewise
            -- ['@class.outer'] = '<c-v>', -- blockwise
          },
          -- If you set this to `true` (default is `false`) then any textobject is
          -- extended to include preceding or succeeding whitespace. Succeeding
          -- whitespace has priority in order to act similarly to eg the built-in
          -- `ap`.
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * selection_mode: eg 'v'
          -- and should return true of false
          --include_surrounding_whitespace = function(opts)
          --  if opts.query_string == "@code_block.inner" then
          --    return true
          --  end
          --  return false
          --end,
          include_surrounding_whitespace=false,
        },
        move = {
          -- whether to set jumps in the jumplist
          set_jumps = true,
        },
      })

      -- select
      vim.keymap.set({ "x", "o" }, "af", function()
        require "nvim-treesitter-textobjects.select".select_textobject("@function.outer", "textobjects")
      end)
      vim.keymap.set({ "x", "o" }, "if", function()
        require "nvim-treesitter-textobjects.select".select_textobject("@function.inner", "textobjects")
      end)
      vim.keymap.set({ "x", "o" }, "ac", function()
        require "nvim-treesitter-textobjects.select".select_textobject("@class.outer", "textobjects")
      end)
      vim.keymap.set({ "x", "o" }, "ic", function()
        require "nvim-treesitter-textobjects.select".select_textobject("@class.inner", "textobjects")
      end)
      vim.keymap.set({ "x", "o" }, "ab", function()
        require "nvim-treesitter-textobjects.select".select_textobject("@code_block.outer", "textobjects")
      end)
      vim.keymap.set({ "x", "o" }, "ib", function()
        require "nvim-treesitter-textobjects.select".select_textobject("@code_block.inner", "textobjects")
      end)
      vim.keymap.set({ "x", "o" }, "as", function()
        require "nvim-treesitter-textobjects.select".select_textobject("@local.outer", "locals")
      end)
      vim.keymap.set({ "x", "o" }, "is", function()
        require "nvim-treesitter-textobjects.select".select_textobject("@local.inner", "locals")
      end)

      -- swap
      vim.keymap.set("n", "<leader>a", function()
        require("nvim-treesitter-textobjects.swap").swap_next "@parameter.inner"
      end)
      vim.keymap.set("n", "<leader>A", function()
        require("nvim-treesitter-textobjects.swap").swap_previous "@parameter.inner"
      end)

      -- move
      vim.keymap.set({ "n", "x", "o" }, "]f", function()
        require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
      end)
      vim.keymap.set({ "n", "x", "o" }, "]F", function()
        require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
      end)
      vim.keymap.set({ "n", "x", "o" }, "[f", function()
        require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
      end)
      vim.keymap.set({ "n", "x", "o" }, "[F", function()
        require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
      end)

      vim.keymap.set({ "n", "x", "o" }, "]c", function()
        require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
      end)
      vim.keymap.set({ "n", "x", "o" }, "]C", function()
        require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer", "textobjects")
      end)
      vim.keymap.set({ "n", "x", "o" }, "[c", function()
        require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
      end)
      vim.keymap.set({ "n", "x", "o" }, "[C", function()
        require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer", "textobjects")
      end)

      vim.keymap.set({ "n", "x", "o" }, "]b", function()
        require("nvim-treesitter-textobjects.move").goto_next_start("@code_block.outer", "textobjects")
      end)
      vim.keymap.set({ "n", "x", "o" }, "]B", function()
        require("nvim-treesitter-textobjects.move").goto_next_end("@code_block.outer", "textobjects")
      end)
      vim.keymap.set({ "n", "x", "o" }, "[b", function()
        require("nvim-treesitter-textobjects.move").goto_previous_start("@code_block.outer", "textobjects")
      end)
      vim.keymap.set({ "n", "x", "o" }, "[B", function()
        require("nvim-treesitter-textobjects.move").goto_previous_end("@code_block.outer", "textobjects")
      end)

      -- You can also use captures from other query groups like `locals.scm` or `folds.scm`
      vim.keymap.set({ "n", "x", "o" }, "]s", function()
        require("nvim-treesitter-textobjects.move").goto_next_start("@local.scope", "locals")
      end)
      vim.keymap.set({ "n", "x", "o" }, "]S", function()
        require("nvim-treesitter-textobjects.move").goto_previous_start("@local.scope", "locals")
      end)
      vim.keymap.set({ "n", "x", "o" }, "[s", function()
        require("nvim-treesitter-textobjects.move").goto_next_end("@local.scope", "locals")
      end)
      vim.keymap.set({ "n", "x", "o" }, "[S", function()
        require("nvim-treesitter-textobjects.move").goto_previous_end("@local.scope", "locals")
      end)


      vim.keymap.set({ "n", "x", "o" }, "]z", function()
        require("nvim-treesitter-textobjects.move").goto_next_start("@fold", "folds")
      end)
      vim.keymap.set({ "n", "x", "o" }, "[z", function()
        require("nvim-treesitter-textobjects.move").goto_previous_start("@fold", "folds")
      end)

      local ts_repeat_move = require "nvim-treesitter-textobjects.repeatable_move"
      -- vim way: ; goes to the direction you were moving.
      vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
      vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)
    end,
  }
}
