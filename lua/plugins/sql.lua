return {
  {
    "LazyVim/LazyVim",
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "sql",
        callback = function(args)
          vim.keymap.del("i", "<C-C>a", { buffer = args.buf })
          vim.keymap.del("i", "<C-C>f", { buffer = args.buf })
          vim.keymap.del("i", "<C-C>k", { buffer = args.buf })
          vim.keymap.del("i", "<C-C>o", { buffer = args.buf })
          vim.keymap.del("i", "<C-C>s", { buffer = args.buf })
          vim.keymap.del("i", "<C-C>t", { buffer = args.buf })
          vim.keymap.del("i", "<C-C>p", { buffer = args.buf })
          vim.keymap.del("i", "<C-C>v", { buffer = args.buf })
          vim.keymap.del("i", "<C-C>c", { buffer = args.buf })
          vim.keymap.del("i", "<C-C>l", { buffer = args.buf })
          vim.keymap.del("i", "<C-C>L", { buffer = args.buf })
          vim.keymap.del("i", "<C-C>R", { buffer = args.buf })
        end,
      })
    end,
  },
}
