-- 2. CONFIGURAR RUFF (Linting, Formateo, Organizar Imports)
vim.lsp.config('ruff', {
    cmd = { 'ruff', 'server' },
    filetypes = { 'python' },
    root_dir = vim.fs.dirname(vim.fs.find({ 'pyproject.toml', 'ruff.toml', '.git' }, { upward = true })[1]),
    capabilities = {
        positionEncoding = "utf-8"
    },

    init_options = {
        settings = {
            -- Habilitar todas las funciones de Ruff
            lint = { enable = true },
            fixAll = { enable = true },
            organizeImports = { enable = true },
            format = { enable = true },
            -- Configuración recomendada de reglas
            args = { '--select=ALL', '--ignore=D203,D212' }, -- Todas las reglas, ignora algunas específicas
        },
    },

    -- Ruff es rápido, usar debounce bajo
    flags = {
        debounce_text_changes = 100,
    },

    on_attach = function(client, bufnr)
        -- ============================================
        -- KEYMAPS ESPECÍFICAS DE RUFF (Muy útiles)
        -- ============================================
        -- Fix all auto-fixable issues
        vim.keymap.set('n', '<leader>rf', function()
            vim.lsp.buf.code_action({
                apply = true,
                context = { only = { 'source.fixAll.ruff' } }
            })
        end, { buffer = bufnr, desc = '[R]uff [F]ix all issues' })

        -- Organize imports
        vim.keymap.set('n', '<leader>ro', function()
            vim.lsp.buf.code_action({
                apply = true,
                context = { only = { 'source.organizeImports.ruff' } }
            })
        end, { buffer = bufnr, desc = '[R]uff [O]rganize imports' })

        -- Formatear con Ruff
        vim.keymap.set('n', '<leader>fm', function()
            vim.lsp.buf.format({
                async = true,
                filter = function(c) return c.name == 'ruff' end
            })
        end, { buffer = bufnr, desc = 'For[M]at with Ruff' })

        -- Formatear automáticamente al guardar (opcional)
        vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({
                    async = false,
                    filter = function(c) return c.name == 'ruff' end
                })
            end,
        })

        -- Diagnostic navigation
        vim.keymap.set('n', '[d', function() vim.diagnostic.jump({count=-1, float=true}) end, { buffer = bufnr, desc = 'Previous diagnostic' })
        vim.keymap.set('n', ']d', function() vim.diagnostic.jump({count=1, float=true}) end, { buffer = bufnr, desc = 'Next diagnostic' })
        vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { buffer = bufnr, desc = '[D]iagnostics [L]ist' })
        vim.keymap.set('n', '<leader>dd', vim.diagnostic.open_float, { buffer = bufnr })
    end,
})

print('✅ Python LSP configurado: basedpyright (type checking) + ruff (linting/formating)')
