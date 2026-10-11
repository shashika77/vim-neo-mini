require "nvchad.options"

local o = vim.opt

-- Your custom options
vim.o.spell = true
vim.o.termguicolors = true

-- Line numbers (must use vim.opt to override NvChad defaults)
o.number = true           -- Show absolute line number on current line
o.relativenumber = true   -- Show relative line numbers
o.cursorline = true       -- Highlight current line
o.signcolumn = "yes"      -- Always show sign column (for breakpoints, git, etc.)
o.numberwidth = 4         -- Width of line number column

-- Consistent automatic indentation across languages (2 spaces by default).
o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.softtabstop = 2
o.autoindent = true
o.smartindent = true
o.breakindent = true

-- Common language conventions: Python/Rust use four spaces, Go uses tabs,
-- and Makefiles require literal tabs.
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python", "rust" },
  callback = function(args)
    vim.bo[args.buf].expandtab = true
    vim.bo[args.buf].shiftwidth = 4
    vim.bo[args.buf].tabstop = 4
    vim.bo[args.buf].softtabstop = 4
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function(args)
    vim.bo[args.buf].expandtab = false
    vim.bo[args.buf].shiftwidth = 4
    vim.bo[args.buf].tabstop = 4
    vim.bo[args.buf].softtabstop = 0
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "make",
  callback = function(args)
    vim.bo[args.buf].expandtab = false
    vim.bo[args.buf].shiftwidth = 8
    vim.bo[args.buf].tabstop = 8
    vim.bo[args.buf].softtabstop = 0
  end,
})
