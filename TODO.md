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

