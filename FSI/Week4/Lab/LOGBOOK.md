# [Environment Variable and Set-UID Lab](https://seedsecuritylabs.org/Labs_20.04/Software/Environment_Variable_and_SetUID/)


`make sure Labsetup.zip is downloaded an unpacked`

## Lab Task 1 - Manipulating Environment Variables

- Terminal Commands Yield Values:
    - *printenv* / *env*  -> prints all the environment variables.
    - *printenv [variable name]* / *env | grep [variable name]* -> prints only that specific variable.
    - *export [new variable name]* ->  adds a new environment variable.
    - *unset [new variable name]* -> unsets a specific variable.


## Lab Task 2 - Passing Environment Variables from Partent to Child Process

- Compile the program [*myprintenv.c*](/Labsetup/myprintenv.c):

```c
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>

extern char **environ;

void printenv()
{
  int i = 0;
  while (environ[i] != NULL) {
     printf("%s\n", environ[i]);
     i++;
  }
}

void main()
{
  pid_t childPid;
  switch(childPid = fork()) {
    case 0:  /* child process */
      printenv();          
      exit(0);
    default:  /* parent process */
      // printenv();       
      exit(0);
  }
}
```

> $ gcc myprintenv.c

- Run the binary a.out and save output to file:

> a.out > file

- Followed by:

> $ cat file

- We get the following:

### Unix Environment Variables :

```console
SHELL=/bin/bash
SESSION_MANAGER=local/VM:@/tmp/.ICE-unix/2408,unix/VM:/tmp/.ICE-unix/2408
QT_ACCESSIBILITY=1
COLORTERM=truecolor
XDG_CONFIG_DIRS=/etc/xdg/xdg-ubuntu:/etc/xdg
XDG_MENU_PREFIX=gnome-
GNOME_DESKTOP_SESSION_ID=this-is-deprecated
GNOME_SHELL_SESSION_MODE=ubuntu
SSH_AUTH_SOCK=/run/user/1000/keyring/ssh
XMODIFIERS=@im=ibus
DESKTOP_SESSION=ubuntu
SSH_AGENT_PID=2359
GTK_MODULES=gail:atk-bridge
PWD=/home/seed/Desktop/UNI_2023-24/FSI/Week4/Lab/Labsetup
LOGNAME=seed
XDG_SESSION_DESKTOP=ubuntu
XDG_SESSION_TYPE=x11
GPG_AGENT_INFO=/run/user/1000/gnupg/S.gpg-agent:0:1
XAUTHORITY=/run/user/1000/gdm/Xauthority
GJS_DEBUG_TOPICS=JS ERROR;JS LOG
WINDOWPATH=2
HOME=/home/seed
USERNAME=seed
IM_CONFIG_PHASE=1
LANG=en_US.UTF-8
LS_COLORS=rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:
XDG_CURRENT_DESKTOP=ubuntu:GNOME
VTE_VERSION=6003
GNOME_TERMINAL_SCREEN=/org/gnome/Terminal/screen/46140946_c476_4e0c_b0d3_249a21d22ab7
INVOCATION_ID=5422486305194285a76248319357f9e1
MANAGERPID=2119
GJS_DEBUG_OUTPUT=stderr
LESSCLOSE=/usr/bin/lesspipe %s %s
XDG_SESSION_CLASS=user
TERM=xterm-256color
LESSOPEN=| /usr/bin/lesspipe %s
USER=seed
GNOME_TERMINAL_SERVICE=:1.105
DISPLAY=:0
SHLVL=1
QT_IM_MODULE=ibus
XDG_RUNTIME_DIR=/run/user/1000
JOURNAL_STREAM=8:39546
XDG_DATA_DIRS=/usr/share/ubuntu:/usr/local/share/:/usr/share/:/var/lib/snapd/desktop
PATH=/home/seed/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:.
GDMSESSION=ubuntu
DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
OLDPWD=/home/seed/Desktop/UNI_2023-24/FSI/Week4/Lab
_=./a.out

```

- This gives us the Environment Variables, now commenting out *printenv()* statement in the child process case and uncomment *printenv()* in the parent process case.

```c
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>

extern char **environ;

void printenv()
{
  int i = 0;
  while (environ[i] != NULL) {
     printf("%s\n", environ[i]);
     i++;
  }
}

void main()
{
  pid_t childPid;
  switch(childPid = fork()) {
    case 0:  /* child process */
      // printenv();          
      exit(0);
    default:  /* parent process */
      printenv();       
      exit(0);
  }
}
```

