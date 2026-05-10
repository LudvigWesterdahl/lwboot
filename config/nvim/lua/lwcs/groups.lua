local M = {}

M.setup = function()
  local mappings = {}

  local function bg(key, val) mappings[key] = { bg = val } end

  local function fg(key, val) mappings[key] = { fg = val } end

  local function any(key, val) mappings[key] = val end

  local function link(key, val) mappings[key] = { link = val } end

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
  -- 4. block comment vs line comment. And if possible @param varName with underline
  -- @param + italic, and darker color for the arg name
  -- can import an annotation be highlighted with that color? import lombok.require..
  -- java.util.List<Integer> and also new java.util.ArrayList, color the scoped part like import.

  -- General
  any('Normal', { bg = c.background, fg = c.foreground })
  any('Cursor', { bg = c.cursor, fg = c.cursorText })
  any('FloatBorder', { bg = c.background, fg = c.cursor })
  bg('NormalFloat', c.background)
  bg('NormalNC', c.background)

  -- Diagnostics
  --
  -- Diagnostic<Severity>               : base color (used by several consumers)
  -- DiagnosticVirtualText<Severity>    : the inline text next to the line
  -- DiagnosticVirtualLines<Severity>   : multi-line text below code
  -- DiagnosticUnderline<Severity>      : the squiggle under the code
  -- DiagnosticSign<Severity>           : the sign column icon (E, W, etc.)
  -- DiagnosticFloating<Severity>       : the floating window text (open_float)
  --
  -- Severity                           : Error, Warn, Info, Hint
  --
  -- DiagnosticUnnecessary              : LSP tag: Unnecessary (unused code, dead code)
  -- DiagnosticDeprecated               : LSP tag: Deprecated (deprecated APIs)
  
  -- Warn
  any("DiagnosticVirtualTextWarn", { fg = c.blackBright } )
  any("DiagnosticVirtualLinesWarn", { fg = c.blackBright } )
  any("DiagnosticUnderlineWarn", { fg = c.blackBright, undercurl = false } )
  any("DiagnosticSignWarn", { fg = c.blackBright, bold = true } )
  any("DiagnosticFloatingWarn", { fg = c.cursor } )

  -- Error
  any("DiagnosticVirtualTextError", { fg = c.blackBright } )
  any("DiagnosticVirtualLinesError", { fg = c.blackBright } )
  any("DiagnosticUnderlineError", { fg = c.blackBright, sp = c.red, undercurl = true } )
  any("DiagnosticSignError", { fg = c.red, bold = true } )
  any("DiagnosticFloatingError", { fg = c.cursor } )

  any("DiagnosticUnnecessary", { fg = c.blackBright })
  any("DiagnosticDeprecated", { strikethrough = true })

  -- Plugin: blink
  any("BlinkCmpMenu", { bg = c.background })
  any("BlinkCmpMenuBorder", { bg = c.background })
  any("BlinkCmpDoc", { bg = c.background })
  any("BlinkCmpDocBorder", { bg = c.background })

  -- Plugin: flash
  local flashFg = c.blackBright
  any("FlashBackdrop", { fg = flashFg })
  any("FlashMatch", { fg = flashFg, bg = "NONE" })
  any("FlashCurrent", { fg = flashFg, bg = "NONE" })
  any("FlashLabel", { fg = c.yellow, bg = "NONE", bold = true })


  -- Language: any
  fg('@lw_keyword', c.blue)
  fg('@lw_literal', blue1)
  fg('@lw_string', c.yellow)
  any('@lw_null', { fg = blue1, bold = true })

  -- Language: java
  any("@lwjava_comment", { fg = c.blackBright, italic = true })
  any('@lwjava_import_ref', { fg = c.cursorText })
  any('@lwjava_field_ref', { fg = c.red, bold = false })
  any('@lwjava_annotation', { fg = c.magentaBright, italic = false })
  any('@lwjava_import_asterisk', { fg = c.yellow, bold = true })
  any('@lwjava_import_keyword', { link = '@lwjava_import_ref' })

  -- LSP: java
  any("@lsp.mod.importDeclaration.java", {link="@lwjava_import_ref"})
  any("@lsp.typemod.annotation.importDeclaration.java", {link="@lwjava_annotation"})
  any("@lsp.type.annotation.java", {link="@lwjava_annotation"})
  any("@lsp.type.modifier.java", {link="@lw_keyword"})
  any("@lsp.typemod.enumMember.static.java", {link="@lwjava_field_ref"})
  any("@lsp.type.property.java", {link="@lwjava_field_ref"})
  any("@lsp.typemod.method.static.java", {italic = true})
  any("@lsp.typemod.property.static.java", {italic = true})
  any("@lsp.type.method.java", {link="@lsp"})
  any("@lsp.type.class.java", {link="@lsp"})
  any("@lsp.typemod.keyword.documentation.java", {fg = c.blackBright, bold = true, underline = true})
  any("@lsp.typemod.parameter.documentation.java", {fg = c.blackBright, bold = true, underline = false})
  any("LSP_CODE", {link="LINK_TO"})
  any("LSP_CODE", {link="LINK_TO"})


  -- Language: c
  -- TODO

  return mappings
end

return M
