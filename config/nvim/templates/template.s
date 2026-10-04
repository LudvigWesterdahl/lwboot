# NAME
#     TEMPLATE - DESC
#
# SYNOPSIS
#     as TEMPLATE.s -o TEMPLATE.o && ld TEMPLATE.o -o a.out && ./a.out ; echo "${?}" && rm a.out
#
# DESCRIPTION
#     ISA: x86-64
#     Syntax: AT&T
#
# SEE ALSO
#     -
#
# date

# func - desc
#
# input:
#   rx: desc
# output:
#   rx: desc
# clobbers:
#   rx: desc

.globl _start

.section .text

_start:
    movl $0, %edi
    movl $60, %eax
    syscall

