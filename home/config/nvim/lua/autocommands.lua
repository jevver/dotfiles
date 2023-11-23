local group = vim.api.nvim_create_augroup("ac", {})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "typescript,typescriptreact",
  group = group,
  command = "compiler tsc | setlocal makeprg=npx\\ tsc\\ --pretty\\ false",
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
  pattern = { "*.{eslint,babel,stylelint,prettier,swc}rc" },
  command = "set ft=json",
  group = group,
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
  pattern = { "*.ain" },
  command = "set ft=dosini",
  group = group,
})

vim.api.nvim_create_autocmd({ "SessionLoadPost", "VimResized" }, {
  command = [[exe ":norm! \<C-W>="]],
  group = group,
})

vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter" }, {
  command = "setlocal cursorline | autocmd WinLeave * setlocal nocursorline",
  group = group,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  command = "setlocal suffixesadd+=.js,.ts,.tsx,.jsx",
  group = group,
})

vim.api.nvim_create_autocmd({ "UIEnter" }, {
  callback = function(data)
    local root = require("mini.misc").find_root(data.buf, { ".git", "package.json" })
    if root ~= nil then
      vim.fn.chdir(root)
    end
  end,
  group = group,
})
