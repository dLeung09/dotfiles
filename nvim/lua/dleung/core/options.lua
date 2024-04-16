local opt = vim.opt

-- line numbers
opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- line wrapping at 132 characters (width of NVIM buffer with file explorer open, with about 4 characters gap)
opt.wrap = true
opt.linebreak = true
opt.textwidth = 132

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- cursor line
opt.cursorline = true

-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

opt.iskeyword:append("-")

-- Use persistent history
opt.undofile = true

-- For Obsidian UI Support
opt.conceallevel = 2

-- Default is 4 seconds, setting to 0.3s makes code completion more responsive since it will trigger intellisense faster
opt.updatetime = 300

-- This is for newly opened files to use the proper format options
vim.api.nvim_create_augroup('FormatOptions', { clear = true })
vim.api.nvim_create_autocmd('BufEnter', { pattern = "*", group = 'FormatOptions', command = 'setlocal formatoptions=lctqj' })

-- No sounds
opt.visualbell = true
opt.confirm = true
opt.hidden = true
opt.mouse = 'a'

-- Display tabs
opt.list = true
opt.listchars = 'tab:> ,trail:-,extends:>,precedes:<,nbsp:+'

-- For heavy pinkies
vim.cmd('command! Q q')
vim.cmd('command! W w')
vim.cmd('command! Wa wa')
vim.cmd('command! Wq wq')
vim.cmd('command! X x')

-- For improved startup times?
vim.g.signify_skip = { vcs = { allow = { 'git', 'svn' }}}

local tabwidth = 4
opt.tabstop = tabwidth
opt.softtabstop = tabwidth
opt.shiftwidth = tabwidth
opt.expandtab = true

opt.signcolumn = 'number'

