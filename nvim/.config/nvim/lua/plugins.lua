return require("packer").startup({
  function(use)
    use({

      "junegunn/fzf.vim",
      "neovim/nvim-lspconfig",
      "nvim-lua/plenary.nvim",
      "romainl/vim-qf",
      "tpope/vim-commentary",
      "tpope/vim-rhubarb",
      "tpope/vim-sleuth",
      "tpope/vim-surround",
      "tpope/vim-unimpaired",
      "tpope/vim-vinegar",
      "wbthomason/packer.nvim",

      require("theme"),
      require("treesitter"),

      { "asheq/close-buffers.vim", cmd = "Bdelete" },
      { "bronson/vim-visual-star-search", keys = "*" },
      { "junegunn/vim-easy-align", keys = { "<Plug>(EasyAlign)" } },
      { "phaazon/hop.nvim", cmd = { "HopWord", "HopLineStart", "HopChar2" } },
      { "simnalamburt/vim-mundo", cmd = "MundoToggle" },
      { "szw/vim-maximizer", cmd = "MaximizerToggle" },
      { "tpope/vim-fugitive", event = "CursorHold" },
      { "tpope/vim-repeat", event = "CursorHold" },
      { "windwp/nvim-ts-autotag", event = "CursorHold" },

      {
        "dstein64/nvim-scrollview",
        config = function()
          vim.cmd("highlight link ScrollView PMenuSBar")
          vim.g.scrollview_winblend = 70
        end,
      },

      {
        "rmagatti/auto-session",
        config = function()
          require("auto-session").setup({
            log_level = "error",
          })
        end,
      },

      {
        "airblade/vim-rooter",
        config = function()
          vim.g.rooter_silent_chdir = 1
        end,
      },

      {
        "rrethy/vim-hexokinase",
        run = "make hexokinase",
        event = "CursorHold",
        config = function()
          vim.g.Hexokinase_optInPatterns = "full_hex,rgb,rgba,hsl,hsla"
          vim.g.Hexokinase_virtualText = "▮"
        end,
      },

      {
        "lukas-reineke/indent-blankline.nvim",
        event = "CursorHold",
        config = function()
          vim.g.indent_blankline_char = "▏"
          vim.g.indent_blankline_filetype_exclude = { "help", "markdown" }
          vim.g.indent_blankline_show_trailing_blankline_indent = false
          vim.g.indent_blankline_use_treesitter = true
        end,
      },

      {
        "tversteeg/registers.nvim",
        event = "InsertEnter",
        keys = '"',
        config = function()
          vim.g.registers_window_border = "single"
          vim.g.registers_window_max_width = 150
        end,
      },

      {
        "iamcco/markdown-preview.nvim",
        run = "cd app && yarn install",
        cmd = "MarkdownPreview",
      },

      {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
          require("nvim-autopairs").setup()
        end,
      },

      {
        "lewis6991/gitsigns.nvim",
        config = function()
          require("gitsigns").setup({
            current_line_blame = true,
            current_line_blame_opts = {
              delay = 100,
            },
            current_line_blame_formatter = function(name, blame_info, opts)
              if blame_info.author == name then
                blame_info.author = "You"
              end

              local text
              if blame_info.author == "Not Committed Yet" then
                text = blame_info.author
              else
                local date_time

                if opts.relative_time then
                  date_time = require("gitsigns.util").get_relative_time(
                    tonumber(blame_info["author_time"])
                  )
                else
                  date_time = os.date("%Y-%m-%d", tonumber(blame_info["author_time"]))
                end

                text = string.format(
                  "      %s | %s | %s",
                  blame_info.author,
                  date_time,
                  blame_info.summary
                )
              end

              return { { " " .. text, "GitSignsCurrentLineBlame" } }
            end,
            current_line_blame_formatter_opts = {
              relative_time = true,
            },
            signs = {
              add = { text = "+" },
              change = { text = "~" },
              delete = { text = "_" },
              topdelete = { text = "‾" },
            },
          })
        end,
      },

      {
        "neoclide/coc.nvim",
        branch = "release",
        config = function()
          vim.g.coc_global_extensions = {
            "coc-css",
            "coc-diagnostic",
            "coc-eslint",
            "coc-html",
            "coc-json",
            "coc-lua",
            "coc-prettier",
            "coc-snippets",
            "coc-styled-components",
            "coc-stylelintplus",
            "coc-tsserver",
          }
        end,
      },
    })
  end,
})
