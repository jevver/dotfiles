---@type LazySpec
return {
  "copilotc-nvim/copilotchat.nvim",
  branch = "canary",
  dependencies = {
    { "github/copilot.vim" },
    { "nvim-lua/plenary.nvim" },
  },
  event = { "BufReadPost", "BufNewFile" },
  keys = {
    { "<leader>ac", "<cmd>CopilotChat<cr>", mode = { "x", "n" }, desc = "Open in vertical split" },
    { "<leader>ad", "<cmd>CopilotChatDocs<cr>", desc = "Write docs", mode = { "n", "x" } },
    { "<leader>ae", "<cmd>CopilotChatExplain<cr>", desc = "Explain", mode = { "n", "x" } },
    { "<leader>af", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "Fix diagnostic" },
    { "<leader>an", "<cmd>CopilotChatBetterNamings<cr>", desc = "Better naming", mode = { "n", "x" } },
    { "<leader>ao", "<cmd>CopilotChatOptimize<cr>", desc = "Optimize", mode = { "n", "x" } },
    { "<leader>aR", "<cmd>CopilotChatReset<cr>", desc = "Clear buffer and chat history" },
    { "<leader>ar", "<cmd>CopilotChatReview<cr>", desc = "Review", mode = { "n", "x" } },
    { "<leader>at", "<cmd>CopilotChatTests<cr>", desc = "Generate tests", mode = { "n", "x" } },
  },
  init = function() require("which-key").add({ "<leader>a", group = "AI" }) end,
  config = function()
    local group = vim.api.nvim_create_augroup("copilot", {})
    vim.api.nvim_create_autocmd({ "BufEnter" }, {
      pattern = { "copilot-chat" },
      command = "vertical resize 80",
      group = group,
    })

    require("CopilotChat").setup({
      auto_insert_mode = true,
      context = "buffers",
      show_folds = false,

      mappings = {
        complete = { insert = "" },
      },
    })
  end,
}
