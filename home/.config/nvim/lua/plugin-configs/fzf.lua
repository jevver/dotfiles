return function()
  local actions = require("fzf-lua.actions")
  local history_dir = vim.fn.expand("~/.local/share/nvim")

  require("fzf-lua").setup({
    fzf_opts = {
      ["--history"] = history_dir .. "/" .. "fzf_history",
    },
    winopts = {
      height = 0.6,
      width = 0.7,
      preview = {
        vertical = "down:0%",
        horizontal = "right:40%",
        flip_columns = 180,
        scrollchars = { "▌" },
        winopts = {
          number = false,
          cursorline = false,
        },
      },
    },
    keymap = {
      builtin = {
        ["K"] = "preview-page-up",
        ["J"] = "preview-page-down",
      },
    },
    files = {
      file_icons = false,
      prompt = "Files ",
    },
    grep = {
      file_icons = false,
      no_header = true,
      prompt = "Grep ",
    },
    git = {
      icons = {
        ["M"] = { icon = "𝒎" },
        ["D"] = { icon = "𝒅" },
        ["A"] = { icon = "𝒂" },
        ["R"] = { icon = "𝒓" },
        ["C"] = { icon = "𝙘" },
        ["T"] = { icon = "𝙩" },
        ["?"] = { icon = "𝙪" },
      },
    },
    buffers = {
      prompt = "Buffers ",
      actions = {
        ["ctrl-d"] = { actions.buf_del, actions.resume },
      },
    },
  })
end
