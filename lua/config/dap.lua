return {
  -- Plugin principal de DAP
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "mfussenegger/nvim-dap-python",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio"
    },
    config = function()
      local dap = require("dap")
      -- Configuración del adaptador para Python
      dap.adapters.python = {
        type = "executable",
        command = "python3",
        args = { "-m", "debugpy.adapter" }
      }

      -- Configuración para Python
      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Debug Python File",
          program = "${file}",
          pythonPath = function()
            return "python3"
          end,
          console = "integratedTerminal",
          justMyCode = true, -- Para depurar también librerías externas
        },
      }
    end,
  },

  -- Integración específica para Python
  {
    "mfussenegger/nvim-dap-python",
    ft = "python3",
    config = function()
      -- Ruta al debugpy instalado via Mason
      local mason_path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
      local debugpy_path = mason_path
      -- Verificar si existe la instalación de Mason, sino usar python del sistema
      if vim.fn.filereadable(mason_path) == 1 then
        debugpy_path = mason_path
      else
        debugpy_path = "python3"
      end
      require("dap-python").setup(debugpy_path)
    end,
  },

  -- Interfaz de usuario para DAP
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup({
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.35 },
              { id = "stacks", size = 0.35 },
              { id = "watches", size = 0.15 },
              { id = "breakpoints", size = 0.15 },
            },
            size = 40,
            position = "left",
          },
          {
            elements = { "repl" },
            size = 5,
            position = "bottom",
          }
        },
      })

      -- Automatizar apertura/cierre de la UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },

  -- Texto virtual para mostrar valores de variables
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap" },
    config = true,
  },
}

