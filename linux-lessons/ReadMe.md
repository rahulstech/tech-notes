### Learning Linux

Bash Script
    - comments
    - data types
    - array and dictionary
    - variable
    - stdin and stdout
    - operators: arithmatic, conditional
    - conditions: if, if elseif, case 
    - loops: for, while
    - functions
    - filesystem 

**Syntax**
- `$(command)` vs `${variable}`: 
    `$(command)` executes the command and replace it with its output. it creates a new process to execute the command

    `${variable}` replace the modified value of the variable. for example if _variable_ stores a string then `${variable^^}` will make the string uppercase. since it does not executes a command so it does not create a new process. 
    
    **Note** `${variable}` can not perform any artimatic