- Compiling it again and saving to another file we get the [same output as before](#unix-environment-variables).


- Comparing the difference between the 2 files with **diff** command we get no message/ output in the linux terminal, therefore the 2 files are identical, meaning it didn't matter where the function *printenv()* was, either in the child or parent process.


# Lab Task 3 - Environment Variables and execve()

- Compiling the file [*myenv().c*](/Labsetup/myenv.c) like it was previously done

```c
#include <unistd.h>

extern char **environ;

int main()
{
  char *argv[2];

  argv[0] = "/usr/bin/env";
  argv[1] = NULL;

  execve("/usr/bin/env", argv, NULL);  

  return 0 ;
}
```

- When running the output without any parameters (execve("/usr/bin/env", argv, NULL)), the file we get is an empty text file.

- Therefore to see if there's any difference, we will change the *NULL* into the _char **environ_ (variable that points to an array  of pointers to strings called the "environment")

> execve("/usr/bin/env", argv, environ);

- Now the output of the file compiled by *myenv.c* is the [text defining the present environment variables](#unix-environment-variables).

- So, the conclusion we get to is that the program gets its environment variables through the third parameter of execve(), which is an array of pointers to strings, that are the environment variables.


## Lab Task 4 - Environment Variables and system()

> system() 
- Function that is used to execute a command, but unlike execve(), system() doesn't execute the command directly, instead it executes "/bin/sh -c command", i.e., executes /bin/sh;
- Therefore using system(), the environment variables of the calling proccess is passed to the new program /bin/sh.

- To verify:

```c
#include <stdio.h> 
#include <stdlib.h> 

int main() 
{ 
    system("/usr/bin/env"); 
    return 0 ; 
}
```

- When compiling the code, the output will be [all the environment variables](#unix-environment-variables), as expected.


## Lab Task 5: Environment Variable and Set-UID Programs

- When a Set-UID program runs, it assumes the owner's privileges

```c
#include <stdio.h>
#include <stdlib.h>

extern char **environ;
int main()
{
    int i = 0;
    while(environ[i] != NULL){
        printf("%s\n", environ[i]);
        i++;
    }
}

```

- Compiling the program, the output is the environment variables, but now the goal is to change the programs ownership to root:

```console
// The program's name is t5
$ sudo chown root t5
$ sudo chmod 4755 t5
```

>- *chown* -> changes file owner/root
>- *chmod* -> changes the permissions of files or directories

% ================================================================ %

**Octal *chmod* Permissions**

- Digits:
    - 1st : user permissions
    - 2nd : group permissions
    - 3rd : other permissions

- System:
    - Each digit it a combination/sum of 4 numbers:
        - **4** stands for *"read"* permissions,
        - **2** stands for *"write"* permissions,
        - **1** stands for *"execute"* permissions,
        - **0** stands for *"no permission"*.

    - So, e.g., we have the command:
        - > chmod 754 myfile
    - It means:
        - The user has read, write and execute permissions _(4+2+1)_
        - The group has read and execute permissions _(4+1)_
        - The others only have read permissions _4_

    - A fourth digit can be added to the beggining of the octal,
        - > chmod 4755 myfile
    - This means the first digit is _Special_ permissions, or more commonly know as
    `SETUID` bit, meaning that when its set by chmod, the file can be executed
    by any user as if the user is the owner of the File.

% ================================================================ %

- With the explanation provided above, its easy to determine what the following command will do/set:
    - >chmod 4755 t5
    - SETUID bit(4) -> any user can execute as if their were the owner.
    - User Permissions(7) -> reading, writing and executing.
    - Group Permissions(5) -> reading and executing.
    - Others Permissions(5) -> reading and executing.


- Now in the shell, as a normal user account and not the root one, we will use the export command to set following environment variables:
    - PATH = "/usr/bin"
    - LD_LIBRARY_PATH = "/lib"
    - ANY_NAME (defined by the user) = anything

- We can observe that by doing `env | grep "PATH\|LD_LIB\|TEST"` we get:

```console
WINDOWPATH=2
LD_LIBRARY_PATH=/lib
PATH=/usr/bin
TEST=Nothing_but_a_test
```

- Showing that in fact, the environment variables are set.
- Now running the program with the same appendix:
    - > ./a.out | grep "PATH\|LD_LIB\|TEST"

    - We get:

        ```console
        WINDOWPATH=2
        PATH=/usr/bin
        TEST=Nothing_but_a_test
        ```
    - This means that both the `PATH` and `TEST` variables stayed the same, but the `LD_LIBRARY PATH` variable is not inherited when running the program.


## Lab Task 6 - 