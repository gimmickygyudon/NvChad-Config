require "nvchad.options"

-- add yours here!

local o = vim.o
local g = vim.g
local opt = vim.opt

o.cursorlineopt ='both' -- to enable cursorline!
o.guifont = "JetBrainsMono Nerd Font:h11"
vim.g.neovide_scale_factor = 1.0
g.neovide_scroll_animation_length = 0.1
opt.wrap = false
