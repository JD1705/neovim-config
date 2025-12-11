  -- Treesitter
return {
  "nvim-treesitter/nvim-treesitter",
  run = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "python", "bash", "regex", "vim" },
      highlight = { enable = true },
    })
  end,
}
