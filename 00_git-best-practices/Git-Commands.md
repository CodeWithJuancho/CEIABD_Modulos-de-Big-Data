# Git

### Git learning web page, [see](https://learngitbranching.js.org/?locale=es_AR)

### Help

Git command for having the documentation of every command that is searched for

    git <command> --help

### Global user config settings

Git command for checking all variables set in config file, along with their values

    git config -l

Git command for change the variable value that we want

    git config --global variable.variable "VARIABLE_VALUE"

### Log command

Git command for project commits abstraction since a specific date

    git log --since="your_date" --pretty=format:'%ci|%cn|%ce|%h|%s' > your_file.csv

### Reset author command, [see](https://stackoverflow.com/questions/3042437/how-to-change-the-commit-author-for-one-specific-commit)

    git commit --amend --author="Author Name <email@address.com>" --no-edit

### Reset current HEAD to previous commit

    git reset --hard [<commit-id>], resets to the last commit (if not specified) and removes all of the changes

    git reset --medium [<commit-id>], resets to the last commit (if not specified) and keeps all of the changes

    git reset HEAD~XX, reset to the XX numbers of commits and keeps all of the changes

### Checkout

    git checkout <file-name>, checks the last state of the file on master and removes the changes

### Rebase

    git pull --rebase, rebases your current changes with the ones pulled

### Cherry-pick

Git command for applying the changes introduced by some existing commits

    git cherry-pick [--edit] [-m parent-number]

### Rename, [see](https://linuxize.com/post/how-to-rename-local-and-remote-git-branch/)


### Reset last pushed commit

Go to previous commit
    
    git reset --hard HEAD~1

Force push
    
    git push -f 

### Pull from origin when your HEAD has diverged 
    
    git pull --no-rebase origin {branch_name}

### Stash specific file from staged changes
    
    git stash push -m {stash_name} path/to/file

### Return stashed changes
    
    git stash pop