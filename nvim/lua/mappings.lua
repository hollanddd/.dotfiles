require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
-- open buffers in telescope
map("n", "<leader>b", "<cmd>Telescope buffers sort_mru=true sort_last_used=true initial_mode=normal<cr>",
  { desc = "Open buffers" })

map("i", "jk", "<ESC>")

map("i", "<C-l>", function()
  vim.fn.feedkeys(vim.fn['copilot#Accept'](), '')
end, { desc = "Copilot accept" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
