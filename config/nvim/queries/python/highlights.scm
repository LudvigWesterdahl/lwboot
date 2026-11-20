; ============================================================
; lwpython
; ============================================================

; ====================
; lwpython_import_ref
; ====================
(import_statement
  name: (dotted_name
    (identifier) @lwpython_import_ref))
(import_statement
  name: (aliased_import
    name: (dotted_name
      (identifier) @lwpython_import_ref)))
(import_statement
  name: (aliased_import
    alias: (identifier) @lwpython_import_ref))
(import_from_statement
  module_name: (dotted_name
    (identifier) @lwpython_import_ref))
(import_from_statement
  module_name: (relative_import
    (dotted_name
      (identifier) @lwpython_import_ref)))
(import_from_statement
  name: (dotted_name
    (identifier) @lwpython_import_ref))
(import_from_statement
  name: (aliased_import
    name: (dotted_name
      (identifier) @lwpython_import_ref)))
(import_from_statement
  name: (aliased_import
    alias: (identifier) @lwpython_import_ref))
(future_import_statement
  "__future__" @lwpython_import_ref)
(future_import_statement
  name: (dotted_name
    (identifier) @lwpython_import_ref))
(future_import_statement
  name: (aliased_import
    name: (dotted_name
      (identifier) @lwpython_import_ref)))
(future_import_statement
  name: (aliased_import
    alias: (identifier) @lwpython_import_ref))

; ====================
; lwpython_field_ref
; ====================
((attribute
  attribute: (identifier) @lwpython_field_ref) @_attr
 (#not-has-parent? @_attr "call" "decorator")
 (#set! priority 128))
((class_definition
  body: (block
    (assignment
      left: (identifier) @lwpython_field_ref)))
 (#set! priority 128))
((class_definition
  body: (block
    (assignment
      left: (pattern_list
        (identifier) @lwpython_field_ref))))
 (#set! priority 128))

; ====================
; lwpython_decorator
; ====================
((decorator
  "@" @lwpython_decorator)
 (#set! priority 126))
((decorator
  (identifier) @lwpython_decorator)
 (#set! priority 126))
((decorator
  (attribute
    attribute: (identifier) @lwpython_decorator))
 (#set! priority 126))
((decorator
  (call
    function: (identifier) @lwpython_decorator))
 (#set! priority 126))
((decorator
  (call
    function: (attribute
      attribute: (identifier) @lwpython_decorator)))
 (#set! priority 126))

; ====================
; lwpython_import_asterisk
; ====================
((wildcard_import) @lwpython_import_asterisk (#set! priority 126))

; ============================================================
; lw
; ============================================================

; ====================
; lw_literal
; ====================
[(true) (false)] @lw_literal
(integer) @lw_literal
(float) @lw_literal
(ellipsis) @lw_literal
(escape_sequence) @lw_literal
(escape_interpolation) @lw_literal
((identifier) @lw_literal
 (#any-of? @lw_literal "NotImplemented" "Ellipsis"))

; ====================
; lw_string
; ====================
((string_start) @lw_string (#set! priority 90))
((string_end) @lw_string (#set! priority 90))
((string_content) @lw_string (#set! priority 90))

; ====================
; lw_null
; ====================
(none) @lw_null

; ====================
; lw_function_declaration
; ====================
(function_definition
  name: (identifier) @lw_function_declaration (#set! priority 128))

; ====================
; lw_comment
; ====================
(comment) @lw_comment

; ====================
; lw_keyword
; ====================
; nvim --headless -c "lua print(vim.inspect(vim.treesitter.language.inspect('python')))" -c "q" 2>&1 | grep -o '"[^"]*"' | sort -u
(type_conversion) @lw_keyword
((identifier) @lw_keyword
 (#any-of? @lw_keyword "self"))
[
 "and"
 "as"
 "assert"
 "async"
 "await"
 "break"
 "case"
 "class"
 "continue"
 "def"
 "del"
 "elif"
 "else"
 "except"
 "exec"
 "finally"
 "for"
 "from"
 "global"
 "if"
 "import"
 "in"
 "is"
 "lambda"
 "match"
 "nonlocal"
 "not"
 "or"
 "pass"
 "raise"
 "return"
 "try"
 "type"
 "while"
 "with"
 "yield"
 "is not"
 "not in"
] @lw_keyword
