# 32-bit RISC-like Processor

This is a short overview on the executables and overall directory structure.

### Contents of the folder

* **Makefile**
* **Directories:**
    * ./processor/
        * ie.v - module describing 32-bit CPU architecture
    * ./Programs/
        * Bubble Sort Program
        * GCD Program
* **Data Path.jpg :** diagram of CPU architecture
* **CPU 32bit.pdf :** consists of instruction set
* **Design of 32 bit processor.pdf :** short report on the project 

## Makefile

**Usage :**

The following are details of the content in makefile:

* `make test_sort`  : compiles and runs sort program
* `make test_gcd`   : compiles and runs gcd program
* `make clean`      : removes the compiled files

***Note:*** For testing the verilog codes using makefile commands, you will need to have ***iverilog*** installed. 

## Contents within a Program folder

Each program requires 4 things:

* **ie.v :** This is the main instruction executor, that is, the CPU. It remains the same.

* **inst_{program_name} :** This is the instruction sequence for the program. It follows the specifications given in the instruction set, which is to be written directly in machine code. You can modify it to write your own programs ;)

* **cpu_{program_name} :** It integrates the processor with the instructions in **inst_{program_name}** with **ie.v** (processor) which executes those instructions. The code skeleton remains the same, you only have to include the required **inst_{program_name}** to run. Alernatively, you can load this code onto an FPGA board and run it.

* **tb_{program_name} :** This is the testbench code which can be run to see the output of **cpu_{program_name}**.