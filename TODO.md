# TODO

### 1. macro picker
Create a picker for activating a macro in a simple format like for abbreviations.
If you press <CR> then it is activated in the default register, but typing a named
register before will use that instead.

The picker should show the short description text and default register. It should
also allow searching.

Start with:
s - camel2snake
vi":s/\%V\(\l\)\(\u\)/\1_\l\2/gI

### 2. brightness command
See qdbus6 org.kde.Solid.PowerManagement /org/kde/Solid/PowerManagement/Actions/BrightnessControl

### 3. delete TMP and empty lines
Keymap to quickly delete all blank lines and lines matching ^TMP$.

### 4. Ollama chat over text file
Add integration with nvim.
- Keymap to start a message and open up the text file in a new buffer.
- Keymap to quickly analyze a file for bugs

Additional keymap needed for nvim to paste contents of a register and prefix all lines with a line number :'[,']!nl -s ': '
Maybe nnoremap <leader>p ...

Other features:
- Append instructions in the beginning
- Prefix all lines with a number to prevent model from counting
