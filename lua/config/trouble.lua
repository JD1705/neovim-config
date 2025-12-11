return  {
  "folke/trouble.nvim",
  config = function()
    require("trouble").setup()
    vim.keymap.set("n", "<leader>t", ":Trouble diagnostics toggle<CR>")
  end,
  }
