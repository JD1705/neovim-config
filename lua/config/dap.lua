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
      local dap = require('dap')
      dap.configurations.python = {
        {
          type = 'python',
          request = 'launch',
          name = "Launch file (Integrated Terminal)",
          program = "${file}",
          pythonPath = function()
            -- Dynamically find the path to the debugpy adapter installed with mason
            local mason_path = vim.fn.stdpath("data") .. "/mason/"
            local debugpy_venv_python = mason_path .. "packages/debugpy/venv/bin/python"

            if vim.fn.filereadable(debugpy_venv_python) == 1 then
              return debugpy_venv_python
            else
              -- Fallback to system python/python3 if debugpy venv python is not found
              local python_path = vim.fn.exepath('python')
              if python_path ~= '' then
                return python_path
              else
                return vim.fn.exepath('python3') -- Try python3 if 'python' isn't found
              end
            end
          end,
          console = 'internalConsole', -- CRITICAL: Direct output to dap-ui REPL
        },
        {
          type = 'python',
          request = 'attach',
          name = "Attach to process",
          port = 5678, -- Default debugpy port
          host = '127.0.0.1',
          pythonPath = function()
            return vim.fn.exepath('python')
          end,
        },
      }
    end,
  },

  -- Integración específica para Python
  {
    "mfussenegger/nvim-dap-python",
    ft = "python", -- CRITICAL FIX: The filetype is 'python', not 'python3'
    config = function()
      -- Dynamically find the path to the debugpy adapter installed with mason
      local mason_path = vim.fn.stdpath("data") .. "/mason/"
      local adapter_path = mason_path .. "packages/debugpy/venv/bin/python"

      -- Check if the adapter exists and configure dap-python
      if vim.fn.filereadable(adapter_path) == 1 then
        require("dap-python").setup(adapter_path)
      else
        -- Fallback if debugpy is not found in mason
        require("dap-python").setup()
        vim.notify("DAP: debugpy not found in Mason. Using system python.", vim.log.levels.WARN)
      end
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

      -- Automatically open/close the UI when a debug session starts/stops
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      -- dap.listeners.before.event_terminated["dapui_config"] = function()
      --   dapui.close()
      -- end
      -- dap.listeners.before.event_exited["dapui_config"] = function()
      --   dapui.close()
      -- end

      -- CRITICAL: Ensure UI updates and REPL focuses when debugger stops (e.g., on error)
      dap.listeners.after.event_stopped["dapui_config_stopped"] = function()
        dapui.eval() -- Ensure all UI elements are updated
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
