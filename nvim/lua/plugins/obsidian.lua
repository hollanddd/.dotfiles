local getos = require("./utils/get-os")
local user = os.getenv("SYSTEM_USER")
local workspace_name = os.getenv("WORKSPACE_NAME")

-- check what environemnt we are and get vault root directory path
local vault_directory = getos.is_wsl() and "/mnt/c/Users/" .. user .. "/Documents/" or "~/vaults/"

return {
  "epwalsh/obsidian.nvim",
  version = "*",  -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
  },
  opts = {
    workspaces = {
      {
        name = "work",
        path = vault_directory .. workspace_name
      },
    },
    -- see below for full list of options 👇
  },
}
