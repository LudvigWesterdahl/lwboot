; ============================================================
; lwbash
; ============================================================

; ====================
; lwbash_variable
; ====================
(variable_name) @lwbash_variable

; ====================
; lwbash_cmd
; ====================
(command name: (command_name) @lwbash_cmd)

; ====================
; lwbash_exp
; ====================
; ((expansion) @lwbash_exp (#set! priority 90))
; Only works for certain anonymous tokens, see command under lw_keyword
(expansion ["${" ":-" "}"] @lwbash_exp (#set! priority 90))

; ====================
; lwbash_cmd_sub
; ====================
; ((command_substitution) @lwbash_cmd_sub (#set! priority 85))
; Only works for certain anonymous tokens, see command under lw_keyword
(command_substitution ["$(" ")"] @lwbash_cmd_sub (#set! priority 85))

; ====================
; lwbash_ret_success
; ====================
((command
   name: (command_name) @_n
   argument: (number) @lwbash_ret_success)
 (#any-of? @_n "return" "exit")
 (#match? @lwbash_ret_success "^0+$")
 (#set! priority 110))

; ====================
; lwbash_ret_failure
; ====================
((command
   name: (command_name) @_n
   argument: (number) @lwbash_ret_failure)
 (#any-of? @_n "return" "exit")
 (#set! priority 109))

; ============================================================
; lw
; ============================================================

; ====================
; lw_literal
; ====================
(number) @lw_literal

; ====================
; lw_string
; ====================
((string) @lw_string (#set! priority 80))
((raw_string) @lw_string (#set! priority 80))

; ====================
; lw_null
; ====================

; ====================
; lw_function_declaration
; ====================
(function_definition name: (word) @lw_function_declaration)

; ====================
; lw_comment
; ====================
(comment) @lw_comment

; ====================
; lw_keyword
; ====================
((command_name) @lw_keyword
 (#any-of? @lw_keyword
   "return"
   "break"
   "continue"
   "exit"
   "shift")
 (#set! priority 105))

; nvim --headless -c "lua print(vim.inspect(vim.treesitter.language.inspect('bash')))" -c "q" 2>&1 | grep -o '"[^"]*"' | sort -u
[
"case"
"declare"
"do"
"done"
"elif"
"else"
"esac"
"export"
"fi"
"for"
"if"
"in"
"local"
"readonly"
"then"
"until"
"while"
 ] @lw_keyword


