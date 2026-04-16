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

  local green1 = '#67cc65'
  local purple1 = '#9b74f0'
  local blue1 = '#749ff0'

  -- TODO: with LSP:
  -- 1. italic on static method call, also on field access, including enum
  -- 2. red on field member access (this.VAR), color VAR
  -- 4. block comment vs line comment. And if possible @param varName with underline
  -- @param + italic, and darker color for the arg name
  -- can import an annotation be highlighted with that color? import lombok.require..

  -- General
  any('Normal', { bg = c.background, fg = c.foreground })
  any('Cursor', { bg = c.cursor, fg = c.cursorText })
  bg('NormalFloat', c.background)
  bg('NormalNC', c.background)

  -- Language: any
  fg('@lw_keyword', c.blue)
  fg('@lw_literal', blue1)
  fg('@lw_string', c.yellow)
  any('@lw_null', { fg = blue1, bold = true })

  -- Language: java
  fg('@lwjava_comment', c.blackBright)
  any('@lwjava_import_ref', { fg = c.cursorText })
  any('@lwjava_field_ref', { fg = c.red, bold = false })
  any('@lwjava_annotation', { fg = c.magentaBright, italic = false })
  any('@lwjava_import_asterisk', { fg = c.yellow, bold = true })
  any('@lwjava_import_keyword', { link = '@lwjava_import_ref' })

  -- Language: c
  -- TODO

  return mappings
end

return M
