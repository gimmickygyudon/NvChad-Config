local function replace_selected_text()
    -- Get selected text without affecting registers
    vim.cmd('noau normal! "vy"')
    local selected_text = vim.fn.getreg('v')

    -- Get replacement text
    local replacement = vim.fn.input({ prompt = 'Replace with: ' })
    if replacement ~= '' then
        -- Perform global replacement
        vim.cmd([[%s/]] .. vim.fn.escape(selected_text, [[/\]]) .. [[/]] .. replacement .. [[/g]])

        -- Clean up and return to normal mode
        vim.cmd('noh')
        vim.cmd('normal! `<') -- go back to start of selection
        vim.api.nvim_feedkeys(
            vim.api.nvim_replace_termcodes('<esc>', true, false, true),
            'n',
            false
        )
  end
end

return replace_selected_text()
