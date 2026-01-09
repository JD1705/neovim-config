-- Configura Lazy.nvim (al principio)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
 })
end
vim.opt.rtp:prepend(lazypath)
vim.opt.termguicolors = true
-- 1. Habilitar números de línea y sintaxis
vim.opt.number = true
vim.opt.syntax = "on"

-- 2. Tabs y espacios
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- 3. Tecla líder
vim.g.mapleader = " "

-- 4. Atajos básicos
local keymap = vim.keymap.set
keymap("n", "<Leader>w", ":w<CR>")
keymap("n", "<Leader>q", ":q<CR>")

keymap("n", "<leader>b", ":Black<CR>")

-- shortcut to toggle Telescope
keymap("n", "<Leader>ff", ":Telescope find_files<CR>")
keymap("n", "<Leader>fg", ":Telescope live_grep<CR>")
keymap("n", "<Leader>p", ":Telescope projects<CR>", { desc = "Buscar Proyectos" })

-- shortcut to toggle and focus NvimTree using space+e
keymap("n", "<Leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- Abrir/cerrar con <leader>e
keymap("n", "<Leader>E", ":NvimTreeFocus<CR>", { desc = "Focus file explorer" })   -- Enfocar el explorador

-- shortcut to activate/toggle Trouble with space+t
keymap("n", "<Leader>tt", ":Trouble<CR>")

-- toggle commas and semmicolons
keymap('n','<leader>,', ':CommaToggle<CR>')
keymap('n','<leader>;', ':SemiToggle<CR>')

-- hop keymaps
vim.api.nvim_set_keymap("n", "s", ":HopWord<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "S", ":HopLine<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "f", ":HopChar1<CR>", { silent = true })

-- A set of options for better completion experience. See `:h completeopt`
vim.opt.completeopt = { "menuone", "noselect", "noinsert" }

-- Hides the ins-completion-menu messages. See `:h shm-c`
vim.opt.shortmess:append "c"

-- 5. Carga de plugins (al final)
require("lazy").setup({
  -- Tema Kanagawa
--    {
--    "rebelot/kanagawa.nvim",
--    priority = 1000,
--    config = function()
--      require("kanagawa").setup({
--        transparent = true,
--        colors = {
--          theme = {
--           wave = {
--              ui = {
--                bg = "none",
--                bg_gutter = "none",
--              },
--            },
--          },
--        },
--      })
--      vim.cmd.colorscheme("kanagawa-wave")
--      
--      -- Ajustes adicionales para mejorar la legibilidad
--      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
--      vim.api.nvim_set_hl(0, "LineNr", { fg = "#DCD7BA", bg = "none" })
--    end,
--  },
--
  {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
      require("tokyonight").setup({
          transparent = true,
          colors = {
              theme = {
                  moon = {
                      ui = {
                          bg = "none",
                          bg_gutter = "none",
                      },
                  },
              },
          },
      })
    vim.cmd.colorscheme("tokyonight-moon")

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "LineNr", { fg = "#5C97f1", bg = "none" })
  -- Aplicar transparencia globalmente
    vim.cmd([[
        " Fondos transparentes generales
        highlight Normal guibg=NONE
        highlight NormalNC guibg=NONE
        highlight NormalFloat guibg=NONE
  
        " Nvim-tree
        highlight NvimTreeNormal guibg=NONE
        highlight NvimTreeNormalNC guibg=NONE
        highlight NvimTreeEndOfBuffer guibg=NONE

        " Barbar - Tabs individuales
        highlight BufferCurrent guibg=NONE
        highlight BufferVisible guibg=NONE
        highlight BufferInactive guibg=NONE
        highlight BufferVisibleMod guibg=NONE
        highlight BufferCurrentMod guibg=NONE
        highlight BufferInactiveMod guibg=NONE
        highlight BufferTabpageFill guibg=NONE
        highlight BufferSeparator guibg=NONE
        highlight BufferInactiveSign guibg=NONE

        " Telescope - Fondos transparentes
        highlight TelescopeNormal guibg=NONE
        highlight TelescopeBorder guibg=NONE
        highlight TelescopePromptNormal guibg=NONE
        highlight TelescopePromptBorder guibg=NONE
        highlight TelescopePreviewNormal guibg=NONE
        highlight TelescopePreviewBorder guibg=NONE
        highlight TelescopeResultsNormal guibg=NONE
        highlight TelescopeResultsBorder guibg=NONE
        highlight TelescopeTitle guibg=NONE

        " Línea de separación
        highlight WinSeparator guibg=NONE

        highlight DiagnosticVirtualTextError guibg=NONE
        highlight DiagnosticVirtualTextWarn guibg=NONE
        highlight DiagnosticVirtualTextInfo guibg=NONE
        highlight DiagnosticVirtualTextHint guibg=none

        highlight Pmenu guibg=NONE
        highlight PmenuSel guibg=NONE
        highlight PmenuSbar guibg=NONE
        highlight PmenuShadow guibg=NONE
        highlight PmenuThumb guibg=NONE
        highlight PmenuBorder guibg=NONE
        highlight FloatBorder guibg=NONE

        highlight CmpPmenu guibg=NONE
        highlight CmpPmenuBorder guibg=NONE
        highlight CmpPmenuSel guibg=NONE
        highlight CmpItemAbbrMatch guibg=none
        highlight CmpItemMenu guibg=none
        highlight CmpItemAbbr guibg=none
        highlight CmpItemAbbrMatchFuzzy guibg=none
        highlight CmpItemKind guibg=none
        ]])
    end,
  },
  -- Configurador de LSP  
  { "neovim/nvim-lspconfig" },
  {import = "config.cmp"},
  {import = "config.autopairs"},
  {import = "config.treesiter"},
  {import = "config.telescope"},
  {import = "config.nvim_tree"},
  {import = "config.black"},
  { import = "config.dap" },
  { import = "config.neotest" },
  {import = "config.fugitive"},
  {import = "config.indent"},
  {import = "config.gitsigns"},
  {import = "config.barbar"},
  {import = "config.notify"},
  {import = "config.noice"},
  {import = "config.hop"},
  {import = "config.lualine"},
  {import = "config.startup"},
  {import = "config.project"},
  {import = "config.markdown"},
  {import = "config.octo"},
  {import = "config.venv"},
  {import = "config.luarocks"},
  {import = "config.mason"},
  {import = "config.mason-lsp"},
  {import = "config.comment"},
  {import = "config.comma"},
  {import = "config.code_runner"},
  -- {import = "config.flash"},
  {import = "config.trouble"},
  {import = "config.kind"},
  {import = "config.f_snippets"},
  {import = "config.snippets"},
  {import = "config.search"},
  {import = "config.discord"},
  {import = "config.triforce"},
  {'nguyenvukhang/nvim-toggler'},
  {import = "config.resty"}
},
{
    rocks = {
        hererocks = true, -- Desactiva completamente el soporte de rocks de lazy.nvim
  },
})

