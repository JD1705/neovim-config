-- -- Configuración para pyright usando la API nativa
-- vim.lsp.config('pyright', {
--   cmd = { 'pyright-langserver', '--stdio' },
--   filetypes = { 'python' },
--   root_dir = vim.fs.dirname(vim.fs.find({ 'pyproject.toml', 'setup.py', '.git' }, { upward = true })[1]),
--   settings = {
--     python = {
--       analysis = {
--         typeCheckingMode = 'basic',
--         autoSearchPaths = false,
--         useLibraryCodeForTypes = true,
--       },
--     },
--   },
-- })
-- lua/config/pyright-optimized.lua
-- Configuración completa y optimizada para pyright

-- vim.lsp.config['basedpyright'] =

-- vim.lsp.config("basedpyright", {
--   cmd = { 'basedpyright-langserver', '--stdio' },
--   filetypes = { 'python' },
--   root_dir = vim.fs.dirname(vim.fs.find({
--     'pyproject.toml',
--     'setup.py',
--     'requirements.txt',
--     'Pipfile',
--     '.git'
--   }, { upward = true })[1]),
--
--   -- 🔧 OPTIMIZACIÓN DE RENDIMIENTO
--   flags = {
--     debounce_text_changes = 200, -- Balance entre respuesta y carga
--   },
--
--   -- ⚙️ CONFIGURACIÓN DE ANÁLISIS
--   settings = {
--     basedpyright = {
--       -- ==============================
--       -- SECCIÓN 1: RENDIMIENTO
--       -- ==============================
--       analysis = {
--         -- Tipo de type checking (elegir uno):
--         -- 'off':       Máximo rendimiento, sin type checking
--         -- 'basic':     Balance recomendado (default)
--         -- 'strict':    Análisis exhaustivo (más lento)
--         typeCheckingMode = "basic",
--         -- Diagnostic mode:
--         -- 'workspace': Analiza todo el proyecto (más lento)
--         -- 'openFilesOnly': Solo archivos abiertos (más rápido)
--         diagnosticMode = 'openFilesOnly',
--         -- Completado automático de imports
--         autoImportCompletions = true,
--         autoSearchPaths = true,
--         -- Análisis indexado para búsquedas rápidas
--         index = true,
--         -- Excluir directorios grandes del análisis
--         exclude = {
--           '**/__pycache__',
--           '**/*.pyc',
--           '**/.git',
--           '**/node_modules',
--           '**/env',
--           '**/venv',
--           '**/.env',
--           '**/.venv',
--         },
--         -- ==============================
--         -- SECCIÓN 2: LINTING Y DIAGNÓSTICOS
--         -- ==============================
--         -- Errores y advertencias esenciales (RECOMENDADO)
--         reportMissingImports = "error",
--         reportUndefinedVariable = "error",
--         reportUnusedImport = 'none',
--         reportUnusedVariable = 'warning',
--         reportUnusedClass = 'warning',
--         reportUnusedFunction = 'warning',
--         -- Type checking específico
--         reportMissingTypeStubs = 'none',      -- Generalmente innecesario
--         reportUnknownMemberType = 'warning',
--         reportOptionalMemberAccess = 'warning',
--         -- Código muerto
--         reportUnnecessaryCast = 'warning',
--         reportUnnecessaryIsInstance = 'warning',
--         -- Análisis de código
--         reportAssertAlwaysTrue = 'warning',
--         reportImplicitStringConcatenation = 'none',
--         reportConstantRedefinition = 'warning',
--         reportInvalidStringEscapeSequence = 'warning',
--         reportPrivateUsage = 'warning',
--         reportUninitializedInstanceVariable = 'warning',
--         -- Análisis avanzado (desactivar si es lento)
--         reportOverlappingOverload = 'none',
--         reportIncompatibleVariableOverride = 'none',
--         reportCallInDefaultInitializer = 'none',
--         -- ==============================
--         -- SECCIÓN 3: COMPLETADO
--         -- ==============================
--         useLibraryCodeForTypes = true,
--         diagnosticSeverityOverrides = true,
--         -- ==============================
--         -- SECCIÓN 4: MEMORIA Y LIMITES
--         -- ==============================
--         memory = {
--           maxOpenFiles = 15, -- Reducir si trabajas con muchos archivos
--         },
--       },
--       -- Configuración adicional
--       telemetry = {
--         enable = false, -- Desactivar telemetría
--       },
--     },
--   },
--
--   -- 🎯 CONFIGURACIÓN DE COMPLETADO (para cmp)
--   init_options = {
--     completion = {
--       resolveEagerly = false, -- 'false' es más rápido para cmp
--     },
--     hover = true,
--     documentSymbol = true,
--     codeAction = true,
--     rename = true,
--   },
--
--   -- ✨ MEJORAS ESTÉTICAS PARA DIAGNÓSTICOS
--   -- handlers = {
--   --   ['textDocument/publishDiagnostics'] = vim.lsp.with(
--   --     vim.lsp.diagnostic.on_publish_diagnostics,
--   --     {
--   --       -- Agrupar diagnósticos similares
--   --       virtual_text = {
--   --         spacing = 4,
--   --         prefix = '●',
--   --         severity_limit = 'Warning', -- Solo muestra Warning y Error
--   --       },
--   --       signs = true,
--   --       underline = true,
--   --       update_in_insert = false, -- Mejor rendimiento
--   --       severity_sort = true,
--   --     }
--   --   ),
--   -- },
--
--
--   -- 🚀 ON_ATTACH PARA MÁXIMO RENDIMIENTO
--   on_attach = function(client, bufnr)
--     -- Optimizar capacidades para mejor rendimiento
--     client.server_capabilities.documentFormattingProvider = false
--     client.server_capabilities.documentRangeFormattingProvider = false
--     -- Keymaps optimizadas
--     local opts = { buffer = bufnr, silent = true }
--     -- Navegación
--     vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
--     vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
--     vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
--     -- Información
--     vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
--     vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
--     -- Acciones de código
--     vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
--     vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
--     -- Diagnósticos
--     vim.keymap.set('n', '[d',function() vim.diagnostic.jump({count= -1, float= true}) end, opts)
--     vim.keymap.set('n', ']d',function() vim.diagnostic.jump({count= 1, float= true}) end, opts)
--     vim.keymap.set('n', '<leader>dd', vim.diagnostic.open_float, opts)
--     -- Comando para toggle de type checking
--     vim.keymap.set('n', '<leader>pt', function()
--       local current = vim.lsp.get_client_by_id(client.id).config.settings.basedpyright.analysis.typeCheckingMode
--       local new_mode = current == 'off' and 'basic' or 'off'
--       client.config.settings.basedpyright.analysis.typeCheckingMode = new_mode
--       client.notify('workspace/didChangeConfiguration', {
--         settings = client.config.settings
--       })
--       vim.notify('BasedPyright type checking: ' .. new_mode)
--     end, opts)
--     -- Mensaje de confirmación
--     vim.defer_fn(function()
--       print('✅ BasedPyright configured: typeCheckingMode = ' ..
--             client.config.settings.basedpyright.analysis.typeCheckingMode)
--     end, 500)
--   end,
-- })
--
-- -- 📊 COMANDO PARA DIAGNÓSTICO DE RENDIMIENTO
-- vim.api.nvim_create_user_command('BasedPyrightPerformance', function()
--   local clients = vim.lsp.get_clients({ name = 'basedpyright' })
--   if #clients == 0 then
--     print('❌ Pyright no está activo')
--     return
--   end
--   local client = clients[1]
--   local config = client.config.settings.basedpyright.analysis
--   print('=== CONFIGURACIÓN DE BASEDPYRIGHT ===')
--   print('Type Checking Mode:', config.typeCheckingMode)
--   print('Diagnostic Mode:', config.diagnosticMode)
--   print('Auto Import Completions:', config.autoImportCompletions)
--   -- Contar diagnósticos activos
--   local active_checks = 0
--   for key, value in pairs(config) do
--     if key:match('^report') and value ~= 'none' then
--       active_checks = active_checks + 1
--     end
--   end
--   print('Checks activos:', active_checks)
--   print('Open Files Limit:', config.memory and config.memory.maxOpenFiles or 'default')
--   -- Sugerencia basada en configuración
--   if config.typeCheckingMode == 'strict' then
--     print('\n💡 SUGERENCIA: typeCheckingMode = "strict" puede ser lento.')
--     print('   Considera cambiarlo a "basic" para mejor rendimiento.')
--   end
--   if config.diagnosticMode == 'workspace' then
--     print('\n💡 SUGERENCIA: diagnosticMode = "workspace" analiza todo el proyecto.')
--     print('   Cambia a "openFilesOnly" para mejor rendimiento.')
--   end
-- end, { desc = 'Verificar configuración de rendimiento de BasedPyright' })
--
vim.lsp.config('basedpyright', {
    cmd = { 'basedpyright-langserver', '--stdio' },
    filetypes = { 'python' },
    root_dir = vim.fs.dirname(vim.fs.find({ 'pyproject.toml', '.git' }, { upward = true })[1]),
    capabilities = {
        positionEncoding = "utf-8"
    },

        -- ====================
        -- OPTIMIZACIÓN CLAVE
        -- ====================
    settings = {
        configuration = "~/.config/nvim/lsp/basedpyright.lua",
        basedpyright = {
            analysis = {
                typeCheckingMode = 'basic', -- 'off', 'basic', 'strict'
                autoImportCompletions = true,
                diagnosticMode = 'openFilesOnly', -- Más rápido
                -- DESACTIVAR COMPLETAMENTE EL LINTING (RUFF LO HACE)
                reportUnusedVariable = 'none',
                reportUnusedImport = 'none',
                reportUnusedCallResult = 'none',
                reportUndefinedVariable = 'none',  -- Ruff reporta esto
                reportMissingImports = 'warning',  -- Útil mantener
                reportMissingTypeStubs = 'none',
                reportUnknownMemberType = 'none',
                -- Solo mantener errores de tipo puros
                reportGeneralTypeIssues = 'warning',
                reportOptionalMemberAccess = 'warning',
            },
        },
    },

        -- BASEDPYRIGHT NO DEBE PUBLICAR DIAGNÓSTICOS VISIBLES
    handlers = {
        ['textDocument/publishDiagnostics'] = function(err, result, ctx, config)
            -- Filtrar: solo pasar diagnósticos si son de type checking
            local filtered_diags = {}
            if result and result.diagnostics then
                for _, diag in ipairs(result.diagnostics) do
                    -- Mantener solo errores de tipo específicos
                    if diag.message:find('type') or diag.message:find('Type') then
                        diag.source = 'basedpyright (type)'
                        table.insert(filtered_diags, diag)
                    end
                end
                result.diagnostics = filtered_diags
            end
            -- Usar handler por defecto con diagnósticos filtrados
            vim.lsp.handlers['textDocument/publishDiagnostics'](err, result, ctx, config)
        end,
    },

    on_attach = function(client, bufnr)
        -- Keymaps específicas para basedpyright
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'Hover info' })
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = 'Go to definition' })
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = bufnr, desc = 'Find references' })
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = bufnr, desc = 'Rename symbol' })
    end,
})
