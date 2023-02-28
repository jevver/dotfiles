require("plugin")
require("autocommands")
require("tabline")

vim.opt.cmdheight = 0
vim.opt.expandtab = true
vim.opt.fillchars = "eob: "
vim.opt.gdefault = true
vim.opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.inccommand = "split"
vim.opt.matchpairs:append("<:>")
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 5
vim.opt.sessionoptions = { "buffers", "folds", "tabpages" }
vim.opt.shiftround = true
vim.opt.shortmess:append("ctFTI")
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.undofile = true

vim.cmd.inoreabbrev({
  "<expr>",
  "DATE",
  "strftime('%Y.%m.%d | %A | %H:%M')",
})
