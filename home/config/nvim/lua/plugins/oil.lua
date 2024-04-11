return {
  "stevearc/oil.nvim",
  cmd = "Oil",
  keys = {
    { "-", ":Oil<CR>", desc = "File browser", silent = true },
    { "<C-h>", ":Oil<CR>", desc = "File browser", silent = true },
  },
  opts = {
    default_file_explorer = true,
    delete_to_trash = true,
    experimental_watch_for_changes = true,
    win_options = {
      number = false,
      relativenumber = false,
      signcolumn = "yes",
    },
    keymaps = {
      ["q"] = "actions.close",
      ["<C-l>"] = "actions.select",
      ["<C-h>"] = "actions.parent",
      ["<C-k>"] = "k",
      ["<C-j>"] = "j",
    },
    skip_confirm_for_simple_edits = true,
    view_options = {
      show_hidden = true,
      is_always_hidden = function(name)
        local alwaysHidden = { "..", ".DS_Store" }
        for _, value in ipairs(alwaysHidden) do
          if name == value then
            return true
          end
        end
        return false
      end,
    },
  },
}
