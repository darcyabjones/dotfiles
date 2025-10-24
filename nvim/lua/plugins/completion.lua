return {
  {
    'saghen/blink.cmp',
    version = '1.*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = {
        preset = 'default',
        ['<C-n>'] = { 'select_next', 'show_and_insert_or_accept_single', 'fallback_to_mappings' },
        ['<C-p>'] = { 'select_prev', 'show_and_insert_or_accept_single', 'fallback_to_mappings' },
    },
  
      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono'
      },
      signature = {
        enabled = true,
        trigger = { show_on_keyword = true },
        window = { show_documentation = false },
      },
      -- (Default) Only show the documentation popup when manually triggered
      completion = {
        trigger = { show_on_keyword = true },
        documentation = { auto_show = true },
        ghost_text = { enabled = true, show_with_menu = false },
        list = {
          selection = { preselect = true, auto_insert = true },
        },
        menu = {
          auto_show = false,
          draw = {
            -- columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind", "source_name", gap = 1} },
            treesitter = { "lsp" },
          },
        },
        accept = { auto_brackets = { enabled = false }, },
      },
  
      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
  },
  {"xzbdmw/colorful-menu.nvim"},
}
