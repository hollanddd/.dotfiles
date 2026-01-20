return {
  "github/copilot.vim",
  cmd = "Copilot",
  lazy = false,
  config = function ()
    -- copilot mapping in mappings.lua
    vim.g.copilot_no_tab_map = true;
    vim.g.copilot_assume_mapped = true;
    vim.g.copilot_tab_fallback = "";
  end
}
