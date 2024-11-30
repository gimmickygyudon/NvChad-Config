local on_attach = require("nvchad.configs.lspconfig").on_attach
local capabilities = require("nvchad.configs.lspconfig").capabilities

require("flutter-tools").setup {
  lsp = {
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
    end,
    capabilities = capabilities
  },
  settings = {
    showTodos = true,
    completeFunctionCalls = true,
    renameFilesWithClasses = "prompt", -- "always"
    enableSnippets = true,
    updateImportsOnRename = true, -- Whether to update imports and other directives when files are renamed. Required for `FlutterRename` command.
  },
  widget_guides = {
    enabled = true,
  },
  decorations = {
    statusline = {
      -- set to true to be able use the 'flutter_tools_decorations.app_version' in your statusline
      -- this will show the current version of the flutter app from the pubspec.yaml file
      app_version = true,
      -- set to true to be able use the 'flutter_tools_decorations.device' in your statusline
      -- this will show the currently running device if an application was started with a specific
      -- device
      device = true,
      -- set to true to be able use the 'flutter_tools_decorations.project_config' in your statusline
      -- this will show the currently selected project configuration
      project_config = true,
    }
  },
  dev_log = {
    enabled = true,
    notify_errors = true, -- if there is an error whilst running then notify the user
    open_cmd = "10split", -- command to use to open the log buffer
    focus_on_open = false, -- focus on the newly opened log window
  },
  debugger = {
    -- integrate with nvim dap + install dart code debugger
    enabled = true,
    run_via_dap = true, -- use dap instead of a plenary job to run flutter apps
    -- if empty dap will not stop on any exceptions, otherwise it will stop on those specified
    -- see |:help dap.set_exception_breakpoints()| for more info
    exception_breakpoints = {},
    register_configurations = function(_)
      require("dap").configurations.dart = {}
      require("dap.ext.vscode").load_launchjs()
    end,
  },
}
