return {
  "linux-cultist/venv-selector.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "nvim-telescope/telescope.nvim",
},
  ft = "python", -- Se carga automáticamente al abrir archivos Python
  keys = {
    { "<leader>v", "<cmd>VenvSelect<cr>", desc = "Seleccionar entorno virtual" }, -- Puedes personalizar el atajo
  },
  opts = {
    -- Configuración opcional (ver más abajo)
  },
}
