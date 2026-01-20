return {
  "akinsho/toggleterm.nvim",
  version = "*",
  event = "BufRead",
  config = function ()
    require "configs.toggleterm"
  end,
}
