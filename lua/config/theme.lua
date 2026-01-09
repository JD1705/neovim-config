local lualine = require("lualine")
local custom_ayu = require("lualine.themes.ayu")
custom_ayu.normal.c.bg = "#000000"

lualine.setup {
    options = {
        theme = "ayu"
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'lsp_status', 'progress'},
        lualine_z = {'location'}
    },
    extensions = {"nvim-tree"}
}
