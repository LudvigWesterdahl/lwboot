
[
 (character_literal)
(string_literal)
] @lw_string (#set! priority 90)

(string_literal (escape_sequence) @lw_keyword)
; (import_declaration) @lw_import_keyword (#set! priority 90)
; (import_declaration (scoped_identifier) @lwjava_import_ref)

; Found using:
; nvim --headless -c "lua print(vim.inspect(vim.treesitter.language.inspect('java')))" -c "q" 2>&1 | grep -o '"[^"]*"' | sort -u


; ====================
; lwjava_XXXX
; ====================
(field_access object: (identifier) field: (identifier) @lwjava_field_ref)

(enum_constant) @lwjava_field_ref

; ====================
; lwjava_annotation
; ====================

(annotation name: (identifier) @lwjava_annotation)
(annotation_type_declaration name: (identifier) @lwjava_annotation)
(annotation "@" @lwjava_annotation)
(marker_annotation) @lwjava_annotation

; ====================
; lwjava_comment
; ====================
[
(line_comment)
(block_comment)
 ] @lwjava_comment

; ====================
; lw_literal
; ====================
[
 (true)
 (false)
 (null_literal)
 (decimal_integer_literal)
(decimal_floating_point_literal)
 ] @lw_literal

; ====================
; lw_keyword
; ====================
[
  (boolean_type)
  (integral_type)
  (floating_point_type)
  (void_type)
 (this)
 (super)
] @lw_keyword



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

