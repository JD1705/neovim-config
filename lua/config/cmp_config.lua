-- local cmp = require("cmp")
--
-- cmp.setup({
--   snippet = {
--     expand = function(args)
--       require("luasnip").lsp_expand(args.body) -- Carga snippets
--     end,
--   },
--   mapping = cmp.mapping.preset.insert({
--     ["<C-b>"] = cmp.mapping.scroll_docs(-4),
--     ["<C-f>"] = cmp.mapping.scroll_docs(4),
--     ["<C-Space>"] = cmp.mapping.complete(), -- Mostrar autocompletado
--     ["<C-e>"] = cmp.mapping.abort(),        -- Cerrar autocompletado
--     ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirmar selección
--   }),
--   sources = cmp.config.sources({
--     { name = "nvim_lsp" },    -- LSP (Pyright, etc.)
--     { name = "luasnip" },     -- Snippets
--     { name = "buffer" },      -- Texto en buffers abiertos
--     { name = "path" },        -- Rutas de archivos
--   }),
-- })
--
-- -- Usa Tab/S-Tab para navegar entre sugerencias
-- require("cmp")
-- cmp.setup({
--   mapping = cmp.mapping.preset.insert({
--     ["<Tab>"] = cmp.mapping.select_next_item(),
--     ["<S-Tab>"] = cmp.mapping.select_prev_item(),
--   }),
-- })

-- lua/config/cmp_config.lua
local cmp = require("cmp")
local luasnip = require("luasnip")

-- IMPORTANTE: Esto habilita el autocompletado automático
vim.opt.completeopt = "menu,menuone,noselect"

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  -- Mapeos unificados (solo UN cmp.setup)
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({
      select = true,
      behavior = cmp.ConfirmBehavior.Replace,
    }),
    -- Tab/S-Tab mejorados para navegar y saltar snippets
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  -- Fuentes optimizadas por velocidad
  sources = cmp.config.sources({
    { name = "nvim_lsp", priority = 10 },
    { name = "nvim_lsp_signature_help" },
    { name = "luasnip", priority = 7 },
    { name = "buffer", priority = 5, keyword_length = 2 },
    { name = "path", priority = 3 },
  }),
  -- Configuración de rendimiento
  performance = {
    debounce = 30,  -- ms antes de mostrar completado
    throttle = 15,  -- frecuencia de actualización
    fetching_timeout = 500,  -- timeout por fuente
  },
  -- Ordenamiento inteligente
  sorting = {
    priority_weight = 2,
    comparators = {
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      cmp.config.compare.locality,
      require "cmp-under-comparator".under,
      cmp.config.compare.offset,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
    },
  },
  -- Mejoras estéticas
  window = {
    completion = {
      border = "rounded",
      winhighlight = "Normal:Pmenu,FloatBorder:PmenuBorder,CursorLine:PmenuSel,Search:None",
      col_offset = -3,
      side_padding = 0,
      scrollbar = false,
    },
    documentation = {
      border = "rounded",
      winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
    },
  },
  -- Formato visual
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      -- Íconos personalizados
      local kind_icons = {
        Text = "T",
        Method = "",
        Function = "󰡱",
        Constructor = "",
        Field = "",
        Variable = "",
        Class = "",
        Interface = "",
        Module = "",
        Property = "",
        Unit = "",
        Value = "",
        Enum = "",
        Keyword = "",
        Snippet = "",
        Color = "",
        File = "",
        Reference = "",
        Folder = "",
        EnumMember = "",
        Constant = "",
        Struct = "",
        Event = "",
        Operator = "",
        TypeParameter = "",
      }
      -- Ícono
      vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind] or " ", vim_item.kind)
      -- Menú con fuente
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[SNIP]",
        buffer = "[BUF]",
        path = "[PATH]",
      })[entry.source.name] or string.format("[%s]", entry.source.name)
      -- Truncar textos largos
      local label = vim_item.abbr
      local truncated_label = vim.fn.strcharpart(label, 0, 50)
      if truncated_label ~= label then
        vim_item.abbr = truncated_label .. "…"
      end
      return vim_item
    end,
  },
  -- Experiencia de completado
  completion = {
    autocomplete = {
        cmp.TriggerEvent.TextChanged,  -- Se activa al escribir
        cmp.TriggerEvent.InsertEnter,   -- Se activa al entrar en modo insert
      },
    completeopt = "menu,menuone,noinsert,noselect",
    keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]],
    keyword_length = 1,
  },
})

-- Agrega esto después del cmp.setup general
cmp.setup.filetype("python", {
  sources = cmp.config.sources({
    { name = "nvim_lsp", priority = 10 },
    { name = "luasnip", priority = 6},
    { name = "buffer", priority = 4 },  -- Requerir más caracteres
    { name = "path", priority = 3 },
    -- Nota: Desactivamos luasnip para Python si no lo usas mucho
  }),
  completion = {
    keyword_length = 1,
  },
  -- Para Python, podemos ser más restrictivos
  performance = {
    debounce = 30,
    throttle = 15,
  -- Para Python, queremos que busque en TODO el texto
  matching = {
    disallow_fuzzy_matching = false,
    disallow_fullfuzzy_matching = false,
    disallow_partial_fuzzy_matching = false,
    disallow_partial_matching = false,
    disallow_prefix_unmatching = false,
    },
  },
})

cmp.setup.filetype("lua", {
  sources = cmp.config.sources({
    { name = "nvim_lsp", priority = 10},  -- Lua es rápido
    { name = "luasnip", priority = 8 },
    { name = "buffer", priority = 5 },
  }),
  completion = {
    keyword_pattern = [[\%(\k\k\)]],  -- Solo 3 caracteres para Lua
    keyword_length = 2,
  },
  -- Lua puede ser más rápido
  performance = {
    debounce = 40,
    throttle = 20,
  },
})
