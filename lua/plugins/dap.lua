return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "leoluz/nvim-dap-go",
    "nvim-neotest/nvim-nio",
    "jay-babu/mason-nvim-dap.nvim",
  },

  config = function()
    local dap = require("dap")
    vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
    vim.keymap.set("n", "<Leader>dB", function()
      dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end, { desc = "Conditional breakpoint" })

    vim.keymap.set("n", "<Leader>dc", dap.continue, { desc = "Continue / Start" })
    vim.keymap.set("n", "<Leader>dg", dap.run_to_cursor, { desc = "Run to cursor" })

    vim.keymap.set("n", "<Leader>dn", dap.step_into, { desc = "Step into" })
    vim.keymap.set("n", "<Leader>do", dap.step_over, { desc = "Step over" })
    vim.keymap.set("n", "<Leader>dO", dap.step_out, { desc = "Step out" })

    vim.keymap.set("n", "<Leader>dr", dap.restart, { desc = "Restart session" })
    vim.keymap.set("n", "<Leader>dt", dap.terminate, { desc = "Terminate session" })

    require("mason-nvim-dap").setup({
      automatic_installation = true,
      ensure_installed = { "codelldb" },
      handlers = {}, -- Automatically configures adapters installed via Mason
    })

    dap.adapters.gdb = {
      type = "executable",
      command = "gdb",
      args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
    }

    dap.defaults.fallback.terminal_win_cmd = "special" -- opens in a nvim terminal split

    dap.configurations.cpp = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopAtBeginningOfMainSubprogram = false,
      },
    }

    -- Reuse C++ configuration for C projects
    dap.configurations.c = dap.configurations.cpp
    dap.configurations.rust = dap.configurations.cpp

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
