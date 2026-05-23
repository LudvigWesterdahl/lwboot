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

Plugin: nvim-tree
:help nvim-tree-highlight-groups
:NvimTreeHiTest

Plugin: nvim-web-devicons
:NvimWebDeviconsHiTest

Plugin telescope:
:Telescope highlights

Just running the following to figure out all highlights in a new buffer
:enew | put =execute('hi')

If you want visibility of the actual colors:
:hi<CR>

--]]

vim.opt.guicursor = ''

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- for nvim-tree: disable netrw at the very start of your init.lua
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.showmode = true

vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

vim.opt.tabstop = 4
vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.cmdheight = 1
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
vim.o.scrolloff = 1

-- Ask if quitting before save
vim.o.confirm = true

-- Escape to disable highlights in NORMAL mode
vim.o.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Navigating between windows without C-w prefix.
vim.keymap.set('n', '<C-h>', '<C-w>h', { silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { silent = true })

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



vim.keymap.set("n", "<leader>bd", function()
  local cur = vim.api.nvim_get_current_buf()
  local alt = vim.fn.bufnr("#")
  if alt ~= -1 and alt ~= cur and vim.fn.buflisted(alt) == 1 then
    vim.api.nvim_set_current_buf(alt)
  else
    vim.cmd("bprevious")
  end
  if vim.api.nvim_get_current_buf() == cur then
    vim.cmd("enew")
  end
  vim.api.nvim_buf_delete(cur, { force = false })
end, { desc = "Delete buffer" })

vim.keymap.set("n", "<leader>bD", function()
  local cur = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= cur
       and vim.api.nvim_buf_is_loaded(buf)
       and vim.bo[buf].buflisted
       and not vim.bo[buf].modified
    then
      vim.api.nvim_buf_delete(buf, { force = false })
    end
  end
end, { desc = "Delete all buffers except current (keeps modified)" })

vim.keymap.set('n', '<leader>fr', function()
  local old = vim.fn.input("Old: ")
  if old == nil or old == "" then
    return
  end
  local new = vim.fn.input("New: ")
  if new == nil then
    return
  end

  local cmd = string.format(".,$s/%s/%s/gc", old, new)
  vim.cmd(cmd)
end, { desc = "Substitute in range (prompt with / as separator)" })






-- Run: :set filetype? to see which filetype the current file is.
vim.api.nvim_create_autocmd('FileType', {
  pattern = "c",
  callback = function()
      vim.bo.commentstring = '/* %s */'
  end,
})

-- Example how to get input from user and execute arbitrary command.
vim.keymap.set('n', '<leader>hello', function()
  local count = tonumber(vim.fn.input('Num lines (including current): '))
  if not count or count < 1 then
    print('\nInvalid count')
    return
  end
  local seq = vim.fn.input('Sequence to insert: ')
  if seq == '' then
    print('\nAborted')
    return
  end

  -- Escape special regex chars in the replacement
  local escaped = vim.fn.escape(seq, [[/\&~]])

  local start_line = vim.fn.line('.')
  local end_line = start_line + count - 1
  local command = string.format('%d,%ds/^/%s/', start_line, end_line, escaped)
  print("will execute: " .. command)
  vim.cmd(command)

  -- vim.cmd()
end, { desc = 'Prepend sequence to N lines' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
-- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

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

vim.keymap.set('n', '<F5>',  function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<leader>b',  function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<leader>dq', function() require('dap').disconnect() end, { silent = true })
vim.keymap.set('n', '<leader>du', function() require('dapui').toggle() end)
vim.keymap.set('n', '<leader>dU', function() require('dapui').toggle({ reset = true }) end)


require('vim._core.ui2').enable({

  enable = true, -- Whether to enable or disable the UI.

  msg = { -- Options related to the message module.

    ---@type string|table<string, 'cmd'|'msg'|'pager'> Default message target

    ---or table mapping |ui-messages| kinds, triggers and IDs to a target.

    ---Table keys are are matched as a Lua pattern to the message ID. 'default'

    ---mapping applies to any omitted kind: { default = 'cmd', progress = 'msg' }.

    targets = 'cmd',

    cmd = { -- Options related to messages in the cmdline window.

      height = 0.5 -- Maximum height while expanded for messages beyond 'cmdheight'.

    },

    dialog = { -- Options related to dialog window.

      height = 0.5, -- Maximum height.

    },

    msg = { -- Options related to msg window.

      height = 0.5, -- Maximum height.

      timeout = 4000, -- Time a message is visible in the message window.

    },

    pager = { -- Options related to message window.

      height = 1, -- Maximum height.

    },

  },

})

vim.keymap.set("n", "<leader>e", function()
  require("nvim-tree.api").tree.toggle({
    find_file = false,
    update_root = false,
    focus = true,
  })
end, { desc = "[E]xplorer toggle" })

vim.keymap.set("n", "<leader>E", function()

  local api = require("nvim-tree.api")
  local view = require("nvim-tree.view")

  if view.is_visible() then
    -- Tree is open
    local current_win = vim.api.nvim_get_current_win()
    local tree_win = view.get_winnr()

    if current_win == tree_win then
      -- Already focused on tree → toggle it closed
      api.tree.toggle({ find_file = true, update_root = false, focus = true })
    else
      -- Tree open but not focused → focus it and find current file
      api.tree.find_file({ open = true, focus = true, update_root = false })
    end
  else
    -- Tree closed → open it and find file
    api.tree.toggle({ find_file = true, update_root = false, focus = true })
  end

end, { desc = "[E]xplorer toggle (find file)" })


local function snippet_picker()
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")
    local ls = require("luasnip")

    -- get snippets for current filetype + "all" filetype
    local ft = vim.bo.filetype
    local snippets = {}
    for _, snip in ipairs(ls.get_snippets(ft) or {}) do
        table.insert(snippets, snip)
    end
    for _, snip in ipairs(ls.get_snippets("all") or {}) do
        table.insert(snippets, snip)
    end

    if #snippets == 0 then
        vim.notify("No snippets for filetype: " .. ft, vim.log.levels.WARN)
        return
    end

    pickers.new({}, {
        prompt_title = "Snippets (" .. ft .. ")",
        finder = finders.new_table({
            results = snippets,
            entry_maker = function(snip)
                local desc = ""
                if snip.dscr and snip.dscr[1] then
                    desc = "  —  " .. snip.dscr[1]
                elseif snip.name then
                    desc = "  —  " .. snip.name
                end
                local trigger = snip.trigger or "?"
                return {
                    value = snip,
                    display = trigger .. desc,
                    ordinal = trigger .. " " .. (snip.name or "") .. " " .. (snip.dscr and snip.dscr[1] or ""),
                }
            end,
        }),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, _)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                if selection and selection.value then
                    ls.snip_expand(selection.value)
                end
            end)
            return true
        end,
    }):find()
end

local function snippet_picker_with_preview()
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local previewers = require("telescope.previewers")
    local conf = require("telescope.config").values
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")
    local ls = require("luasnip")

    local ft = vim.bo.filetype
    local snippets = {}
    for _, snip in ipairs(ls.get_snippets(ft) or {}) do
        table.insert(snippets, snip)
    end
    for _, snip in ipairs(ls.get_snippets("all") or {}) do
        table.insert(snippets, snip)
    end

    if #snippets == 0 then
        vim.notify("No snippets for filetype: " .. ft, vim.log.levels.WARN)
        return
    end

    pickers.new({
        preview = {
            timeout = 500,
            treesitter = true,
        },
        debounce = 100,
    }, {
        prompt_title = "Snippets (" .. ft .. ")",

        finder = finders.new_table({
            results = snippets,
            entry_maker = function(snip)
                local desc = ""
                if snip.dscr and snip.dscr[1] then
                    desc = "  —  " .. snip.dscr[1]
                elseif snip.name then
                    desc = "  —  " .. snip.name
                end
                local trigger = snip.trigger or "?"
                return {
                    value = snip,
                    display = trigger .. desc,
                    ordinal = trigger .. " " .. (snip.name or "") .. " " .. (snip.dscr and snip.dscr[1] or ""),
                }
            end,
        }),

        sorter = conf.generic_sorter({}),

        previewer = previewers.new_buffer_previewer({
            title = "Snippet Preview",
            define_preview = function(self, entry, status)
                local snip = entry.value
                local lines = {}

                -- header
                table.insert(lines, "Trigger:     " .. (snip.trigger or "?"))
                if snip.name then
                    table.insert(lines, "Name:        " .. snip.name)
                end
                if snip.dscr and snip.dscr[1] then
                    table.insert(lines, "Description: " .. table.concat(snip.dscr, " "))
                end
                table.insert(lines, "")
                table.insert(lines, "─── Body ───")
                table.insert(lines, "")

                -- snippet body
                local ok, docstring = pcall(function() return snip:get_docstring() end)
                if ok and docstring then
                    for _, line in ipairs(docstring) do
                        table.insert(lines, line)
                    end
                else
                    table.insert(lines, "(could not render snippet body)")
                end

                vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
                -- no filetype = no syntax highlighting = cheaper render = less flicker
                -- if you want syntax highlighting, uncomment:
                -- vim.bo[self.state.bufnr].filetype = ft

vim.schedule(function()
    local bufnr = self.state.bufnr
    if not vim.api.nvim_buf_is_valid(bufnr) then return end
    pcall(vim.treesitter.start, bufnr, ft)
   end)


            end,
        }),

        attach_mappings = function(prompt_bufnr, _)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                if selection and selection.value then
                    ls.snip_expand(selection.value)
                end
            end)
            return true
        end,
    }):find()
