# TODO

### 1. macro picker
Create a picker for activating a macro in a simple format like for abbreviations.

Should support specifying a) register, and b) a short description text.

Start with:
s - camel2snake
vi":s/\%V\(\l\)\(\u\)/\1_\l\2/gI
