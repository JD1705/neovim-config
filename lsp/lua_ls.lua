-- lua/config/diagnostic-icons.lua (archivo nuevo)
-- Configuración EXCLUSIVA para iconos de diagnóstico

-- 1. Definir los iconos de diagnóstico
vim.diagnostic.config({
  virtual_text = false,
  underline = true,
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = ""
    },
  },
})

-- 2. Configurar signos individuales (opcional pero recomendado)
vim.fn.sign_define("DiagnosticSignError", {
  text = "",
  texthl = "DiagnosticSignError",
  numhl = "DiagnosticSignError"
})

vim.fn.sign_define("DiagnosticSignWarn", {
  text = "",
  texthl = "DiagnosticSignWarn",
  numhl = "DiagnosticSignWarn"
})

vim.fn.sign_define("DiagnosticSignInfo", {
  text = "",
  texthl = "DiagnosticSignInfo",
  numhl = "DiagnosticSignInfo"
})

vim.fn.sign_define("DiagnosticSignHint", {
  text = "",
  texthl = "DiagnosticSignHint",
  numhl = "DiagnosticSignHint"
})


-- Configuración para lua_ls usando la API nativa
-- vim.lsp.config('lua_ls', {
--   cmd = { 'lua-language-server' },
--   filetypes = { 'lua' },
--   root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
--   settings = {
--     Lua = {
--       runtime = {
--         version = 'LuaJIT',
--       },
--       diagnostics = {
--           globals = "vim"
--       },
--       workspace = {
--         library = {
--           vim.env.VIMRUNTIME,
--         },
--         checkThirdParty = false,
--       },
--       telemetry = {
--         enable = false,
--       },
--     },
--   },
-- })
--
-- En tu archivo de configuración (por ejemplo, lua/config/lua_ls.lua)
vim.lsp.config('lua_ls', {
  cmd = { 'lua-language-server' }, -- Comando para iniciar el servidor
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.luarc.jsonc', '.git' }, -- Marcadores de proyecto
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT', -- Especifica que usas LuaJIT (el runtime de Neovim)[citation:2][citation:3]
      },
      -- HACER QUE RECONOZCA LA VARIABLE GLOBAL 'vim'[citation:3][citation:8]
      diagnostics = {
        globals = { 'vim' }, -- Esto resuelve el warning "Undefined global 'vim'"
      },
      workspace = {
        -- HACER QUE CONOZCA LA API DE NEOVIM[citation:3][citation:9]
        library = {
          vim.api.nvim_get_runtime_file("", true), -- Esto añade toda la biblioteca runtime de Neovim
        },
        checkThirdParty = false, -- Evita advertencias por bibliotecas de terceros
      },
      telemetry = {
        enable = false, -- Desactiva telemetría opcionalmente
      },
    }
  }
})
