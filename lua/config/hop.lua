return {
  {
    "phaazon/hop.nvim",
    branch = "v2", -- versión estable
    config = function()
      require("hop").setup()
    end,
  },
}
