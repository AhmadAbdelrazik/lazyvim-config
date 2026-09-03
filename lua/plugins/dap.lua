return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "leoluz/nvim-dap-go",
    "nvim-neotest/nvim-nio",
  },

  config = function()
    local dap = require("dap")
    vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, { desc = "toggle breakpoint" })
    vim.keymap.set("n", "<Leader>dc", dap.continue, { desc = "debug continue" })

    require("dap-go").setup()
    require("dapui").setup()

    local dapui = require("dapui")
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
  end,
}
