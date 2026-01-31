return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp", -- Make sure cmp-nvim-lsp is a dependency
  },
  config = function()
    -- Generic on_attach function for LSP servers
    local on_attach = function(client, bufnr)
      local opts = { buffer = bufnr, noremap = true, silent = true }

      -- General LSP Keymaps
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)

      -- Diagnostic Keymaps (available for all LSPs)
      vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "Previous Diagnostic" })
      vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = "Next Diagnostic" })
      vim.keymap.set('n', '<leader>dd', vim.diagnostic.open_float, { desc = "Line Diagnostics" })

      -- Specific keymaps for ruff
      if client.name == "ruff" then
        vim.keymap.set('n', '<leader>rf', function()
          vim.lsp.buf.code_action({ apply = true, context = { only = { 'source.fixAll.ruff' } } })
        end, { buffer = bufnr, desc = '[R]uff [F]ix all issues' })
        vim.keymap.set('n', '<leader>ro', function()
          vim.lsp.buf.code_action({ apply = true, context = { only = { 'source.organizeImports.ruff' } } })
        end, { buffer = bufnr, desc = '[R]uff [O]rganize imports' })
      end
    end

    -- Get capabilities for nvim-cmp
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    -- List of servers to install and configure
    local servers = {
      "lua_ls",
      "ruff",
      "basedpyright",
    }

    -- Ensure servers are installed by mason
    require("mason-lspconfig").setup({
      ensure_installed = servers,
    })

    -- Explicitly loop and configure each server
    for _, server_name in ipairs(servers) do
      -- Base options for every server
      local opts = {
        on_attach = on_attach,
        capabilities = capabilities,
      }

      -- Add server-specific settings
      if server_name == "lua_ls" then
        opts.settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        }
      elseif server_name == "ruff" then
        opts.init_options = {
          settings = {
            lint = { enable = true },
            fixAll = { enable = true },
            organizeImports = { enable = true },
            format = { enable = true },
            args = { '--select=ALL', '--ignore=D203,D212' },
          },
        }
      elseif server_name == "basedpyright" then
        opts.settings = {
          basedpyright = {
            analysis = {
              typeCheckingMode = 'basic',
              autoImportCompletions = true,
              diagnosticMode = 'openFilesOnly',
              reportUnusedVariable = 'none',
              reportUnusedImport = 'none',
              reportUnusedCallResult = 'none',
              reportUndefinedVariable = 'none',
              reportMissingImports = 'warning',
              reportMissingTypeStubs = 'none',
              reportUnknownMemberType = 'none',
              reportGeneralTypeIssues = 'warning',
              reportOptionalMemberAccess = 'warning',
            },
          },
        }
        opts.handlers = {
          ['textDocument/publishDiagnostics'] = function(err, result, ctx, config)
            local filtered_diags = {}
            if result and result.diagnostics then
              for _, diag in ipairs(result.diagnostics) do
                if diag.message:find('type') or diag.message:find('Type') then
                  diag.source = 'basedpyright (type)'
                  table.insert(filtered_diags, diag)
                end
              end
              result.diagnostics = filtered_diags
            end
            vim.lsp.handlers['textDocument/publishDiagnostics'](err, result, ctx, config)
          end,
        }
      end

      -- Finally, set up the server using the NEW, modern API
      vim.lsp.config(server_name, opts)
    end
  end,
}
