-- lua/plugins/notify.lua
return {
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy", -- Cargar inmediatamente
    opts = {
      stages = "fade",
      render = "default",
      background_colour = "#000000",
    }
  }
}
