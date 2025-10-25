return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- Es obligatorio tener treesitter bien configurado
    ft = { "markdown" }, -- Se carga sólo para archivos markdown
    opts = {
        -- Configuración básica. Consulta el README para más opciones.
        render_modes = { 'n' }, -- Por ejemplo, renderizar sólo en modo normal
        -- ... otras opciones que desees configurar
    }
}
