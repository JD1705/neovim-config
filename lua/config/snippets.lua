-- En tu init.lua, asegúrate de que LuaSnip esté configurado así:
return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  build = "make install_jsregexp",
  dependencies = { "rafamadriz/friendly-snippets" },
  config = function()
    require("luasnip").setup()
    -- CARGAR TODOS LOS SNIPPETS (incluyendo Python)
    require("luasnip.loaders.from_vscode").lazy_load()
    -- O cargar específicamente Python y Lua:
    -- require("luasnip.loaders.from_vscode").lazy_load({
    --   paths = { vim.fn.stdpath("data") .. "/lazy/friendly-snippets" }
    -- })
  end,
}
