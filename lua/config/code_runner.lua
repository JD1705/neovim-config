-- En tu archivo de plugins (ej: lua/plugins/code_runner.lua)
return {
  "CRAG666/code_runner.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  config = function()
      require('code_runner').setup({
  filetype = {
    java = {
      "cd $dir &&",
      "javac $fileName &&",
      "java $fileNameWithoutExt"
    },
    python = "python3 -u",
    typescript = "deno run",
    rust = {
      "cd $dir &&",
      "rustc $fileName &&",
      "$dir/$fileNameWithoutExt"
    },
    c = "cd $dir && gcc $fileName -o /tmp/$fileNameWithoutExt && /tmp/$fileNameWithoutExt",
  },
})
vim.keymap.set('n', '<leader>rr', ':RunCode<CR>', { noremap = true, silent = false, desc = "Run Code" })
vim.keymap.set('n', '<leader>rft', ':RunFile tab<CR>', { noremap = true, silent = false, desc = "Run File in Tab" })
vim.keymap.set('n', '<leader>rp', ':RunProject<CR>', { noremap = true, silent = false, desc = "Run Project" })
vim.keymap.set('n', '<leader>rc', ':RunClose<CR>', { noremap = true, silent = false, desc = "Close Runner" })
end,
}
