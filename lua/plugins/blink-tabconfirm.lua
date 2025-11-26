return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "default",
      -- Override Tab and Shift-Tab
      ["<Tab>"] = { "accept", "select_next", "fallback" },
      ["<S-Tab>"] = { "select_prev", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
    },
    -- Optional: make Tab also confirm if item is selected
    completion = {
      accept = {
        auto_brackets = { enabled = true },
        -- You can set this to "confirm" or "replace"
        -- behavior = "replace",
      },
    },
  },
}
