require "nvchad.mappings"

local map = vim.keymap.set
local copilot = require("CopilotChat")
local copilotSelect = require("CopilotChat.select")
local copilotActions = require("CopilotChat.actions")
local bufferSelect = require "functions.text.selected"


map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map("n", "<C-t>", function()
  require("nvchad.themes").open()
end, {})

map({"n", "i"}, "<A-Left>", "<C-w>h", { desc = "Move to left window" })
map({"n", "i"}, "<A-Down>", "<C-w>j", { desc = "Move to bottom window" })
map({"n", "i"}, "<A-Up>", "<C-w>k", { desc = "Move to top window" })
map({"n", "i"}, "<A-Right>", "<C-w>l", { desc = "Move to right window" })
map("n", "<C-q>", "<cmd> q <cr>", { desc = "Close window" })
map("n", "<C-w>s", "<cmd> split <cr>", { desc = "Split window horizontally" })
map("v", "<C-r>", function()
  require "functions.text.replace"
end, { desc = "Replace all occurrences with prompted input" })


-- Terminal Configuration
map({ "n", "t" }, "<A-i>", function()
    require("nvchad.term").toggle { pos = "float", id = "floatTerm", float_opts={
        row = 0.25,
        col = 0.25,
        width = 0.5,
        height = 0.5
    }}
end, { desc = "terminal toggle floating term" })
-- Terminal Configuration


-- Volt Menu
map("n", "<C-x>", function()
  require("menu").open "default"
end, {})

map("n", "<RightMouse>", function()
  vim.cmd.exec '"normal! \\<RightMouse>"'

  local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
  require("menu").open(options, { mouse = true })
end, {})
-- Volt Menu


-- Copilot Chat
map({"n", "v"}, '<leader>ccq', function()
  local input = vim.fn.input("Quick Chat: ")

  local selection = { selection = copilotSelect.visual }

  print(bufferSelect)

  if input ~= "" then
    if bufferSelect ~= "" then
      copilot.ask(input, selection)
    else
      copilot.ask(input)
    end
  end
end, {
  desc = "Copilot - Quick chat"
})

map({"v"}, "<leader>cca", function()
  copilotActions.pick(copilotActions.prompt_actions({
    selection = copilotSelect.visual,
  }))
end, {
  desc = "Copilot - Selection chat"
})

map("n", "<leader>ccp", function()
    require("CopilotChat.integrations.telescope").pick(copilotActions.prompt_actions())
end, {
  desc = "CopilotChat - Prompt actions",
})
-- Copilot Chat

-- Code Actions
map('n', '<C-.>', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })

