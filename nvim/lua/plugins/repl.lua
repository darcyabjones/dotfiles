return {
  -- slime (REPL integration)
  {
    "jpalardy/vim-slime",
    init = function()
      vim.g.slime_no_mappings = 1
      vim.g.slime_target = "tmux"
      vim.g.slime_bracketed_paste = 1
      vim.g.slime_default_config = { socket_name = "default", target_pane = "{last}", }
    end,
    config = function()
      -- Usage: <Leader>s followed by a textobject (e.g., <Leader>saf to send a function)

      vim.keymap.set("n", "<Leader>sc", "<Plug>SlimeConfig<cr>", { remap = true, desc = "Slime Send Motion" })
      vim.keymap.set("n", "<Leader>s", "<Plug>SlimeMotionSend", { remap = true, desc = "Slime Send Motion" })
      vim.keymap.set("x", "<Leader>s", "<Plug>SlimeRegionSend", { remap = true, desc = "Slime Send Region" })
      vim.keymap.set("n", "<Leader>ss", "0<Plug>SlimeMotionSend$", { remap = true, desc = "Slime Send Paragraph" })

      -- Run the whole file
      vim.keymap.set("n", "<Leader>Sa", "gg<Plug>SlimeMotionSendG")
      vim.keymap.set("n", "<Leader>Sb", "<Plug>SlimeMotionSendgg")
      vim.keymap.set("n", "<Leader>Sn", "<Plug>SlimeMotionSendG")

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(opts)

          -- Custom function to grab and send code blocks via Treesitter
          local function send_markdown_blocks(mode)
            local bufnr = opts.buf
            local ok, parser = pcall(vim.treesitter.get_parser, bufnr, "markdown")
            if not ok then return end

            local tree = parser:parse()[1]
            local root = tree:root()

            local query = vim.treesitter.query.parse("markdown", [[
            (fenced_code_block) @block
            ]])

            local cursor_row = vim.api.nvim_win_get_cursor(0)[1] - 1
            local parsed_blocks = {}
            local available_langs = {}

            -- 1. Extract all blocks, check for eval=false, and clean language names
            for _, node in query:iter_captures(root, bufnr, 0, -1) do
              local start_row, _, end_row, _ = node:range()
              local info_string = ""
              local code_text = ""

              for child in node:iter_children() do
                if child:type() == "info_string" then
                  info_string = vim.treesitter.get_node_text(child, bufnr)
                elseif child:type() == "code_fence_content" then
                  code_text = vim.treesitter.get_node_text(child, bufnr)
                end
              end

              -- Skip block if the info string contains eval=false
              if not string.match(info_string, "eval%s*=%s*false") then

                -- Extract base language: matches the first block of word characters
                -- Handles "python eval=false", "{python eval=false}", or just "python"
                local lang = string.match(info_string, "[%a_+-]+") or "unmarked"

                if not vim.tbl_contains(available_langs, lang) and code_text ~= "" then
                  table.insert(available_langs, lang)
                end

                table.insert(parsed_blocks, {
                  lang = lang,
                  text = code_text,
                  start_row = start_row,
                  end_row = end_row
                })
              end
            end

            if #parsed_blocks == 0 then
              print("No executable code blocks found.")
              return
            end

            -- Helper to execute the filtered blocks
            local function execute_blocks(selected_lang)
              local blocks_to_send = {}
              for _, block in ipairs(parsed_blocks) do
                if block.lang == selected_lang then
                  local should_add = false
                  if mode == "all" then
                    should_add = true
                  elseif mode == "before" and block.end_row < cursor_row then
                    should_add = true
                  elseif mode == "after" and block.start_row > cursor_row then
                    should_add = true
                  end

                  if should_add then
                    vim.fn["slime#send"](block.text)
                    table.insert(blocks_to_send, block.text)
                  end
                end
              end

              if #blocks_to_send == 0 then
                print("No matching blocks found for " .. selected_lang)
                return
              end

              --local text_to_send = table.concat(blocks_to_send, "\n") .. "\n"
              --vim.fn["slime#send"]("\n")
            end

            -- 2. Auto-select if only one language exists, otherwise prompt
            if #available_langs == 1 then
              execute_blocks(available_langs[1])
            else
              vim.ui.select(available_langs, {
                prompt = "Select language to send to REPL:",
              }, function(selected_lang)
                if selected_lang then execute_blocks(selected_lang) end
              end)
            end
          end

          -- send a single block.
          vim.keymap.set("n", "<Leader>ss", "<Plug>SlimeMotionSendib", { remap = true, desc = "Slime Send Paragraph" })

          -- New custom Treesitter block senders
          vim.keymap.set("n", "<Leader>Sa", function() send_markdown_blocks("all") end, { 
          buffer = opts.buf, 
          desc = "Send All Code Blocks" 
        })
        vim.keymap.set("n", "<Leader>Sb", function() send_markdown_blocks("before") end, { 
        buffer = opts.buf, 
        desc = "Send Blocks Before Cursor" 
      })
      vim.keymap.set("n", "<Leader>Sn", function() send_markdown_blocks("after") end, { 
      buffer = opts.buf, 
      desc = "Send Blocks After Cursor" 
    })
  end,
})
    end,
  },
}


