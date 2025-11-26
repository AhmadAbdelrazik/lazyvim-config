return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          files = {
            hidden = true, -- show dotfiles
            follow = true, -- optional: follow symlinks
          },
        },
      },
    },
  },
}
