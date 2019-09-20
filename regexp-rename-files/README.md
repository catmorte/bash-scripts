# Regexp find and rename files in $(pwd) folder

Bash which renames all files matched to the regexp pattern
Tested on linux mint.

Arguments:
 - 
1) Regexp pattern
2) Result name pattern
    

Be sure that the are in the right folder.

Example:
    
    $pwd
    /home/awesomeuser/test
    
    $ls
    1
    2-qwerty-3
    asd-qwerty-dsa
    
    $regexrfm '(.*)-qwerty-(.*)'    '\1-\2'
    
    $ls
    1
    2-3
    asd-dsa
