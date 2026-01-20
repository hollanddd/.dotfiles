require("lint").linters_by_ft = {
  css = {
    "stylelint",
  },
  html = {
    "htmlhint",
  },
  javascript = {
    "eslint",
  },
  javascriptreact = {
    "eslint",
  },
  lua = {
    "luacheck",
  },
  markdown = {
    "markdownlint-cli2",
  },
  python = {
    "flake8",
  },
  scss = {
    "stylelint",
  },
  typescript = {
    "eslint",
  },
  typescriptreact = {
    "eslint",
  },
  vim = {
    "vint",
  },
  yaml = {
    "yamllint",
  },
}

local markdownlint = require("lint").linters["markdownlint-cli2"]
markdownlint.args = {
  "--config", os.getenv("HOME") .. "/.config/markdownlint/.markdownlint.yaml", "--"
}

local luacheck = require("lint").linters.luacheck
luacheck.args = {
  "--globals vim"
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
