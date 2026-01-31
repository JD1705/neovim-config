return {
  -- Plugin principal de neotest
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-python",
      "nvim-neotest/nvim-nio", -- Adaptador para Python
    },
    config = function()
      require("neotest").setup({
        -- Configuración principal
        adapters = {
          require("neotest-python")({
            python = function()
              -- Detecta automáticamente el virtualenv
              local venv = vim.fn.findfile("pyproject.toml", vim.fn.getcwd() .. ";")
              if venv ~= "" then
                return ".venv/bin/python"
              end
              return "python3"
            end,
            -- Configuración específica para Python
            dap = { justMyCode = false },
            runner = "pytest",  -- o "unittest"
            python = ".venv/bin/python",  -- Ruta a tu virtualenv
          })
        },
        -- Otras configuraciones globales
        output = {
          open_on_run = true,
        },
        summary = {
          open = "botright vsplit | vertical resize 50",
        }
      })

      -- Atajos de teclado
      local neotest = require("neotest")
      vim.keymap.set("n", "<leader>rt", function()
        neotest.run.run()
      end, { desc = "Run test" })

      vim.keymap.set("n", "<leader>tf", function()
        neotest.run.run(vim.fn.expand("%"))
      end, { desc = "Run test file" })

      vim.keymap.set("n", "<leader>ts", function()
        neotest.summary.toggle()
      end, { desc = "Toggle test summary" })

      vim.keymap.set("n", "<leader>to", function()
        neotest.output.open()
      end, { desc = "Open test output" })

      vim.keymap.set("n", "<leader>tO", function()
        neotest.output_panel.toggle()
      end, { desc = "Toggle output panel" })

      vim.keymap.set("n", "<leader>tS", function()
        neotest.run.stop()
      end, { desc = "Stop test" })
    end,
  },

  -- Adaptador para Python (ya incluido como dependencia)
  {
    "nvim-neotest/neotest-python",
  },
}
