-- Given a macro in register s
--
-- 1. put =keytrans(getreg('s'))
-- 2. Wrap in [=[STR]=]
-- 3. If breaks the ]] ending just add equal signs to both sides, ex [===[STR]===]
--
-- A literal `<` must be written as <lt>, handled by keytrans
--
-- See :help '< or :help `< for the suffix.
--
-- If you pasted using keytrans, to reverse it (under development)
-- 1. escape backslash: s/\\/\\\\/gI
-- 2. escape keycodes: s/</\\</gI
-- 3. copy the line
-- 4. set the register: :let @q="<line here>"
return {
    {
        reg = "s",
        name = "camel 2 snake word",
        desc = "Converts a word from camel to snake",
        value = [=[viw:s/\%V\(\u\)/_\l\1/gIe<CR>`<]=],
    },
    {
        reg = "s",
        name = "camel 2 snake string",
        desc = "Converts a string from camel to snake",
        value = [=[vi":s/\%V\(\u\)/_\l\1/gIe<CR>`<]=],
    },
    {
        reg = "s",
        name = "camel 2 kebab word",
        desc = "Converts a word from camel to kebab",
        value = [=[viw:s/\%V\(\u\)/-\l\1/gIe<CR>`<]=],
    },
    {
        reg = "s",
        name = "camel 2 kebab string",
        desc = "Converts a string from camel to kebab",
        value = [=[vi":s/\%V\(\u\)/-\l\1/gIe<CR>`<]=],
    },
    {
        reg = "f",
        name = "format remove trailing space",
        desc = "Removes trailing spaces at the end of lines.",
        value = [=[:%s/\s\+$//<CR>]=],
    },
    {
        reg = "r",
        name = "java requireNonNull for all parameters",
        desc = "Java requireNonNull for all parameters.\n"
            .. "\n"
            .. "BEFORE:\n"
            .. "public void myFunction(final Object param1, final Object param2) {\n"
            .. "    // empty\n"
            .. "}\n"
            .. "\n"
            .. "AFTER:\n"
            .. "public void myFunction(final Object param1, final Object param2) {\n"
            .. "    Objects.requireNonNull(param1);\n"
            .. "    Objects.requireNonNull(param2);\n"
            .. "    // empty\n"
            .. "}\n"
            .. "\n"
            .. "CURSOR POSITION: such that a yank inside parentheses yi( captures the function parameters.\n"
            .. "CLOBBERS MARKS: a, b\n"
            .. "",
        value = [=[yi(/{<CR>o<Space><Esc>maO<C-O>p<Esc>mb'akA,<Esc>:'b,'as/final<Space>//gIe<CR>:'b,'as/@\S\+(\(\n\|[^)]\)\+)//gIe<CR>:'b,'as/@\S\+//gIe<CR>:'b,'as/\[\(\n\|[^\]]\)*\]//gIe<CR>:for<Space>i<Space>in<Space>range(10)<Space>|<Space>'b,'as/<\(\n\|[^<>]\)*>/<Space>/gIe<Space>|<Space>endfor<CR>:'b,'as/,/;\r/gI<CR>:'b,'ag/^\s\?$/d<CR>:'b,'as/\(\S\+\)\(\s\|\n\)\+\([^;]\+\);/Objects.requireNonNull(\3);/<CR>'a]=],
    },
}
