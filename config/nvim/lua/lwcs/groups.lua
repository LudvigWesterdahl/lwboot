local M = {}

M.setup = function()
  local mappings = {}

  local function bg(key, val) mappings[key] = { bg = val } end

  local function fg(key, val) mappings[key] = { fg = val } end

  bg('Normal', '#282c34')
  -- bg("NormalFloat", "#795548")
  -- bg("NormalNC", "#795548")

  fg('@string.c', '#00FF00')
  fg('@lw_string.java', '#F44336')
  -- fg("@import
  fg('@lw_keyword', '#00FF00')
  fg('@lw_import_ref', '#0000FF')
  return mappings
end

return M
