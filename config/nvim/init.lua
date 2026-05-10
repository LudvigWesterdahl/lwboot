--[[

GUIDES
:help lua-guide
html version:  https://neovim.io/doc/user/lua-guide.html

:Tutor

:help

"<space>sh" to search the doc

:checkhealth

:help option-list

:help vim.o

:help clipboard

:help hlsearch

:help vim.keymap.set()

:help confirm

Check status of plugins
:Lazy
Press ? for help and :q to close.

Update plugins
:Lazy update

:help telescope

:help telescope.setup()

:Telescope help_tags

:help telescope.builtin

:help lua-guide-autocommands

:help mapleader

Debug autocmds
You can put print("called 1") or whatever. Then type :messages to see output.
The vim.schedule wrapping is the fix for a surprising number of "my autocmd ran but the editor didn't update" bugs.

:help lsp-vs-treesitter

Inspect a plugin methods
:lua print(vim.inspect(require('blink.cmp')))




--]]

vim.opt.guicursor = ''

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.showmode = true

vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

vim.opt.tabstop = 4
vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.o.breakindent = true

-- Enable undo/redo changes even after closing and reopening a file
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 1500

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-guide-options`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = false

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- Ask if quitting before save
vim.o.confirm = true

-- Escape to disable highlights in NORMAL mode
vim.o.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Disables highlight when entering INSERT mode
vim.api.nvim_create_autocmd('InsertEnter', {
  callback = function()
    vim.schedule(function() vim.cmd 'nohlsearch' end)
  end,
})

vim.o.autoread = true

-- Actually trigger the disk check on common events
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI', }, {
  pattern = '*',
  callback = function()
    -- Don't run while in command-line mode (would interrupt typing :commands)
    if vim.fn.mode() ~= 'c' and vim.fn.bufexists(0) == 1 then
      vim.cmd('silent! checktime')
    end
  end,
  desc = 'Check if file changed on disk',
})

-- Notify when a buffer reloads, so silent changes don't confuse you
vim.api.nvim_create_autocmd('FileChangedShellPost', {
  pattern = '*',
  callback = function()
    vim.notify(
      'File changed on disk. Buffer reloaded.',
      vim.log.levels.WARN,
      { title = 'autoread' }
    )
  end,
  desc = 'Notify on external file change',
})

-- Diagnostic Config & Keymaps
-- See :help vim.diagnostic.Opts
vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = { min = vim.diagnostic.severity.HINT } },

  virtual_text = { virt_text_pos = "eol_right_align" },
  -- virtual_text = false,

  -- virtual_lines = { current_line = true},
  virtual_lines = false,

  -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
  jump = {
    on_jump = function(_, _)
      vim.diagnostic.open_float()
    end,
  },
}

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- [[ Basic Autocommands ]]

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})


vim.api.nvim_create_user_command("SemanticToggle", function()
  local enabled = vim.b.semantic_tokens_enabled ~= false
  vim.lsp.semantic_tokens.enable(not enabled, { bufnr = 0 })
  vim.b.semantic_tokens_enabled = not enabled
  print("Semantic tokens " .. (not enabled and "ON" or "OFF"))
end, {})



-- Installs lazy nvim plugin manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then error('Error cloning lazy.nvim:\n' .. out) end
end

local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- Attach parsers
local parsers = {
  'bash',
  'c',
  'java',
}
local parsers_set = {}
for _, lang in ipairs(parsers) do
  parsers_set[lang] = true
end

vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(args.match)
    if lang and parsers_set[lang] then vim.treesitter.start(args.buf, lang) end
  end,
})


local function centered_float(fn, cfg)
  local width = math.floor((vim.o.columns - 16)/2)
  local height = vim.o.lines - 8
  local orig = vim.lsp.util.open_floating_preview

  vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = "rounded"
    opts.max_width = width
    opts.max_height = height
    vim.lsp.util.open_floating_preview = orig
    local bufnr, winid = orig(contents, syntax, opts, ...)
    if winid and vim.api.nvim_win_is_valid(winid) then
      vim.api.nvim_win_set_config(winid, {
        relative = "editor",
        anchor = "NW",
        width = width,
        height = height,
        row = 2,
        col = math.floor(vim.o.columns / 2),
        border = cfg.border,
        title = cfg.title or "",
        title_pos = "center",
      })
    end
    return bufnr, winid
  end

  fn({})
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local opts = { buffer = bufnr }

    vim.keymap.set("n", "<leader>bh", function()
      centered_float(vim.lsp.buf.hover, {border = "rounded", title = " LSP Hover "})
    end, opts)

    vim.keymap.set("n", "<leader>bs", function()
      vim.lsp.buf.signature_help({
        border = 'rounded',
        max_width = 80,
        max_height = 20,
      })

      -- After opening, fix the conceal in the float
      vim.schedule(function()
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local config = vim.api.nvim_win_get_config(win)
          if config.relative ~= '' then
            vim.wo[win].conceallevel = 2
            vim.wo[win].concealcursor = 'n'
          end
        end
      end)
    end, opts)

-- Run/debug tests
vim.keymap.set('n', '<leader>tc', "<cmd>lua require('jdtls').test_class()<cr>", opts)
vim.keymap.set('n', '<leader>tm', "<cmd>lua require('jdtls').test_nearest_method()<cr>", opts)

vim.keymap.set('n', '<F5>',  "<cmd>lua require('dap').continue()<cr>", opts)
vim.keymap.set('n', '<F10>', "<cmd>lua require('dap').step_over()<cr>", opts)
vim.keymap.set('n', '<F11>', "<cmd>lua require('dap').step_into()<cr>", opts)
vim.keymap.set('n', '<F12>', "<cmd>lua require('dap').step_out()<cr>", opts)
vim.keymap.set('n', '<leader>b', "<cmd>lua require('dap').toggle_breakpoint()<cr>", opts)
vim.keymap.set('n', '<leader>dq', function() require('dap').disconnect() end, { silent = true })
  end,
})

require('lazy').setup {
  -- NOTE: Plugins can be added via a link or github org/name. To run setup automatically, use `opts = {}`

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `opts` key (recommended), the configuration runs
  -- after the plugin has been loaded as `require(MODULE).setup(opts)`.

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    -- By default, Telescope is included and acts as your picker for everything.

    enabled = true,
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function() return vim.fn.executable 'make' == 1 end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
            pickers = {
              current_buffer_fuzzy_find = { previewer = true, debounce = 1000 },
              live_grep = { debounce = 500 },
              buffers = { previewer = true, sort_lastused = true },
            },
            extensions = {
              ['ui-select'] = { require('telescope.themes').get_dropdown() },
            },
          }

          -- Enable Telescope extensions if they are installed
          pcall(require('telescope').load_extension, 'fzf')
          pcall(require('telescope').load_extension, 'ui-select')

          local builtin = require 'telescope.builtin'
          vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
          vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
          vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
          vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
          vim.keymap.set({ 'n', 'v' }, '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
          vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })

          -- line_width can be set to "full"
          vim.keymap.set('n', '<leader>sd', function()
            builtin.diagnostics({ line_width = nil})
          end,
          { desc = '[S]earch [D]iagnostics' })
          vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
          vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
          vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = '[S]earch [C]ommands' })
          vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

          -- :JdtShowLogs

          -- This runs on LSP attach per buffer (see main LSP attach function in 'neovim/nvim-lspconfig' config for more info,
          -- it is better explained there). This allows easily switching between pickers if you prefer using something else!
          vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
            callback = function(event)
              local buf = event.buf

              -- Find references for the word under your cursor.
              vim.keymap.set('n', 'grr', builtin.lsp_references, { buffer = buf, desc = '[G]oto [R]eferences' })

              -- Jump to the implementation of the word under your cursor.
              -- Useful when your language has ways of declaring types without an actual implementation.
              vim.keymap.set('n', 'gri', builtin.lsp_implementations, { buffer = buf, desc = '[G]oto [I]mplementation' })

              -- Jump to the definition of the word under your cursor.
              -- This is where a variable was first declared, or where a function is defined, etc.
              -- To jump back, press <C-t>.
              vim.keymap.set('n', 'grd', builtin.lsp_definitions, { buffer = buf, desc = '[G]oto [D]efinition' })

              -- Fuzzy find all the symbols in your current document.
              -- Symbols are things like variables, functions, types, etc.
              vim.keymap.set('n', 'gO', builtin.lsp_document_symbols, { buffer = buf, desc = 'Open Document Symbols' })

              -- Fuzzy find all the symbols in your current workspace.
              -- Similar to document symbols, except searches over your entire project.
              vim.keymap.set('n', 'gW', builtin.lsp_dynamic_workspace_symbols, { buffer = buf, desc = 'Open Workspace Symbols' })

              -- Jump to the type of the word under your cursor.
              -- Useful when you're not sure what type a variable is and you want to see
              -- the definition of its *type*, not where it was *defined*.
              vim.keymap.set('n', 'grt', builtin.lsp_type_definitions, { buffer = buf, desc = '[G]oto [T]ype Definition' })
            end,
          })

          -- Override default behavior and theme when searching
          vim.keymap.set('n', '<leader>/', function()
            -- You can pass additional configuration to Telescope to change the theme, layout, etc.
            builtin.current_buffer_fuzzy_find()
            --[[builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
              winblend = 10,
            })
            --]]
          end, { desc = '[/] Fuzzily search in current buffer' })

          -- It's also possible to pass additional configuration options.
          --  See `:help telescope.builtin.live_grep()` for information about particular keys
          vim.keymap.set(
            'n',
            '<leader>s/',
            function()
              builtin.live_grep {
                grep_open_files = true,
                prompt_title = 'Live Grep in Open Files',
              }
            end,
            { desc = '[S]earch [/] in Open Files' }
          )

          -- Shortcut for searching your Neovim configuration files
          vim.keymap.set('n', '<leader>sn', function() builtin.find_files { cwd = vim.fn.stdpath 'config' } end, { desc = '[S]earch [N]eovim files' })
        end,
      },

      {
        -- Autocompletion
        -- See https://cmp.saghen.dev/configuration/general.html
        'saghen/blink.cmp',
        event = 'VimEnter',
        version = '1.*',
        dependencies = {
          -- Snippet Engine
          {
            'L3MON4D3/LuaSnip',
            version = '2.*',
            build = (function() return 'make install_jsregexp' end)(),
            dependencies = {},
            opts = {},
          },
        },
        opts = {
          keymap = {
            -- 'default' (recommended) for mappings similar to built-in completions
            --   <c-y> to accept ([y]es) the completion.
            --    This will auto-import if your LSP supports it.
            --    This will expand snippets if the LSP sent a snippet.
            -- 'super-tab' for tab to accept
            -- 'enter' for enter to accept
            -- 'none' for no mappings
            --
            -- For an understanding of why the 'default' preset is recommended,
            -- you will need to read `:help ins-completion`
            --
            -- No, but seriously. Please read `:help ins-completion`, it is really good!
            --
            -- All presets have the following mappings:
            -- <tab>/<s-tab>: move to right/left of your snippet expansion
            -- <c-space>: Open menu or open docs if already open
            -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
            -- <c-e>: Hide menu
            -- <c-k>: Toggle signature help
            --
            -- See :h blink-cmp-config-keymap for defining your own keymap
            preset = 'default',

            -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
            --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
          },

          appearance = {
            -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = 'mono',
          },

          completion = {
            menu = {
              border = "rounded",
              winblend = 0,
              scrollbar = false,
              direction_priority = { "n", "s" },
            },
            documentation = { 
              auto_show = true, 
              auto_show_delay_ms = 500,
              window = {
                border = "rounded",
                winblend = 0,
                scrollbar = false,
      direction_priority = {
        menu_north = { "n", "s" },
        menu_south = { "s", "n" },
      },
              },
            },

          },

          sources = {
            default = { 'lsp', 'path', 'snippets' },
          },

          snippets = { preset = 'luasnip' },
          fuzzy = { implementation = 'rust' },
          signature = { 
            enabled = true, 
            window = {
              border = "rounded", 
              winblend = 0,
              scrollbar = false,
              direction_priority = { "s", "n" },
            } 
          },
        },
      },

      {
        'mfussenegger/nvim-jdtls',
        ft = 'java',   -- lazy-load on java filetype
        dependencies = {
          'mfussenegger/nvim-dap',  -- optional, only if you want debugging
        },
      },
{
  'rcarriga/nvim-dap-ui',
  dependencies = {
    'mfussenegger/nvim-dap',
    'nvim-neotest/nvim-nio',
  },
  config = function()
    local dap, dapui = require('dap'), require('dapui')
    dapui.setup()
    -- auto open/close UI on debug session
    dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
    dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
    dap.listeners.before.event_exited['dapui_config'] = function() dapui.close() end
    dap.listeners.before.disconnect['dapui_config'] = function() dapui.close() end
     -- Java attach config for debugging running JVMs (e.g., jars started with -agentlib:jdwp=...)
     -- Press F5 to show dialog to attach
    dap.configurations.java = dap.configurations.java or {}
    table.insert(dap.configurations.java, {
      type = 'java',
      request = 'attach',
      name = 'Attach to localhost:5005',
      hostName = 'localhost',
      port = 5005,
    })

  end,
},

      {
        dir = vim.fn.stdpath 'config' .. '/lua/lwcs',
        lazy = false,
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
          require('lwcs').setup()
          vim.cmd.colorscheme 'lwcs'
        end,
      },
{
  'stevearc/conform.nvim',
  config = function()
    require('conform').setup({
      formatters_by_ft = {
        java = { 'intellij' },
        xml = { "intellij" },
        html = { 'intellij' },
        c = { "clangformat" },
      },
      formatters = {
        intellij = {
          command = '/usr/share/idea/bin/format.sh',
          args = {
            '-s', vim.fn.stdpath("config") .. '/formatters/intellij-codestyle.xml',
            '$FILENAME',
          },
          stdin = false,
          tmpfile_format = '.conform.$RANDOM.$FILENAME',
        },
        clangformat = {
          command = "clang-format",
          args = {
             '--assume-filename', '$FILENAME',
            "--style=file:" .. vim.fn.stdpath("config") .. "/formatters/.clang-format",
        },
      }
      },
    })
    vim.keymap.set('n', '<leader>f', function()
      require('conform').format({ async = true, timeout_ms = 10000  })
    end)
  end,
},
{
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {
    modes = {
      char = { enabled = false },
      search = { enabled = false },
    },
    labels = "abcdefghijklmnopqrstuvwxyz",
    label = {
        distance = false,
        reuse = "none",
        uppercase = false,  -- only use lowercase a-z, no caps
    },
  },
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
  },
},
    }

    -- The line beneath this is called `modeline`. See `:help modeline`
    -- vim: ts=2 sts=2 sw=2 et