-- Agrega esto en tu init.lua DESPUÉS de cargar cmp
vim.api.nvim_set_hl(0, "Pmenu", { bg = "#000000", fg = "#c0caf5" })
vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#000000", fg = "#c0caf5", bold = true })
vim.api.nvim_set_hl(0, "PmenuSbar", { bg = "#000000" })
vim.api.nvim_set_hl(0, "PmenuThumb", { bg = "#000000" })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#7aa2f7", bold = true })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#7aa2f7", bold = true })
vim.api.nvim_set_hl(0, "CmpItemKind", { fg = "#bb9af7" })
vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#737aa2", italic = true })


-- Función para alternar el texto virtual de diagnósticos
local function toggle_virtual_text()
  local current_config = vim.diagnostic.config()
  local new_virtual_text = not current_config.virtual_text
  vim.diagnostic.config({
    virtual_text = new_virtual_text
  })
  if new_virtual_text then
    vim.notify("Virtual Diagnostic: ACTIVATED", vim.log.levels.INFO)
  else
    vim.notify("Virtual Diagnostic: DEACTIVATED", vim.log.levels.WARN)
  end
end

-- Keybinding para alternar (por ejemplo, <leader>tv)
vim.keymap.set('n', '<leader>d', toggle_virtual_text, { desc = 'Toggle virtual text' })


local map = vim.keymap.set
map('n', '<S-Tab>', '<Cmd>BufferPrevious<CR>')
map('n', '<Tab>', '<Cmd>BufferNext<CR>')
map('n', '<S-q>', '<Cmd>BufferClose<CR>')
map('n', '<S-a>', '<Cmd>BufferCloseAllButCurrent<CR>')

-- Agregar después de la configuración de los plugins
vim.keymap.set("n", "<leader>dc", function() require("dap").continue() end, { desc = "Start/Continue Debug" })
vim.keymap.set("n", "<leader>db", function() require("dap").toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<leader>do", function() require("dap").step_over() end, { desc = "Step Over" })
vim.keymap.set("n", "<leader>di", function() require("dap").step_into() end, { desc = "Step Into" })
vim.keymap.set("n", "<leader>du", function() require("dap").step_out() end, { desc = "Step Out" })
vim.keymap.set("n", "<leader>dt", function() require("dap").terminate() end, { desc = "Terminate Debug" })
vim.keymap.set("n", "<leader>dr", function() require("dap").repl.open() end, { desc = "Open REPL" })

-- resty shortcuts
vim.keymap.set("n", "<leader>hr", ":hor Rest run<CR>", { desc = "rest run [H]ttp [R]equest" })
vim.keymap.set("n", "<leader>hl", ":hor Rest last<CR>", { desc= "rest run [H]ttp [L]ast request" })
vim.keymap.set("n", "<leader>ho", ":hor Rest open<CR>", { desc= "rest [O]pen [H]ttp panel" })

-- require("lsp.lua_lsp").setup({
--     settings = {
--         Lua = {
--             diagnostics = {
--                 globals = "vim"
--             },
--         },
--     },
-- })
--
-- En tu init.lua, con autocmd

-- require("lsp.init")
require('nvim-toggler').setup()
require'cmp'.setup {
  sources = {
    { name = 'nvim_lsp_signature_help' }
  }
}
