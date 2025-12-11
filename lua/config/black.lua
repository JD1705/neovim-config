return {
    "averms/black-nvim",
    ft = "python",
    config = function()
      -- Configuración mínima (sin módulo 'black')
      vim.api.nvim_create_user_command("Black", function()
        vim.cmd("!black " .. vim.fn.expand("%"))
      end, {})
    end,
}
