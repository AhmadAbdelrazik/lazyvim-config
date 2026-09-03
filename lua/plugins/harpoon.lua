return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },

  config = function()
    local harpoon = require("harpoon")

    -- REQUIRED for Harpoon v2
    harpoon:setup({
      settings = {
        save_on_change = true,
        save_on_toggle = true,
      },
    })

    local map = vim.keymap.set

    -- Add file
    map("n", "<leader>ha", function()
      harpoon:list():add()
    end, { desc = "Harpoon add file" })

    -- Toggle Harpoon UI
    map("n", "<leader>hh", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Harpoon menu" })

    -- Jump to files
    map("n", "<leader>h1", function()
      harpoon:list():select(1)
    end, { desc = "Harpoon file 1" })
    map("n", "<leader>h2", function()
      harpoon:list():select(2)
    end, { desc = "Harpoon file 2" })
    map("n", "<leader>h3", function()
      harpoon:list():select(3)
    end, { desc = "Harpoon file 3" })
    map("n", "<leader>h4", function()
      harpoon:list():select(4)
    end, { desc = "Harpoon file 4" })

    -- Cycle
    map("n", "<leader>hn", function()
      harpoon:list():next()
    end, { desc = "Harpoon next" })

    map("n", "<leader>hp", function()
      harpoon:list():prev()
    end, { desc = "Harpoon previous" })

    -- Telescope integration
    local conf = require("telescope.config").values

    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers")
        .new({}, {
          prompt_title = "Harpoon",
          finder = require("telescope.finders").new_table({
            results = file_paths,
          }),
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
        })
        :find()
    end

    map("n", "<leader>ht", function()
      toggle_telescope(harpoon:list())
    end, { desc = "Harpoon Telescope" })
  end,
}
