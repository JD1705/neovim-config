local cmp = require("cmp")

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body) -- Carga snippets
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(), -- Mostrar autocompletado
    ["<C-e>"] = cmp.mapping.abort(),        -- Cerrar autocompletado
    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirmar selección
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },    -- LSP (Pyright, etc.)
    { name = "luasnip" },     -- Snippets
    { name = "buffer" },      -- Texto en buffers abiertos
    { name = "path" },        -- Rutas de archivos
  }),
})

-- Usa Tab/S-Tab para navegar entre sugerencias
require("cmp")
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
  }),
})
