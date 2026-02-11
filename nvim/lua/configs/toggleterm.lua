require("toggleterm").setup {
  direction = "float",
  float_opts = {
    border = "curved",
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
}

local function float_mappings(mapping)
  vim.api.nvim_set_keymap("n", mapping, '<Cmd>execute v:count . "ToggleTerm direction=float"<CR>', {
    silent = true,
    noremap = true,
  })
  vim.api.nvim_set_keymap("t", mapping, '<Cmd>execute v:count . "ToggleTerm direction=float"<CR>', {
    silent = true,
    noremap = true,
  })
end

float_mappings [[<C-\>]]
