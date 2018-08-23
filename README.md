# auto-virtualenv

Small script allowing the auto-activation of a python virtual environment upon cd into a directory.

## Installation: ##
After cloning the project, add the following line to your .bash_profile:

`source [auto-virtualenv clone directory]\commands.sh`

Upon cd-ing in a directory the script will check for the existence of a **.virtenv** file in the target directory. If it cannot detect one it will recursivngly go up the directory tree to try to find one. 
Once a **.virtenv** file has been found the script will retrieve the string in the first line of .virtenv and use it to automatically activate the named environment. If the string is **"##MANUAL##"** it'll stop the recursion and won't activate any new virtual environment (or if an environment has already been activated, it'll deactivate it).

## Example: ##

> A

> ├── .virtenv

> └── B

>    └── C

with **A\.virtenv** as follow:
`vanilla`

If you cd into **A**, **B**, or **C** auto-virtualenv will activate the **vanilla** virtual environment.


> A

> ├── .virtenv

> └── B


>    ├── .virtenv

>    └── C

with **A\.virtenv** as follow:
`vanilla`
and **B\.virtenv** as follow:
`##MANUAL##`

If you cd into **A** auto-virtualenv will activate the **vanilla** virtual environment but if you cd into  **B** or **C** auto-virtualenv will deactivate any virtual environment.

## Note : ##
To disable auto-virtualenv system-wide, just run the following command:

`export DISABLE_AUTO_VIRTUALENV=true`

If you want to disable auto-virtualenv outputs, just run the following command:

`export VERBOSE_AUTO_VIRTUALENV=false`