-- Given a macro in register s
--
-- 1. put =keytrans(getreg('s'))
-- 2. Wrap in [=[STR]=]
-- 3. If breaks the ]] ending just add equal signs to both sides, ex [===[STR]===]
--
-- A literal `<` must be written as <lt>, handled by keytrans
--
-- See :help '< or :help `< for the suffix.
return {
    {
        reg = "s",
        name = "camel2snake_word",
        desc = "Converts a word from camel to snake",
        value = [=[viw:s/\%V\(\u\)/_\l\1/gIe<CR>`<]=],
    },
    {
        reg = "s",
        name = "camel2snake_string",
        desc = "Converts a string from camel to snake",
        value = [=[vi":s/\%V\(\u\)/_\l\1/gIe<CR>`<]=],
    },
    {
        reg = "s",
        name = "camel2kebab_word",
        desc = "Converts a word from camel to kebab",
        value = [=[viw:s/\%V\(\u\)/-\l\1/gIe<CR>`<]=],
    },
    {
        reg = "s",
        name = "camel2kebab_string",
        desc = "Converts a string from camel to kebab",
        value = [=[vi":s/\%V\(\u\)/-\l\1/gIe<CR>`<]=],
    },
}
