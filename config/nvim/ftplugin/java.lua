if vim.b.did_ftplugin_java then
  return
end
vim.b.did_ftplugin_java = true


-- Root of the project — jdtls needs this to understand your build
-- local root_markers = { 'gradlew', 'mvnw', '.git', 'pom.xml', 'build.gradle' }
local root_markers = { 'gradlew', 'mvnw', '.git' }
local root_dir = require('jdtls.setup').find_root(root_markers)
if root_dir == '' then
    print("not in a java project")
    return
end

-- Workspace dir: unique per project, persistent across sessions
local project_name = vim.fn.fnamemodify(root_dir, ':p:h:t')
print("project_name = " .. project_name)
local workspace_dir = vim.fn.stdpath('cache') .. '/jdtls-workspace/' .. project_name


local home = os.getenv("HOME")
local bundles = {}
vim.list_extend(bundles, vim.split(vim.fn.glob(home .. '/Documents/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar', true), '\n'))
vim.list_extend(bundles, vim.split(vim.fn.glob(home .. '/Documents/vscode-java-test/extension/server/*.jar', true), '\n'))

local lombok_jar = vim.split(vim.fn.glob(home .. '/.m2/repository/org/projectlombok/lombok/*/lombok-*.jar', true), '\n')[1]

local config = {
  cmd = {
    'jdtls',
    '--jvm-arg=-javaagent:' .. lombok_jar,
    '-data', workspace_dir,
  },

  root_dir = root_dir,

  settings = {
    java = {
      signatureHelp = { enabled = true },
      completion = {
        favoriteStaticMembers = {
          'org.junit.Assert.*',
          'org.junit.Assume.*',
          'org.junit.jupiter.api.Assertions.*',
          'org.junit.jupiter.api.Assumptions.*',
          'org.mockito.Mockito.*',
        },
        filteredTypes = {
          'com.sun.*',
          'io.micrometer.shaded.*',
          'java.awt.*',
          'jdk.*',
          'sun.*',
        },
        guessMethodArguments = "off",
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      -- Enables code lens, inlay hints, etc.
      references = { includeDecompiledSources = true },
      implementationsCodeLens = { enabled = true },
      referencesCodeLens = { enabled = true },
      inlayHints = { parameterNames = { enabled = 'all' } },
    },
  },

  init_options = {
    bundles = bundles,
  },

  capabilities = vim.lsp.protocol.make_client_capabilities(),
  on_attach = function(client, bufnr)
    require('jdtls').setup_dap({ hotcodereplace = 'auto' })
    require('jdtls.dap').setup_dap_main_class_configs()
  end,
}

-- This does the per-buffer start/attach dance
require('jdtls').start_or_attach(config)


-- Skip JDK internals on step-into (waits 1s for async config population)
vim.defer_fn(function()
  for _, conf in ipairs(require('dap').configurations.java or {}) do
    conf.stepFilters = {
--      skipClasses = { "$JDK", "junit.*", "org.junit.*" },
      skipClasses = {},
      skipSynthetics = true,
      skipStaticInitializers = true,
      skipConstructors = false,
    }
  end
end, 1000)

-- Optional: Java-specific keymaps (only active in Java buffers)
local opts = { buffer = true, silent = true }
vim.keymap.set('n', '<leader>oi', "<cmd>lua require('jdtls').organize_imports()<cr>", opts)
vim.keymap.set('n', '<leader>tc', "<cmd>lua require('jdtls').test_class()<cr>", opts)
vim.keymap.set('n', '<leader>tm', "<cmd>lua require('jdtls').test_nearest_method()<cr>", opts)
vim.keymap.set('n', '<leader>tp', "<cmd>lua require('jdtls.dap').pick_test()<cr>", opts)




