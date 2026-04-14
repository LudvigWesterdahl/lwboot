
(string_literal) @lw_string


; (import_declaration) @lw_import_keyword (#set! priority 90)
(import_declaration (scoped_identifier) @lw_import_ref)

; Found using:
; nvim --headless -c "lua print(vim.inspect(vim.treesitter.language.inspect('java')))" -c "q" 2>&1 | grep -o '"[^"]*"' | sort -u

[
 "abstract"
 "assert"
 "break"
 "case"
 "catch"
 "class"
 "continue"
; "const"
 "default"
 "do"
 "else"
 "enum"
 "exports"
 "extends"
 "final"
 "finally"
 "for"
; "goto"
 "if"
 "implements"
 "import"
 "instanceof"
 "interface"
 "@interface"
 "long"
 "module"
 "native"
 "new"
 "package"
 "private"
 "protected"
 "public"
 "requires"
 "return"
 "static"
 "strictfp"
; "super"
 "switch"
 "synchronized"
; "this"
 "throw"
 "throws"
 "transient"
 "try"
; "var"
; "void"
 "volatile"
 "while"
; "true"
; "false"
; "null"
 ] @lw_keyword

[
  (boolean_type)
  (integral_type)
  (floating_point_type)
  (void_type)
] @lw_keyword


