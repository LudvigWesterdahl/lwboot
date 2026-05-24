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
  local green2 = '#b3f6c0'

  -- General
  any('Normal', { bg = c.background, fg = c.foreground })
  any('Cursor', { bg = c.cursor, fg = c.cursorText })
  any('FloatBorder', { bg = c.background, fg = c.cursor })
  bg('NormalFloat', c.background)
  bg('NormalNC', c.background)
  -- fixes cyan coloring of guifg= stuff.
  any("Special", { fg = c.cursor })
  any("Function", { fg = c.cursor })
  any("Directory", { fg = c.cursor })

  local searchBg = c.yellow
  local searchFg = c.background
  any("Search", { bg = searchBg, fg = searchFg, bold = false, underline = false })
  any("IncSearch", { bg = searchBg, fg = searchFg, bold = false, underline = false })
  any("CurSearch", { bg = c.cursor, fg = searchFg, bold = false, underline = false })

  -- Git
  any("gitignoreGlob", { fg = c.cursor })
  any("gitignorePattern", { fg = c.cursor })
  any("gitignoreNegation", { fg = c.cursor })
  any("gitignoreComment", { fg = c.blackBright, italic = true })

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

  -- Plugin: telescope
  any("TelescopeMatching", { fg = c.yellow, bold = true })

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

  -- Plugin: nvim-web-devicons
  local devIconWhiteFg = c.cursor
  local devIconRedFg = c.red
  local devIconBlueFg = c.blueBright
  local devIconYellowFg = c.yellow
  local devIconMagentaFg = c.magenta
  any("DevIconDefault", { fg = devIconWhiteFg })
  any("DevIcon_OF_pom.xml", { fg = devIconRedFg })
  any("DevIcon_OF_readme.md", { fg = devIconBlueFg })
  any("DevIcon_OF_config", { fg = devIconWhiteFg })
  any("DevIcon_OF_.gitignore", { fg = devIconRedFg })
  any("DevIcon_OF_commit_editmsg", { fg = devIconWhiteFg })
  any("DevIcon_OF_dockerfile", { fg = devIconBlueFg })
  any("DevIcon_OF_.dockerignore", { fg = devIconBlueFg })
  any("DevIcon_OF_TEMPLATE", { fg = devIconWhiteFg })
  any("DevIcon_OF_TEMPLATE", { fg = devIconWhiteFg })
  any("DevIcon_OF_TEMPLATE", { fg = devIconWhiteFg })
  any("DevIcon_OF_TEMPLATE", { fg = devIconWhiteFg })
  any("DevIcon_OF_TEMPLATE", { fg = devIconWhiteFg })
  any("DevIcon_OE_java", { fg = devIconRedFg })
  any("DevIcon_OE_md", { fg = devIconBlueFg })
  any("DevIcon_OE_yml", { fg = devIconWhiteFg })
  any("DevIcon_OE_yaml", { fg = devIconWhiteFg })
  any("DevIcon_OE_toml", { fg = devIconWhiteFg })
  any("DevIcon_OE_txt", { fg = devIconWhiteFg })
  any("DevIcon_OE_Dockerfile", { fg = devIconBlueFg })
  any("DevIcon_OE_dockerignore", { fg = devIconBlueFg })
  any("DevIcon_OE_service", { fg = devIconYellowFg })
  any("DevIcon_OE_timer", { fg = devIconYellowFg })
  any("DevIcon_OE_c", { fg = devIconBlueFg })
  any("DevIcon_OE_html", { fg = devIconRedFg })
  any("DevIcon_OE_bak", { fg = devIconWhiteFg })
  any("DevIcon_OE_out", { fg = devIconWhiteFg })
  any("DevIcon_OE_json", { fg = devIconYellowFg })
  any("DevIcon_OE_js", { fg = devIconYellowFg })
  any("DevIcon_OE_ts", { fg = devIconBlueFg })
  any("DevIcon_OE_tsx", { fg = devIconBlueFg })
  any("DevIcon_OE_css", { fg = devIconBlueFg })
  any("DevIcon_OE_png", { fg = devIconWhiteFg })
  any("DevIcon_OE_jpeg", { fg = devIconWhiteFg })
  any("DevIcon_OE_jpg", { fg = devIconWhiteFg })
  any("DevIcon_OE_xml", { fg = devIconRedFg })
  any("DevIcon_OE_svg", { fg = devIconRedFg })
  any("DevIcon_OE_lua", { fg = devIconBlueFg })
  any("DevIcon_OE_scm", { fg = devIconWhiteFg })
  any("DevIcon_OE_TEMPLATE", { fg = devIconWhiteFg })

  -- Plugin: nvim-tree
  local nvimTreeFolderFg = c.yellow
  local nvimTreeGitNewFg = c.red
  local nvimTreeGitDirtyFg = c.blueBright
  local nvimTreeGitStagedFg = green1
  local nvimTreeGitDirtyFg = c.blueBright
  local nvimTreeGitNewFg = c.red
  local nvimTreeGitStagedFg = green1
  local nvimTreeGitMergeFg = c.red
  local nvimTreeGitRenamedFg = c.red
  local nvimTreeGitDeletedFg = c.red
  local nvimTreeGitIgnoredFg = c.blackBright

  any("NvimTreeSpecialFile", { fg = c.cursor, bold = false })
  any("NvimTreeImageFile", { fg = c.cursor, bold = false })
  any("NvimTreeFolderName", { fg = nvimTreeFolderFg, bold = false })
  any("NvimTreeEmptyFolderName", { fg = nvimTreeFolderFg, bold = false })
  any("NvimTreeOpenedFolderName", { fg = nvimTreeFolderFg , bold = false })
  any("NvimTreeFolderIcon", { fg = nvimTreeFolderFg, bold = false })
  any("NvimTreeOpenedFolderIcon", { fg =  nvimTreeFolderFg, bold = false })
  any("NvimTreeExecFile", { fg = c.cursor, bold = false })
  any("NvimTreeSymlink", { fg = c.cursor, underline = false })
  any("NvimTreeSymlinkFolderName", { fg =  nvimTreeFolderFg, underline = false })


  any("NvimTreeGitDirtyIcon",       { fg = nvimTreeGitDirtyFg })
  any("NvimTreeGitFileDirtyHL",     { fg = nvimTreeGitDirtyFg })
  any("NvimTreeGitFolderDirtyHL",   { fg = nvimTreeGitDirtyFg })
  any("NvimTreeGitNewIcon",         { fg = nvimTreeGitNewFg })
  any("NvimTreeGitFileNewHL",       { fg = nvimTreeGitNewFg })
  any("NvimTreeGitFolderNewHL",     { fg = nvimTreeGitNewFg })
  any("NvimTreeGitStagedIcon",      { fg = nvimTreeGitStagedFg })
  any("NvimTreeGitFileStagedHL",    { fg = nvimTreeGitStagedFg })
  any("NvimTreeGitFolderStagedHL",  { fg = nvimTreeGitStagedFg })
  any("NvimTreeGitMergeIcon",       { fg = nvimTreeGitMergeFg })
  any("NvimTreeGitFileMergeHL",     { fg = nvimTreeGitMergeFg })
  any("NvimTreeGitFolderMergeHL",   { fg = nvimTreeGitMergeFg })
  any("NvimTreeGitRenamedIcon",     { fg = nvimTreeGitRenamedFg })
  any("NvimTreeGitFileRenamedHL",   { fg = nvimTreeGitRenamedFg })
  any("NvimTreeGitFolderRenamedHL", { fg = nvimTreeGitRenamedFg })
  any("NvimTreeGitDeletedIcon",     { fg = nvimTreeGitDeletedFg })
  any("NvimTreeGitFileDeletedHL",   { fg = nvimTreeGitDeletedFg })
  any("NvimTreeGitFolderDeletedHL", { fg = nvimTreeGitDeletedFg })
  any("NvimTreeGitIgnoredIcon",     { fg = nvimTreeGitIgnoredFg })
  any("NvimTreeGitFileIgnoredHL",   { fg = nvimTreeGitIgnoredFg })
  any("NvimTreeGitFolderIgnoredHL", { fg = nvimTreeGitIgnoredFg })

  -- Language: any
  fg('@lw_keyword', c.blue)
  fg('@lw_literal', blue1)
  fg('@lw_string', green2)
  any('@lw_null', { fg = blue1, bold = true })

  -- Language: java
  any("@lwjava_comment", { fg = c.blackBright, italic = true })
  any('@lwjava_import_ref', { fg = c.cursorText })
  any('@lwjava_field_ref', { fg = c.blueBright, bold = false })
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
  any("@lsp.type.class.java", { fg = c.foreground }) -- Ensures Inner class gets colored white vs a field access like System.out.
  any("@lsp.typemod.keyword.documentation.java", {fg = c.blackBright, bold = true, underline = true})
  any("@lsp.typemod.parameter.documentation.java", {fg = c.blackBright, bold = true, underline = false})
  any("LSP_CODE", {link="LINK_TO"})
  any("LSP_CODE", {link="LINK_TO"})


  -- Language: c
  -- TODO

  return mappings
end

return M
