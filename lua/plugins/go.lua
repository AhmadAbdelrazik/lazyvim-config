return {
  "edolphin-ydf/goimpl.nvim",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("telescope").load_extension("goimpl")
  end,
}
