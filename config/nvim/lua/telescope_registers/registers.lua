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
            .. "CLOBBERS MARKS: a, b"
            .. "",
        value = [=[yi(/{<CR>o<Space><Esc>maO<C-O>p<Esc>mb'akA,<Esc>:'b,'as/final<Space>//gIe<CR>:'b,'as/@\S\+(\(\n\|[^)]\)\+)//gIe<CR>:'b,'as/@\S\+//gIe<CR>:'b,'as/\[\(\n\|[^\]]\)*\]//gIe<CR>:for<Space>i<Space>in<Space>range(10)<Space>|<Space>'b,'as/<\(\n\|[^<>]\)*>/<Space>/gIe<Space>|<Space>endfor<CR>:'b,'as/,/;\r/gI<CR>:'b,'ag/^\s\?$/d<CR>:'b,'as/\(\S\+\)\(\s\|\n\)\+\([^;]\+\);/Objects.requireNonNull(\3);/<CR>'a]=],
    },
    {
        reg = "l",
        name = "java loop over list",
        desc = "Java loop over all elements in an list/iterable parameter or local variable.\n"
            .. "\n"
            .. "BEFORE 1:\n"
            .. "public void doSomething(List<Object> items) {\n"
            .. "    // empty\n"
            .. "}\n"
            .. "\n"
            .. "AFTER 1:\n"
            .. "public void doSomething(List<Object> items) {\n"
            .. "    for (final Object item : items) {\n"
            .. "    }\n"
            .. "    // empty\n"
            .. "}\n"
            .. "\n"
            .. "BEFORE 2:\n"
            .. "Iterable<Object> items = new ArrayList<>();\n"
            .. "// below\n"
            .. "\n"
            .. "AFTER 2:\n"
            .. "Iterable<Object> items = new ArrayList<>();\n"
            .. "for (final Object item : items) {\n"
            .. "}\n"
            .. "// below\n"
            .. "\n"
            .. "CURSOR POSITION: on the container type such that a f< finds the start of the generic type.\n"
            .. "CLOBBERS MARKS: none"
            .. "",
        value = [=[:let<Space>savea<Space>=<Space>getreginfo('a')<CR>f<lt><Ignore>"ay%%wyiwofor<Space>(final<Space><C-O>"ap<Space><C-O>p<BS><Space>:<Space><C-O>p)<Space>{}<Esc>0f<lt><Ignore>xf:<Ignore>bgexf{<Ignore>a<CR><Esc>k$:call<Space>setreg('a',<Space>savea)<CR>]=],
    },
    {
        reg = "l",
        name = "java loop over map",
        desc = "Java loop over the entry set of a map parameter or local variable.\n"
            .. "\n"
            .. "BEFORE 1:\n"
            .. "public void doSomething(Map<Object, Object> items) {\n"
            .. "    // empty\n"
            .. "}\n"
            .. "\n"
            .. "AFTER 1:\n"
            .. "public void doSomething(Map<Object, Object> items) {\n"
            .. "    for (final Map.Entry<Object, Object> entry : items.entrySet()) {\n"
            .. "    }\n"
            .. "    // empty\n"
            .. "}\n"
            .. "\n"
            .. "BEFORE 2:\n"
            .. "Map<Object, Object> items = new HashMap<>();\n"
            .. "// below\n"
            .. "\n"
            .. "AFTER 2:\n"
            .. "Map<Object, Object> items = new HashMap<>();\n"
            .. "for (final Map.Entry<Object, Object> entry : items.entrySet()) {\n"
            .. "}\n"
            .. "// below\n"
            .. "\n"
            .. "CURSOR POSITION: on the container type such that a f< finds the start of the generic type.\n"
            .. "CLOBBERS MARKS: none"
            .. "",
        value = [=[:let<Space>savea<Space>=<Space>getreginfo('a')<CR>f<lt><Ignore>"ay%%wyiwofor<Space>(final<Space>Map.Entry<C-O>"ap<Space>entry<Space>:<Space><C-O>p.entrySet())<C-O>a<Space>{}<Esc>0f{<Ignore>a<CR><Esc>k$<Esc>:call<Space>setreg('a',<Space>savea)<CR>]=],
    },
    {

        reg = "m",
        name = "java map all elements",
        desc = "Java create a function below a single function that maps all elements. \n"
            .. "\n"
            .. "BEFORE:\n"
            .. "public String toString(final Object element) {\n"
            .. "    return element.toString();\n"
            .. "}\n"
            .. "\n"
            .. "AFTER:\n"
            .. "public String toString(final Object element) {\n"
            .. "    return element.toString();\n"
            .. "}\n"
            .. "public List< String> toStrings(final Collection<? extends Object> elements) {\n"
            .. "    Objects.requireNonNull(elements);\n"
            .. "\n"
            .. "    final List<String> result = new ArrayList<>(elements.size());\n"
            .. "    for (final Object element : elements) {\n"
            .. "        Objects.requireNonNull(element);\n"
            .. "\n"
            .. "        result.add(toString(element));\n"
            .. "    }\n"
            .. "\n"
            .. "    return result;\n"
            .. "}\n"
            .. "\n"
            .. "CURSOR POSITION: on the function definition line.\n"
            .. "CLOBBERS MARKS: a, b, c"
            .. "",
        value = [=[0ma/{<CR>%mb:'a,'bt<Space>.<CR>'bj0yi(/{<CR>o<Space><Esc>maO<C-O>p<Esc>mb'akA,<Esc>:'b,'as/final<Space>//gIe<CR>:'b,'as/@\S\+(\(\n\|[^)]\)\+)//gIe<CR>:'b,'as/@\S\+//gIe<CR>:'b,'as/\[\(\n\|[^\]]\)*\]//gIe<CR>:let<Space>savea<Space>=<Space>getreginfo('a')<CR>:let<Space>saveb<Space>=<Space>getreginfo('b')<CR>:let<Space>savec<Space>=<Space>getreginfo('c')<CR>:let<Space>saved<Space>=<Space>getreginfo('d')<CR>'bkmc'a?,<CR>xb"bdiw:'b,'ad<Space>a<CR>'c/(<CR>bb"cyiWW"dyiw:call<Space>setreg('a',<Space>getreg('a',<Space>1,<Space>1),<Space>'v')<CR>:call<Space>setreg('b',<Space>getreg('b',<Space>1,<Space>1),<Space>'v')<CR>:call<Space>setreg('a',<Space>substitute(getreg('a'),<Space>'\_s\+$',<Space>'',<Space>''),<Space>'v')<CR>:call<Space>setreg('b',<Space>substitute(getreg('b'),<Space>'\_s\+$',<Space>'',<Space>''),<Space>'v')<CR>'c/(<CR>geas<Esc>/(<CR>ci(final<Space>Collection<lt>?<Space>extends<Space><C-O>"aP<Esc>/)<CR>i><Space><C-O>"bPs<Esc>'coObjects.requireNonNull(<C-O>"bps);<CR><CR>final<Space>List<lt><C-O>"cp><Space>result<Space>=<Space>new<Space>ArrayList<lt>>(<C-O>"bps.size());<Esc>ma'aofor<Space>(final<Space><C-O>"ap<Space><C-O>"bp<Space>:<Space><C-O>"bps)<Space>{}<Esc>i<CR><C-O>OObjects.requireNonNull(<C-O>"bp);<CR><Esc>'a3ji<CR>result.add(<C-O>"dp(<C-O>"bp));<Esc>'a/return<CR>cc<CR>return<Space>result;<Esc>'c/(<CR>bbciWList<lt><C-O>"cp><Space><Esc>:call<Space>setreg('a',<Space>savea)<CR>:call<Space>setreg('b',<Space>saveb)<CR>:call<Space>setreg('c',<Space>savec)<CR>:call<Space>setreg('d',<Space>saved)<CR>]=],
    },
}
