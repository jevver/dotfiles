return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "jose-elias-alvarez/null-ls.nvim",
    "lukas-reineke/lsp-format.nvim",
    "nvim-lua/plenary.nvim",
    "hoffs/omnisharp-extended-lsp.nvim",
    { "j-hui/fidget.nvim", tag = "legacy" },
  },
  config = function()
    vim.diagnostic.config({
      float = { source = true },
      severity_sort = true,
      virtual_text = false,
    })

    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local lsp = require("lspconfig")
    local lspformat = require("lsp-format")
    local map = require("which-key").register
    local null_ls = require("null-ls")
    local json_schemas = require("schemastore").json.schemas({})
    require("fidget").setup({})

    lspformat.setup({ sync = true })

    local on_attach = function(client, bufnr)
      lspformat.on_attach(client)

      if client.name == "eslint" then
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          command = "EslintFixAll",
        })
      end

      map({
        buffer = bufnr,
        name = "LSP",
        K = { vim.lsp.buf.hover, "Show docs" },
        ["<space>"] = {
          p = { vim.diagnostic.goto_prev, "Previous diagnostic" },
          n = { vim.diagnostic.goto_next, "Next diagnostic" },
          r = {
            { vim.lsp.buf.rename, "Rename word", mode = "n" },
            { '"sy:%s/<C-r>s//c <Left><Left><Left>', "Replace selection", mode = "x" },
          },
          q = {
            "<cmd>TroubleToggle workspace_diagnostics<cr>",
            "Diagnostics",
          },
          l = {
            name = "LSP",
            a = { vim.lsp.buf.code_action, "Code action" },
            q = { vim.diagnostic.setloclist, "Send diagnostics to quickfix" },
            d = { "<cmd>TroubleToggle lsp_definitions<cr>", "Go to definition" },
            D = { vim.lsp.buf.declaration, "Go to declaration" },
            i = { "<cmd>TroubleToggle lsp_implementations<cr>", "Go to implementation" },
            f = {
              {
                mode = "n",
                function()
                  vim.lsp.buf.format({ async = true })
                end,
                "Format buffer",
              },
            },
            r = { "<cmd>TroubleToggle lsp_references<cr>", "References" },
            t = { "<cmd>TroubleToggle lsp_type_definitions<cr>", "Go to type definition" },
          },
        },
      })
    end

    local default_config = { capabilities = capabilities, on_attach = on_attach }

    lsp.cssls.setup(default_config)
    lsp.eslint.setup(default_config)
    lsp.html.setup(default_config)
    lsp.pyright.setup(default_config)
    lsp.taplo.setup(default_config)
    lsp.yamlls.setup(default_config)

    local function extend_config(extension)
      return vim.tbl_deep_extend("force", default_config, extension)
    end

    lsp.graphql.setup(extend_config({ filetypes = { "graphql", "typescriptreact", "javascriptreact", "typescript" } }))

    lsp.tsserver.setup(extend_config({
      on_init = function(client)
        if client.server_capabilities then
          client.server_capabilities.documentFormattingProvider = false
        end
      end,
    }))

    lsp.lua_ls.setup(extend_config({
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
          },
          format = {
            enable = false,
          },
          diagnostics = {
            globals = {
              "vim",
            },
          },
        },
      },
    }))

    local yaml_schemas = {}
    vim.tbl_map(function(schema)
      yaml_schemas[schema.url] = schema.fileMatch
    end, json_schemas)

    lsp.jsonls.setup(extend_config({
      settings = {
        yaml = {
          format = {
            enable = true,
          },
          schemas = yaml_schemas,
        },
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    }))

    lsp.omnisharp.setup(extend_config({
      cmd = {
        "mono",
        vim.fn.expand("~/.omnisharp/omnisharp-mono/OmniSharp.exe"),
        "--loglevel",
        "warning",
        "--languageserver",
        "--hostPID",
        tostring(vim.fn.getpid()),
      },
      handlers = {
        ["textDocument/definition"] = require("omnisharp_extended").handler,
      },
      on_init = function(client)
        if client.server_capabilities then
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.semanticTokensProvider = false
        end
      end,
    }))

    null_ls.setup({
      on_attach = on_attach,
      sources = {
        null_ls.builtins.code_actions.shellcheck,
        null_ls.builtins.diagnostics.actionlint,
        null_ls.builtins.diagnostics.commitlint,
        null_ls.builtins.diagnostics.dotenv_linter,
        null_ls.builtins.diagnostics.fish,
        null_ls.builtins.diagnostics.hadolint,
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.diagnostics.stylelint,
        null_ls.builtins.diagnostics.tsc,
        null_ls.builtins.diagnostics.zsh,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.csharpier,
        null_ls.builtins.formatting.fish_indent,
        null_ls.builtins.formatting.just,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.stylelint,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.tidy,
        null_ls.builtins.formatting.trim_newlines,
        null_ls.builtins.formatting.trim_whitespace,
      },
    })
  end,
}
