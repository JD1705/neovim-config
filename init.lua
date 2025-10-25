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
keymap("n", "<F5>", ":!python3 %<CR>")

keymap("n", "<leader>b", ":Black<CR>")

-- shortcut to toggle Telescope
keymap("n", "<Leader>ff", ":Telescope find_files<CR>")
keymap("n", "<Leader>fg", ":Telescope live_grep<CR>")
keymap("n", "<Leader>p", ":Telescope projects<CR>", { desc = "Buscar Proyectos" })

-- shortcut to toggle and focus NvimTree using space+e
keymap("n", "<Leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- Abrir/cerrar con <leader>e
keymap("n", "<Leader>E", ":NvimTreeFocus<CR>", { desc = "Focus file explorer" })   -- Enfocar el explorador

-- shortcut to activate/toggle Trouble with space+t
keymap("n", "<Leader>t", ":Trouble<CR>")

-- hop keymaps
vim.api.nvim_set_keymap("n", "s", ":HopWord<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "S", ":HopLine<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "f", ":HopChar1<CR>", { silent = true })

-- A set of options for better completion experience. See `:h completeopt`
vim.opt.completeopt = { "menuone", "noselect", "noinsert" }

-- Hides the ins-completion-menu messages. See `:h shm-c`
vim.opt.shortmess:append "c"

-- lsp pyright enabling
vim.lsp.enable("pyright")

-- 5. Carga de plugins (al final)
require("lazy").setup({
  -- Tema Kanagawa
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        transparent = true,
        colors = {
          theme = {
            wave = {
              ui = {
                bg = "none",
                bg_gutter = "none",
              },
            },
          },
        },
      })
      vim.cmd.colorscheme("kanagawa-wave")
      
      -- Ajustes adicionales para mejorar la legibilidad
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      vim.api.nvim_set_hl(0, "LineNr", { fg = "#DCD7BA", bg = "none" })
    end,
  },
  -- Configurador de LSP  
  { "neovim/nvim-lspconfig" },  
  -- Autocompletado
  {
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
    },
    config = function()
      -- Configuración de nvim-cmp (la veremos abajo)
      require("config.cmp")
    end,
    },
  },
  {
  "windwp/nvim-autopairs",
  event = "InsertEnter",  -- Se carga al entrar en modo inserción
  config = true,          -- Configuración automática con valores por defecto
  },
  -- Treesitter
  {
  "nvim-treesitter/nvim-treesitter",
  run = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "python" },
      highlight = { enable = true },
    })
  end,
  },
  -- Telescope
  {
    'nvim-telescope/telescope.nvim', 
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- Opcional: para iconos bonitos
    config = function()
      require("nvim-tree").setup({
        -- Configuración básica (opcional)
        git = {
            enable = true,
            ignore = false, -- ¡Esto es crucial! Evita que nvim-tree ignore los archivos listados en .gitignore
        },
        filters = {
            dotfiles = false, -- Esto asegura que los archivos dotfiles (como .env) se muestren
            custom = { },     -- Puedes agregar patrones personalizados aquí si quieres ocultar otros archivos
        },
        update_focused_file = {
          enable = true,
          update_root = true -- ¡Esta es la opción clave!
        },
        view = {
          width = 30, -- Ancho de la barra lateral
        },
      })
    end,
  },
  {
    "averms/black-nvim",
    ft = "python",
    config = function()
      -- Configuración mínima (sin módulo 'black')
      vim.api.nvim_create_user_command("Black", function()
        vim.cmd("!black " .. vim.fn.expand("%"))
      end, {})
    end,
  },
  { import = "config.dap" },
  { import = "config.neotest" },
  {
  "folke/trouble.nvim",
  config = function()
    require("trouble").setup()
    vim.keymap.set("n", "<leader>tt", ":TroubleToggle<CR>")
  end,
  },
  { "tpope/vim-fugitive", cmd = { "G", "Git" } },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
  },
  {
  "lewis6991/gitsigns.nvim",
  event = "BufReadPre",
  opts = {
    signs = {
      add = { text = "+" },
      change = { text = "~" },
      },
    },
  },
  {
'romgrk/barbar.nvim',
    dependencies = {
        'lewis6991/gitsigns.nvim',
        'nvim-tree/nvim-web-devicons',
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
        animation = true,
        insert_at_start = true,
        auto_hide = true,
    },
    version = '^1.0.0',
  },
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
},
{
    rocks = {
        hererocks = true, -- Desactiva completamente el soporte de rocks de lazy.nvim
  },
})

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

require("config.lsp")

vim.lsp.enable('lua_ls')
vim.lsp.enable('pyright')
