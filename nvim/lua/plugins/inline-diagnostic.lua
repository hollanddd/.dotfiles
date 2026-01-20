return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "VeryLazy",
  priority = 1000, -- needs to be loaded first
  config = function ()
    require "configs.inline-diagnostic"
  end,
}
