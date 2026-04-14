local M = {}

M.setup = function()
  local mappings = {}

  local function bg(key, val) mappings[key] = { bg = val } end

  local function fg(key, val) mappings[key] = { fg = val } end

  local colorBg = '#282c34'
  local color4Blue = '#82a2be'

  -- General

  bg('Normal', colorBg)
  bg('NormalFloat', colorBg)
  bg('NormalNC', colorBg)

  -- Language: java

  -- Language: c

  fg('@string.c', '#00FF00')
  fg('@lw_string.java', '#F44336')
  -- fg("@import
  fg('@lw_keyword', color4Blue)
  fg('@lw_import_ref', '#0000FF')
  return mappings
end

return M
