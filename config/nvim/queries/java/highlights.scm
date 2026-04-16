; ====================
; lwjava_field_ref
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
(line_comment) @lwjava_comment
(block_comment) @lwjava_comment

; ====================
; lwjava_import_ref
; ====================
(import_declaration (scoped_identifier) @lwjava_import_ref)

; ====================
; lwjava_import_asterisk
; ====================
(import_declaration (asterisk) @lwjava_import_asterisk)

; ====================
; lwjava_import_keyword
; ====================
"import" @lwjava_import_keyword

; ====================
; lw_string
; ====================
(character_literal)  @lw_string (#set! priority 90)
(string_literal)  @lw_string (#set! priority 90)

; ====================
; lw_null
; ====================
(null_literal) @lw_null

; ====================
; lw_literal
; ====================
[(true) (false)] @lw_literal
[(decimal_integer_literal) (decimal_floating_point_literal)] @lw_literal
(string_literal (escape_sequence) @lw_literal)

; ====================
; lw_keyword
; ====================
; nvim --headless -c "lua print(vim.inspect(vim.treesitter.language.inspect('java')))" -c "q" 2>&1 | grep -o '"[^"]*"' | sort -u
(this) @lw_keyword
(super) @lw_keyword
[
 (boolean_type)
 (integral_type)
 (floating_point_type)
 (void_type)
 ] @lw_keyword


[
 "abstract"
 "assert"
 "break"
 "case"
 "catch"
 "class"
 "continue"
 "default"
 "do"
 "else"
 "enum"
 "exports"
 "extends"
 "final"
 "finally"
 "for"
 "if"
 "implements"
 ; "import"
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
 "switch"
 "synchronized"
 "throw"
 "throws"
 "transient"
 "try"
 "volatile"
 "while"
 ] @lw_keyword

