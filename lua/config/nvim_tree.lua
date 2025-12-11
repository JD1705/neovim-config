return {
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
}
