vim.api.nvim_create_autocmd('FileType', {
  pattern = 'lua',
  callback = function()
    -- Cargar configuración solo para archivos Lua
    require('lsp.lua_ls')
    vim.lsp.enable("lua_ls")
  end,
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'python',
    once = false, -- Para cada buffer de Python
    callback = function(args)
        local bufnr = args.buf
        -- Pequeño delay para asegurar que todo está listo
        vim.defer_fn(function()
            require("lsp.basedpyright")
            vim.lsp.enable('basedpyright')
            require("lsp.ruff")
            vim.lsp.enable('ruff')
            print('✅ Python LSP configurado: basedpyright (type checking) + ruff (linting/formating)')
        end, 50)
    end,
})

-- require("lsp.basedpyright")
-- vim.lsp.enable("basedpyright")
