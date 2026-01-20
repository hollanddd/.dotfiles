require("tiny-inline-diagnostic").setup({
  options = {
    throttle = 20,
    enable_on_insert = true,
  },
  signs = {
    diag = "●",
  },
})

vim.diagnostic.config({ virtual_text = false })
