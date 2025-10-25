return {
  "ahmedkhalf/project.nvim",
  -- Asegúrate de que telescope esté cargado antes que este plugin
  dependencies = { "nvim-telescope/telescope.nvim" }, 
  config = function()
    require("project_nvim").setup {
      detection_methods = { "pattern" },
      patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
    }

    -- 🚨 ESTA ES LA LÍNEA QUE TE FALTA 🚨
    -- Cargar la extensión para Telescope después de configurar project.nvim
    require('telescope').load_extension('projects')
  end
}
