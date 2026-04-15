local M = {}

M.setup = function()
  local mappings = {}

  local function bg(key, val) mappings[key] = { bg = val } end

  local function fg(key, val) mappings[key] = { fg = val } end

  local function any(key, val) mappings[key] = val end

  local c = {
    background = '#282c34',
    foreground = '#ffffff',
    cursor = '#ffffff',
    cursorText = '#353a44',
    black = '#1d1f21',
    red = '#cc6566',
    green = '#b6bd68',
    yellow = '#f0c674',
    blue = '#82a2be',
    magenta = '#b294bb',
    cyan = '#8abeb7',
    white = '#c4c8c6',
    blackBright = '#666666',
    redBright = '#d54e53',
    greenBright = '#b9ca4b',
    yellowBright = '#e7c547',
    blueBright = '#7aa6da',
    magentaBright = '#c397d8',
    cyanBright = '#70c0b1',
    whiteBright = '#eaeaea',
  }

  local green600 = '#43A047'

  -- TODO: with LSP:
  -- 1. italic on static method call
  -- 2. red on field member access (this.VAR), color VAR
  -- 4. block comment vs line comment. And if possible @param varName with underline
  -- @param + italic, and darker color for the arg name
  -- TODO general:
  -- 3. fix the green string color, not entirely right yet

  -- General
  any('Normal', { bg = c.background, fg = c.foreground })
  any('Cursor', { bg = c.cursor, fg = c.cursorText })
  bg('NormalFloat', c.background)
  bg('NormalNC', c.background)

  -- Language: any
  fg('@lw_keyword', c.blue)
  fg('@lw_literal', c.blueBright)
  fg('@lw_string', green600)

  -- Language: java
  fg('@lwjava_import_ref', '#0000FF')
  any('@lwjava_field_ref', { fg = c.red, bold = false })

  fg('@lwjava_annotation', c.yellow)
  fg('@lwjava_comment', c.blackBright)

  -- Language: c
  -- TODO

  return mappings
end

return M
