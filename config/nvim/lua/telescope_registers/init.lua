--[[

CONCEPTS
There are four main components: picker, finder, sorter and actions.

A picker contains items supplied by a finder. When an item is selected there
is an event that triggers an action which does something with the selection.

DEVELOPMENT
Run the file during development using `:luafile %`.

Re-load a file during development if it changed (add above the requires).
package.loaded["registers"] = nil

Functions in actions:
- Move to next selection: actions.move_selection_next(bufnr)
- Move to previous selection: actions.move_selection_previous(bufnr)

Neovim functions:
- Write some text: vim.api.nvim_put({ selection[1] }, "", false, true)

SEE ALSO
https://github.com/nvim-telescope/telescope.nvim/blob/master/developers.md
https://www.youtube.com/watch?v=ZCkG47xGOl4

--]]

local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local conf = require("telescope.config").values
local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")
local entry_display = require("telescope.pickers.entry_display")
local previewers = require("telescope.previewers")
-- package.loaded["registers"] = nil
-- local registers = require("registers")
local registers = require("telescope_registers.registers")

local displayer = entry_display.create({
    separator = "▏",
    items = {
        { width = 3 },
        { remaining = true },
    },
})

local custom_picker = function(opts)
    opts = opts or {}

    local function set_register(bufnr)
        local selection = action_state.get_selected_entry()

        local register = action_state.get_selected_entry().value
        -- Function vim.keycode allows key notation
        vim.fn.setreg(register.reg, vim.keycode(register.value))
        print("applied " .. register.name)
    end

    local picker = pickers.new(opts, {
        prompt_title = "Registers",
        finder = finders.new_table({
            results = registers,
            entry_maker = function(entry)
                return {
                    value = entry,
                    display = function(e)
                        return displayer({
                            e.value.reg,
                            e.value.name,
                        })
                    end,
                    ordinal = entry.name .. " " .. entry.desc,
                }
            end,
        }),
        sorter = conf.generic_sorter(opts),
        previewer = previewers.new_buffer_previewer({
            title = "Value",
            define_preview = function(self, entry)
                vim.wo[self.state.winid].wrap = true
                local desc_lines = vim.split(entry.value.desc, "\n")
                table.insert(desc_lines, string.rep("-", vim.api.nvim_win_get_width(self.state.winid)))
                table.insert(desc_lines, entry.value.value)
                vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, desc_lines)
            end,
        }),
        attach_mappings = function(bufnr, map)
            actions.select_default:replace(function()
                -- Closes the prompt (telescope)
                actions.close(bufnr)
                set_register()
            end)

            map("i", "<C-y>", set_register)
            return true
        end,
    })
    picker:find()
end

return {
    custom_picker = custom_picker,
}
