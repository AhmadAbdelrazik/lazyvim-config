return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          on_attach = function(client, _)
            vim.defer_fn(function()
              -- Safely check if the server provides semantic tokens, then turn it off
              if client.server_capabilities and client.server_capabilities.semanticTokensProvider then
                client.server_capabilities.semanticTokensProvider = nil
              end
            end, 100)
          end,
        },
      },
    },
  },
}
