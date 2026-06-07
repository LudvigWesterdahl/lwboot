local M = {}

M.setup = function()
    local mappings = {}

    local function any(key, val)
        mappings[key] = val
    end

    local c = {
        background = "#ffffff",
        foreground = "#000000",
        cursor = "#000000",
        cursorText = "#ffffff",
        black = "#000000",
        blackBright = "#666666",
        red = "#990000",
        redBright = "#e50000",
        green = "#00a600",
        greenBright = "#00d900",
        yellow = "#999900",
        yellowBright = "#e5e500",
        blue = "#0000b2",
        blueBright = "#0000ff",
        magenta = "#b200b2",
        magentaBright = "#e500e5",
        cyan = "#00a6b2",
        cyanBright = "#00e5e5",
        white = "#bfbfbf",
        whiteBright = "#e5e5e5",
    }

    -- From intellij default light theme
    local blue1 = "#1750eb"
    local blue2 = "#0033b3"
    local green1 = "#067d17"
    local magenta1 = "#871094"
    local cyan1 = "#00627a"
    local yellow1 = "#fcd47e"
    local yellow2 = "#9e880d"
    -- Adjustments
    blue2 = "#0030A8"
    green1 = "#066F16"
    magenta1 = "#790F85"
    cyan1 = "#005e75"
    yellow2 = "#927E0C"

    -- General
    any("Normal", { bg = c.background, fg = c.foreground })
    any("Cursor", { bg = c.cursor, fg = c.cursorText })
    any("FloatBorder", { bg = c.background, fg = c.cursor })
    any("NormalFloat", { bg = c.background })
    any("StatusLine", { bg = c.white })
    any("StatusLineNC", { bg = c.whiteBright })
    -- fixes cyan coloring of guifg= stuff.
    any("Special", { fg = c.cursor })
    any("Function", { fg = c.cursor })
    any("Directory", { fg = c.cursor })
    any("MsgArea", { bg = c.background })
    
    -- Lsp
    any("LspSignatureActiveParameter", { bg = c.background })

    local searchBg = yellow1
    local searchFg = c.cursor
    any("Search", { bg = searchBg, fg = searchFg, bold = false, underline = false })
    any("IncSearch", { bg = searchBg, fg = searchFg, bold = false, underline = false })
    any("CurSearch", { bg = c.cursor, fg = c.cursorText, bold = false, underline = false })

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

    -- Info
    any("DiagnosticVirtualTextInfo", { fg = c.blackBright })
    any("DiagnosticVirtualLinesInfo", { fg = c.blackBright })
    any("DiagnosticUnderlineInfo", {})
    any("DiagnosticSignInfo", { fg = c.blackBright, bold = true })
    any("DiagnosticFloatingInfo", { fg = c.cursor })

    -- Warn
    any("DiagnosticVirtualTextWarn", { fg = c.yellow })
    any("DiagnosticVirtualLinesWarn", { fg = c.yellow })
    any("DiagnosticUnderlineWarn", {})
    any("DiagnosticSignWarn", { fg = c.blackBright, bold = true })
    any("DiagnosticFloatingWarn", { fg = c.cursor })

    -- Error
    any("DiagnosticVirtualTextError", { fg = c.blackBright })
    any("DiagnosticVirtualLinesError", { fg = c.blackBright })
    any("DiagnosticUnderlineError", { fg = c.blackBright, sp = c.red, undercurl = true })
    any("DiagnosticSignError", { fg = c.red, bold = true })
    any("DiagnosticFloatingError", { fg = c.cursor })

    any("DiagnosticUnnecessary", { fg = c.blackBright })
    any("DiagnosticDeprecated", { strikethrough = true })

    -- Plugin: telescope
    any("TelescopeMatching", { fg = c.yellow, bold = true })
    any("TelescopeSelection", { bg = c.whiteBright })
    any("TelescopeSelectionCaret", { fg = c.cursor, bold = true })
    any("TelescopePromptPrefix", { link = "TelescopeSelectionCaret" })
    any("TelescopePreviewLine", { bg = c.whiteBright })

    -- Plugin: blink
    -- https://cmp.saghen.dev/configuration/appearance
    any("BlinkCmpMenu", { bg = c.background })
    any("BlinkCmpMenuBorder", { bg = c.background })
    any("BlinkCmpMenuSelection", { bg = c.whiteBright })
    any("BlinkCmpDoc", { bg = c.background })
    any("BlinkCmpDocBorder", { bg = c.background })
    any("BlinkCmpLabelDescription", { bg = c.background })
    any("BlinkCmpKind", { bg = c.background })

    -- Plugin: flash
    local flashFg = c.white
    any("FlashBackdrop", { fg = flashFg })
    any("FlashMatch", { fg = flashFg, bg = "NONE" })
    any("FlashCurrent", { fg = flashFg, bg = "NONE" })
    -- any("FlashLabel", { fg = c.foreground, bg = c.yellowBright, bold = false })
    any("FlashLabel", { fg = c.redBright, bg = "NONE", bold = true })

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
    local nvimTreeFolderFg = c.cursor
    local nvimTreeGitNewFg = c.red
    local nvimTreeGitDirtyFg = c.blue
    local nvimTreeGitStagedFg = c.green
    local nvimTreeGitDirtyFg = c.blue
    local nvimTreeGitNewFg = c.red
    local nvimTreeGitStagedFg = c.green
    local nvimTreeGitMergeFg = c.red
    local nvimTreeGitRenamedFg = c.red
    local nvimTreeGitDeletedFg = c.red
    local nvimTreeGitIgnoredFg = c.yellow

    any("NvimTreeSpecialFile", { fg = c.cursor, bold = false })
    any("NvimTreeImageFile", { fg = c.cursor, bold = false })
    any("NvimTreeFolderName", { fg = nvimTreeFolderFg, bold = false })
    any("NvimTreeEmptyFolderName", { fg = nvimTreeFolderFg, bold = false })
    any("NvimTreeOpenedFolderName", { fg = nvimTreeFolderFg, bold = false })
    any("NvimTreeFolderIcon", { fg = nvimTreeFolderFg, bold = false })
    any("NvimTreeOpenedFolderIcon", { fg = nvimTreeFolderFg, bold = false })
    any("NvimTreeExecFile", { fg = c.cursor, bold = false })
    any("NvimTreeSymlink", { fg = c.cursor, underline = false })
    any("NvimTreeSymlinkFolderName", { fg = nvimTreeFolderFg, underline = false })
    any("NvimTreeCursorLine", { bg = c.whiteBright })

    any("NvimTreeGitDirtyIcon", { fg = nvimTreeGitDirtyFg })
    any("NvimTreeGitFileDirtyHL", { fg = nvimTreeGitDirtyFg })
    any("NvimTreeGitFolderDirtyHL", { fg = nvimTreeGitDirtyFg })
    any("NvimTreeGitNewIcon", { fg = nvimTreeGitNewFg })
    any("NvimTreeGitFileNewHL", { fg = nvimTreeGitNewFg })
    any("NvimTreeGitFolderNewHL", { fg = nvimTreeGitNewFg })
    any("NvimTreeGitStagedIcon", { fg = nvimTreeGitStagedFg })
    any("NvimTreeGitFileStagedHL", { fg = nvimTreeGitStagedFg })
    any("NvimTreeGitFolderStagedHL", { fg = nvimTreeGitStagedFg })
    any("NvimTreeGitMergeIcon", { fg = nvimTreeGitMergeFg })
    any("NvimTreeGitFileMergeHL", { fg = nvimTreeGitMergeFg })
    any("NvimTreeGitFolderMergeHL", { fg = nvimTreeGitMergeFg })
    any("NvimTreeGitRenamedIcon", { fg = nvimTreeGitRenamedFg })
    any("NvimTreeGitFileRenamedHL", { fg = nvimTreeGitRenamedFg })
    any("NvimTreeGitFolderRenamedHL", { fg = nvimTreeGitRenamedFg })
    any("NvimTreeGitDeletedIcon", { fg = nvimTreeGitDeletedFg })
    any("NvimTreeGitFileDeletedHL", { fg = nvimTreeGitDeletedFg })
    any("NvimTreeGitFolderDeletedHL", { fg = nvimTreeGitDeletedFg })
    any("NvimTreeGitIgnoredIcon", { fg = nvimTreeGitIgnoredFg })
    any("NvimTreeGitFileIgnoredHL", { fg = nvimTreeGitIgnoredFg })
    any("NvimTreeGitFolderIgnoredHL", { fg = nvimTreeGitIgnoredFg })

    -- Language: any
    any("@lw_literal", { fg = blue1 })
    any("@lw_string", { fg = green1 })
    any("@lw_null", { fg = blue1, bold = true })
    any("@lw_function_declaration", { fg = cyan1 })
    any("@lw_comment", { fg = c.blackBright, italic = true })
    any("@lw_keyword", { fg = blue2 })

    -- Language: java
    any("@lwjava_import_ref", { fg = c.blackBright })
    any("@lwjava_field_ref", { fg = magenta1, bold = false })
    any("@lwjava_annotation", { fg = yellow2, italic = false })
    any("@lwjava_import_asterisk", { fg = yellow2, bold = true })
    any("@lwjava_import_keyword", { link = "@lwjava_import_ref" })

    -- Language: bash
    any("@lwbash_variable", { fg = magenta1 })
    any("@lwbash_cmd", { fg = c.cursor })
    any("@lwbash_exp", { fg = magenta1 })
    any("@lwbash_cmd_sub", { link = "@lwbash_exp" })
    any("@lwbash_ret_success", { fg = green1, bold = false })
    any("@lwbash_ret_failure", { fg = c.red, bold = false })

    -- LSP: java
    any("@lsp.mod.importDeclaration.java", { link = "@lwjava_import_ref" })
    any("@lsp.typemod.annotation.importDeclaration.java", { link = "@lwjava_annotation" })
    any("@lsp.type.annotation.java", { link = "@lwjava_annotation" })
    any("@lsp.type.modifier.java", { link = "@lw_keyword" })
    any("@lsp.typemod.enumMember.static.java", { link = "@lwjava_field_ref" })
    any("@lsp.type.property.java", { link = "@lwjava_field_ref" })
    any("@lsp.typemod.method.static.java", { italic = true })
    any("@lsp.typemod.property.static.java", { italic = true })
    any("@lsp.type.method.java", { link = "@lsp" })
    -- Ensures Inner class gets colored white vs a field access like System.out.
    any("@lsp.type.class.java", { fg = c.foreground })
    any("@lsp.typemod.keyword.documentation.java", { fg = c.blackBright, bold = true, underline = true })
    any("@lsp.typemod.parameter.documentation.java", { fg = c.blackBright, bold = true, underline = false })
    any("@lsp.typemod.typeParameter.declaration.java", { link = "@lw_function_declaration" })
    any("@lsp.typemod.typeParameter.typeArgument.java", { link = "@lw_function_declaration" })
    any("LSP_CODE", { link = "LINK_TO" })
    any("LSP_CODE", { link = "LINK_TO" })
    any("LSP_CODE", { link = "LINK_TO" })
    any("LSP_CODE", { link = "LINK_TO" })
    any("LSP_CODE", { link = "LINK_TO" })

    -- Language: c
    -- TODO

    return mappings
end

return M
