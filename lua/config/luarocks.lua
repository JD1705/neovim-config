return {
  "vhyrro/luarocks.nvim",
  priority = 1080, -- Una prioridad muy alta es necesaria
  config = true,
  opts = {
    rocks = { "lua-toml"} -- Especifica aquí la lista de rocas (paquetes) que quieres instalar
  }
}
