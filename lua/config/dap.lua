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
dap.adapters.python3 = function(cb, config)
  if config.request == 'attach' then
    -- @diagnostic disable-next-line: undefined-field
    local port = (config.connect or config).port
    -- @diagnostic disable-next-line: undefined-field
    local host = (config.connect or config).host or '127.0.0.1'
    cb({
      type = 'server',
      port = assert(port, '`connect.port` is required for a python `attach` configuration'),
      host = host,
      options = {
        source_filetype = 'python',
      },
    })
  else
    cb({
      type = 'executable',
      command = "/mason/packages/debugpy/venv/bin/python3",
      args = { '-m', 'debugpy.adapter' },
      options = {
        source_filetype = 'python',
      },
    })
  end
end
    end,
  },

  -- Integración específica para Python
  {
    "mfussenegger/nvim-dap-python",
    ft = "python3",
    config = function()
      -- Ruta al debugpy instalado via Mason
      local mason_path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python3"
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
