local opts = require("nvchad.configs.cmp")
local cmp = require "cmp"

opts.completion = {
  completeopt = 'menu,menuone,noinsert,noselect',
  keyword_length = 0,
}


opts.mapping = {
  ["<Up>"] = cmp.mapping.select_prev_item(),
  ["<Down>"] = cmp.mapping.select_next_item(),
  ['<C-Space>'] = cmp.mapping.complete(),
  ['<C-e>'] = cmp.mapping.close(),
  ["<Tab>"] = cmp.mapping.confirm {
    behavior = cmp.ConfirmBehavior.Replace,
    select = true,
  },
  ["<CR>"] = cmp.mapping(function(fallback)
    if cmp.visible() and cmp.get_active_entry() then
      cmp.confirm({ select = false }) -- Confirm only if actively selected
    else
      fallback() -- Creates new line
      vim.schedule(function()
        cmp.complete() -- Shows suggestions after new line
      end)
    end
  end, { "i", "s" }),
  ["<Esc>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      local entry = cmp.get_selected_entry()
      if entry then
        -- Get current cursor position and line
        local cursor = vim.api.nvim_win_get_cursor(0)
        local line = vim.api.nvim_get_current_line()
        local word_len = #entry.completion_item.label
        local col = cursor[2]
        -- Get indent level
        local indent = string.match(line, "^%s+") or ""
        local indent_len = #indent
        -- Calculate start position while preserving indent
        local start_pos = col - word_len + 1
        if start_pos < indent_len then start_pos = indent_len end
        -- Create new line preserving indent
        local new_line = indent .. line:sub(indent_len + 1, start_pos) .. line:sub(col + 1)
        vim.api.nvim_set_current_line(new_line)
          -- Reset cursor position
        vim.api.nvim_win_set_cursor(0, {cursor[1], start_pos})
      end
      cmp.close()
      return -- Stay in insert mode by not calling fallback
    end
    fallback()
  end, { "i" })
}

opts.experimental = {
  ghost_text = true
}

opts.sources = {
  { name = "copilot", group_index = 2 },
  { name = "nvim_lsp", group_index = 2 },
  { name = "luasnip", group_index = 2 },
  { name = "buffer", group_index = 2 },
  { name = "nvim_lua", group_index = 2 },
  { name = "path", group_index = 2 },
}

-- Dart-specific configuration
cmp.setup.filetype('dart', {
  sources = {
    { name = "copilot", group_index = 2 },
    { name = "nvim_lsp", group_index = 2 },
    { name = "path", group_index = 2 },
  }
})

return opts