end

vim.keymap.set('n', '<leader>fs', snippet_picker_with_preview, { desc = '[F]ind [S]nippets' })





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
              ['ui-select'] = { require('telescope.themes').get_dropdown({
                  layout_config = {
                    width = 0.9,    -- 90% of screen width
                    height = 0.5,
                  },
              }) 
            },
            },
          }

          -- Enable Telescope extensions if they are installed
          pcall(require('telescope').load_extension, 'fzf')
          pcall(require('telescope').load_extension, 'ui-select')

          local builtin = require 'telescope.builtin'
          vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
          vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })

          vim.keymap.set('n', '<leader>sf', function()
  builtin.find_files({
    path_display = { filename_first = { reverse_directories = false } },
  })
end, { desc = '[S]earch [F]iles' })

vim.keymap.set('n', '<leader>sF', function()
  builtin.find_files({
    path_display = { filename_first = { reverse_directories = false } },
    hidden = true,
    no_ignore = true,
    no_ignore_parent = true,
    file_ignore_patterns = {
  '^%.git/',
  '/%.git/',
  '^node_modules/',
  '/node_modules/',
  '^target/',
  '/target/',
    },
  })
end, { desc = '[S]earch [F]iles (all, including hidden + gitignored)' })


          vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
          vim.keymap.set({ 'n', 'v' }, '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
          --vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
          

          vim.keymap.set('n', '<leader>sg', function()
  builtin.live_grep({
    path_display = { filename_first = { reverse_directories = false } },
  })
end, { desc = '[S]earch by [G]rep' })

vim.keymap.set('n', '<leader>sG', function()
  builtin.live_grep({
    --path_display = { filename_first = { reverse_directories = false } },
    path_display = { "filename_first" },
    additional_args = function() return { '--max-count=1' } end,
  })
end, { desc = '[S]earch by [G]rep (files only)' })



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

-- Rename the symbol under your cursor across the workspace.
    vim.keymap.set('n', 'grn', vim.lsp.buf.rename, { buffer = buf, desc = '[R]e[n]ame Symbol' })
    -- Show code actions available at the cursor (quick fixes, refactors, etc.).
    vim.keymap.set({ 'n', 'x' }, 'gra', vim.lsp.buf.code_action, { buffer = buf, desc = '[G]oto Code [A]ction' })

    vim.keymap.set("n", "grh", function()
      centered_float(vim.lsp.buf.hover, {border = "rounded", title = " LSP Hover "})
    end, {buffer = buf, desc = "[G]oto [H]hover"})


    vim.keymap.set("n", "grs", function()
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
    end, {buffer = buf, desc = "[G]oto [S]ignature help"})


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
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    event = "InsertEnter",
    config = function()
        local ls = require("luasnip")

        -- LuaSnip core config
        ls.config.set_config({
            history = true,                          -- allow jumping back into a snippet you've already left
            updateevents = "TextChanged,TextChangedI", -- live-update dynamic nodes as you type
            enable_autosnippets = true,              -- snippets that fire without trigger keypress
            delete_check_events = "TextChanged",     -- clean up dead snippets on text change
        })

        -- Path where your snippet files live
        local snippet_path = vim.fn.stdpath("config") .. "/snippets"

        -- Load snippets
        -- 1. Your Lua snippets from ~/.config/nvim/snippets/*.lua
        require("luasnip.loaders.from_lua").lazy_load({
            paths = { snippet_path },
        })

    end,
},






      {
        -- Autocompletion
        -- See https://cmp.saghen.dev/configuration/general.html
        'saghen/blink.cmp',
        event = 'VimEnter',
        version = '1.*',
        dependencies = {
          {
            'L3MON4D3/LuaSnip',
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
            preset = 'super-tab',
    ["<Tab>"] = { "select_and_accept", "fallback" },
    ["<S-Tab>"] = { "fallback" },

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
              auto_show = false, 
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
dapui.setup({
    layouts = {
      {
        -- Left side: scopes, breakpoints, stacks, watches stacked vertically
        elements = {
          { id = 'scopes',      size = 0.30 },
         -- { id = 'breakpoints', size = 0.20 },
          { id = 'stacks',      size = 0.25 },
          -- { id = 'watches',     size = 0.25 },
        },
        size = math.floor(vim.o.columns * 0.4),  -- 40% of screen width
        position = 'left',
      },

    -- Console strip — separate panel, also at bottom, stacks above the previous
     { elements = { { id = 'console', size = 1.0 }, }, size = 8, position = 'bottom', },
  {
    -- REPL strip
    elements = {
      { id = 'repl', size = 1.0 },
    },
    size = 12,
    position = 'bottom',
  },
  


    },
  })

    -- auto open/close UI on debug session
    dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
    -- dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
    -- dap.listeners.before.event_exited['dapui_config'] = function() dapui.close() end
    -- dap.listeners.before.disconnect['dapui_config'] = function() dapui.close() end
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
        distance = true,
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

-- See: https://www.nerdfonts.com/cheat-sheet
-- https://github.com/nvim-tree/nvim-web-devicons
{
    "nvim-tree/nvim-web-devicons",
    lazy = false,
    config = function()
      require("nvim-web-devicons").setup({
        default = true,
        color_icons = true,
        strict = true,
        override = {
          default_icon = {
           -- icon = "\u{ea7b}",
            icon = "\u{eb60}",
            name = "Default"
          },
        },
        -- See below for defaults:
        -- https://github.com/nvim-tree/nvim-web-devicons/blob/master/lua/nvim-web-devicons/default/icons_by_filename.lua
        override_by_filename = {
          ["pom.xml"] = { icon = "\u{f05c0}", name = "_OF_pom.xml", },
          ["readme.md"] = { icon = "\u{f0afa}", name = "_OF_readme.md", },
          ["config"] = { icon = "\u{eb60}", name = "_OF_config" },
          [".gitignore"] = { icon = "\u{f02a2}", name = "_OF_.gitignore"},
          ["commit_editmsg"] = { icon = "\u{eb60}", name = "_OF_commit_editmsg" },
          ["dockerfile"] = { icon = "\u{f0868}", name = "_OF_dockerfile" },
          [".dockerignore"] = { icon = "\u{f0868}", name = "_OF_.dockerignore" },
          ["TEMPLATE"] = { icon = "\u{ebc6}", name = "_OF_TEMPLATE", },
        },
        -- See below for defaults:
        -- https://github.com/nvim-tree/nvim-web-devicons/blob/master/lua/nvim-web-devicons/default/icons_by_file_extension.lua
        override_by_extension = {
          ["java"] = { icon = "\u{ec15}", name = "_OE_java" },
          ["md"] = { icon = "\u{f0afa}", name = "_OE_md" },
          ["yml"] = { icon = "\u{e615}", name = "_OE_yml" },
          ["yaml"] = { icon = "\u{e615}", name = "_OE_yaml" },
          ["toml"] = { icon = "\u{e615}", name = "_OE_toml", },
          ["txt"] = { icon = "\u{eb60}", name = "_OE_txt" },
          ["Dockerfile"] = { icon = "\u{f0868}", name = "_OE_Dockerfile" },
          ["dockerignore"] = { icon = "\u{f0868}", name = "_OE_dockerignore", },
          ["service"] = { icon = "\u{ebc6}", name = "_OE_service", },
          ["timer"] = { icon = "\u{ebc6}", name = "_OE_timer", },
          ["c"] = { icon = "\u{e61e}", name = "_OE_c", },
          ["html"] = { icon = "\u{e60e}", name = "_OE_html", },
          ["bak"] = { icon = "\u{eb60}", name = "_OE_bak", },
          ["out"] = { icon = "\u{eb60}", name = "_OE_out", },
          ["json"] = { icon = "\u{e60b}", name = "_OE_json", },
          ["js"] = { icon = "\u{e60c}", name = "_OE_js", },
          ["ts"] = { icon = "\u{e628}", name = "_OE_ts", },
          ["tsx"] = { icon = "\u{e628}", name = "_OE_tsx", },
          ["css"] = { icon = "\u{e614}", name = "_OE_css", },
          ["png"] = { icon = "\u{f03e}", name = "_OE_png", },
          ["jpeg"] = { icon = "\u{f03e}", name = "_OE_jpeg", },
          ["jpg"] = { icon = "\u{f03e}", name = "_OE_jpg", },
          ["xml"] = { icon = "\u{f05c0}", name = "_OE_xml", },
          ["svg"] = { icon = "\u{f05c0}", name = "_OE_svg", },
          ["lua"] = { icon = "\u{e620}", name = "_OE_lua", },
          ["scm"] = { icon = "\u{f0627}", name = "_OE_scm", },
          ["TEMPLATE"] = { icon = "\u{ebc6}", name = "_OE_TEMPLATE", },
        },

      })
    end,
  },

{
"nvim-tree/nvim-tree.lua",
version = "*",
lazy = false,
dependencies = {
  "nvim-tree/nvim-web-devicons",
},
config = function()
  local function on_attach(bufnr)
    local api = require("nvim-tree.api")

    -- load defaults first so you keep all the built-in keybinds
    api.config.mappings.default_on_attach(bufnr)


    vim.keymap.set("n", "<leader><CR>", api.tree.change_root_to_node, { desc = "CD", buffer = bufnr, silent = true})
    vim.keymap.set("n", "<leader>cd", function()
      local node = api.tree.get_node_under_cursor()
      local path = node.absolute_path

      if node.type ~= "file" and node.type ~= "directory" then
        print("invalid node type " .. node.type .. " at " .. path)
        return
      end

      if node.type == "file" then
        path = vim.fn.fnamemodify(path, ":h")
      end

      print("opening " .. path)

      -- ghostty +new-window --working-directory=
      vim.fn.jobstart({ "ghostty", "+new-window", "--working-directory=" .. path }, { detach = true })

    end, { desc = "[C][D] into directory in terminal", buffer = bufnr, silent = true})


    -- then remove "s" so flash can use it
    pcall(vim.keymap.del, "n", "s", { buffer = bufnr })
  end

  local glyphsGit1 = {
          unstaged  = "[u]",
          staged    = "[s]",
          unmerged  = "[m]",
          renamed   = "[r]",
          untracked = "[n]",
          deleted   = "[d]",
          ignored   = "[i]",
        }
  local glyphsGit2 = {
          unstaged  = "",
          staged    = "",
          unmerged  = "[m]",
          renamed   = "[r]",
          untracked = "",
          deleted   = "[d]",
          ignored   = "",
        }

  require("nvim-tree").setup({
    on_attach = on_attach,
    sort = {
      sorter = "case_sensitive",
    },
    view = {
      width = 40,
    },
    renderer = {
      group_empty = true,
      highlight_git = "all",
      highlight_opened_files = "none",
    icons = {
      show = {
        git = true,
        folder_arrow = true,
      },
      symlink_arrow = " \u{f061} ",
      glyphs = {
        symlink = "\u{eb60}",
        folder = {
          -- arrow_closed = "\u{f0da}",
          -- arrow_open   = "\u{f0d7}",
          arrow_closed = " ",
          arrow_open   = " ",
          default      = "\u{f07b}",
          open         = "\u{f115}",
          empty        = "\u{f07b}",
          empty_open   = "\u{f115}",
          symlink      = "\u{f07b}",
          symlink_open = "\u{f115}",
        },
        git = glyphsGit2,
      },
    },
    },
    filters = {
      dotfiles = false,
      git_ignored = false,
    },
  })
end,
},






    }

    -- The line beneath this is called `modeline`. See `:help modeline`
    -- vim: ts=2 sts=2 sw=2 et
