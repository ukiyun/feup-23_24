# Week 4: SEED Labs – Environment Variable and Set-UID Program Lab 

## Lab Tasks

### Task 1: Manipulating Environment Variables
> In this tasks we learned the funcionalities of some commands, to set and unset environment variables and to print them.
> - export [new variable name] - adds a new environment variable
> - unset [variable name] - unsets a specific variable
> - printenv - prints all environment variables
> - printenv [variable name] - print a specific environment variable 


### Task 2: Passing Environment Variables from Parent Process to Child Process

> In task 2 we experienced that a child process gets its environment variables from its parents.  
>
> We compiled and executed myprintenv.c twice. One to save the environment variables of the child process (Step 1) and the other to save the environment variables of the parent process (Step 2).  
>
> In Step 3 using the <strong>diff</strong> command we have seen that the environment variables of the two processes were the same, therefore we concluded that the child process inherits the parent environment variables.


### Task 3: Environment Variables and execve()

> In this task we had to study how the execution of a new progrmam via *execve()* affects the environment variables. 
>
> In Step 1, when executing the given program, with the 3rd argument being NULL, there were no environment variables, we think that is because when we call execve all of the calling process’s text, data, bss, and stack are overwritten, and because no environment variables were passed in there, nothing was printed.  
> In Step 2,  changing the last parameter of *execve()* to environ, the environment variables were printed.  
>
> We can conclude that the new program get its environment variables through the third parameter of *execve()*, which is an array of pointers to strings, that are the environment variables.

### Task 4: Environment Variables and system()

> In task 4, we study how environment variables are affected when a new program is executed via the *system()* function, that is used to execute a command, unlike *execve()*, *system()* executes */bin/sh* and asks the shell to execute the command.
>
> We executed the given program and observed that when the *system()* function is called, it calls the shell instead of executing the command directly. The shell then internily calls the *execve()* command and the environmet variables of the calling process are passed to the to the shell who then passes it to the *execve()* command.

### Task 5: Environment Variable and Set-UID Programs

> In this task we needed to understand how Set-UID programs and its environment variables are affected.  
>
> After running the program, that we wrote in step 1, a first time we changed the ownership of the program to root and made it a Set-UID program.  
>
>``` 
>$ sudo chown root foo
>$ sudo chmod 4755 foo 
>```
>
> In step 3 using the export command we changed the PATH and LD_LIBRARY_PATH variables and created a new variable.  
>
> After running the program the second time we observed that surprisingly LD_LIBRARY_PATH did not get into the Set-UID child process unlike the other two variables.

### Task 6: The PATH Environment Variable and Set-UID Programs

> In this we wanted to prove that we can make the given Set_UID program to run our own malicious code instead of '/bin/ls' exploring the vulnerability left in *ls* command being defined as only *ls* and not its absolute path.  
>
> The given program calls *system("ls")* function to execute '/bin/ls', so we created a c program with our malicious code and called 'ls' to the executable. The goal is to when the given program execute system("ls"), instead of /bin/ls, it is our code that is executed. 
>
> In order to achieve this we have to change the ownership of our program to root and make it a Set-UID program. And then we need add the current directory of our code to the beggining of the PATH environment variable.
>```
>export PATH=/home/seed:$PATH
>```  
> If we execute the given program know it will run our malicious code.
> This is because when the system looks to PATH environment variable it looks first in the directory of our malicious code and finds our 'ls' command first then the '/bin/ls' command.
>
> In order to verify whether our program runs with root privileges we changed out custom ls program to call system("apt upgrade"), which requires root permission. The result was that it asked for root permission, so we can conclude that it does not run with root privileges.
>And that is due to the system function calling the /bin/sh program, which is symbolicly linked to /bin/dash and this shell doesn’t allow Set-UID programs to run with root privileges, instead changing their ownership to the real user ID, dropping their privileges.
>
>However when we run it on the SEED Ubuntu 20.04 VM, that has a link between /bin/zsh and /bin/sh, we observe that the program already runs with root privileges.
>```
>$ sudo ln -sf /bin/zsh /bin/sh
>```

