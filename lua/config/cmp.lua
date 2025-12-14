  -- Autocompletado
return {
  -- Autocompletado principal
    {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",       -- Fuente de autocompletado del LSP (Pyright, etc.)
      "hrsh7th/cmp-buffer",          -- Autocompletado del texto en buffers abiertos
      "hrsh7th/cmp-path",            -- Autocompletado para rutas de archivos
      "saadparwaiz1/cmp_luasnip",    -- Integración con snippets (LuaSnip)
      "L3MON4D3/LuaSnip",            -- Motor de snippets (obligatorio)
      "rafamadriz/friendly-snippets", -- Snippets predefinidos (como los de VSCode)
      "lukas-reineke/cmp-under-comparator",
      "hrsh7th/cmp-nvim-lsp-signature-help"
    },
    config = function()
      -- Configuración de nvim-cmp (la veremos abajo)
      require("config.cmp_config")
    end,
    },
}
