return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          vim.keymap.set("n", "<leader>co", function()
            vim.lsp.buf.code_action({ kind = "source.organizeImports", apply = true })
          end, { buffer = args.buf, desc = "Organize Imports" })
        end,
      })
    end,
    opts = {
      servers = {
        gopls = {
          on_attach = function(client, _)
            vim.defer_fn(function()
              if client.server_capabilities and client.server_capabilities.semanticTokensProvider then
                client.server_capabilities.semanticTokensProvider = nil
              end
            end, 100)
          end,
        },
        ts_ls = {},
        rust_analyzer = {},
        clangd = {},
      },
    },
  },
}
