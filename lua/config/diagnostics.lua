-- lua/config/diagnostics.lua
-- Configuration for diagnostic icons and signs

-- 1. Define the diagnostic icons
vim.diagnostic.config({
  virtual_text = false,
  underline = true,
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = ""
    },
  },
})

-- 2. Configure the signs themselves (optional but recommended for consistency)
vim.fn.sign_define("DiagnosticSignError", {
  text = "",
  texthl = "DiagnosticSignError",
  numhl = "DiagnosticSignError"
})

vim.fn.sign_define("DiagnosticSignWarn", {
  text = "",
  texthl = "DiagnosticSignWarn",
  numhl = "DiagnosticSignWarn"
})

vim.fn.sign_define("DiagnosticSignInfo", {
  text = "",
  texthl = "DiagnosticSignInfo",
  numhl = "DiagnosticSignInfo"
})

vim.fn.sign_define("DiagnosticSignHint", {
  text = "",
  texthl = "DiagnosticSignHint",
  numhl = "DiagnosticSignHint"
})
