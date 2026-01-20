local dap = require "dap"
local dapui = require "dapui"

dapui.setup()

-- setup adapters
require("dap-vscode-js").setup {
  debugger_path = vim.fn.stdpath "data" .. "/mason/packages/js-debug-adapter",
  debugger_cmd = { "js-debug-adapter" },
  adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
}

-- custom adapter for running tasks before starting debug
local custom_adapter = "pwa-node-custom"
dap.adapters[custom_adapter] = function(cb, config)
  if config.preLaunchTask then
    local async = require "plenary.async"
    local notify = require("notify").async

    async.run(function()
      ---@diagnostic disable-next-line: missing-parameter
      notify("Running [" .. config.preLaunchTask .. "]").events.close()
    end, function()
      vim.fn.system(config.preLaunchTask)
      config.type = "pwa-node"
      dap.run(config)
    end)
  end
end

-- c adapter config
dap.adapters.lldb = {
  type = "executable",
  command = "/Library/Developer/CommandLineTools/usr/bin/lldb-dap",
  name = "lldb-dap",
}

dap.configurations.rust = {
  {
    name = "Debug",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
    runInTerminal = true,
  },
}

-- typescript language config
for _, language in ipairs { "typescript", "javascript" } do
  dap.configurations[language] = {
    {
      name = "Launch",
      type = "pwa-node",
      request = "launch",
      program = "${file}",
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      sourceMaps = true,
      skipFiles = { "<node_internals>/**" },
      protocol = "inspector",
      console = "integratedTerminal",
    },
    {
      name = "Attach to node process",
      type = "pwa-node",
      request = "attach",
      rootPath = "${workspaceFolder}",
      processId = require("dap.utils").pick_process,
    },
    {
      name = "Debug Main Process (Electron)",
      type = "pwa-node",
      request = "launch",
      program = "${workspaceFolder}/node_modules/.bin/electron",
      args = {
        "${workspaceFolder}/dist/index.js",
      },
      outFiles = {
        "${workspaceFolder}/dist/*.js",
      },
      resolveSourceMapLocations = {
        "${workspaceFolder}/dist/**/*.js",
        "${workspaceFolder}/dist/*.js",
      },
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      sourceMaps = true,
      skipFiles = { "<node_internals>/**" },
      protocol = "inspector",
      console = "integratedTerminal",
    },
    {
      name = "Compile & Debug Main Process (Electron)",
      type = custom_adapter,
      request = "launch",
      preLaunchTask = "npm run build-ts",
      program = "${workspaceFolder}/node_modules/.bin/electron",
      args = {
        "${workspaceFolder}/dist/index.js",
      },
      outFiles = {
        "${workspaceFolder}/dist/*.js",
      },
      resolveSourceMapLocations = {
        "${workspaceFolder}/dist/**/*.js",
        "${workspaceFolder}/dist/*.js",
      },
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      sourceMaps = true,
      skipFiles = { "<node_internals>/**" },
      protocol = "inspector",
      console = "integratedTerminal",
    },
  }
end

-- dapui setup
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end

dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end

dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end

dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })

vim.keymap.set("n", "<Leader>dc", dap.continue, { desc = "Continue" })
