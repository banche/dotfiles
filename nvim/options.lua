require "nvchad.options"

-- add yours here!
vim.opt.swapfile = false

local vopt = vim.opt
-- display
vopt.showmode = true
vopt.cursorline = true

-- code formatting
vopt.tabstop = 4
vopt.shiftwidth = 4
vopt.smarttab = true
vopt.expandtab = true
vopt.softtabstop = 4

-- do not append a new line at the end 
vopt.fixendofline = false

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
