#!/bin/sh
# Usage:
# 1. Set environment variable SOME_VAR=your purdue password with 
#			export VAR="PASSWORD" to create a temorary file with your password in it on your local machine.
#			It will be deleted when you close the terminal if you use export.

# 2. Replace SOME_VAR in this script with the var name you chose
# 3. Replace BRANCH_NAME with the branch you are working on
# 4. Replace PATH_NAME with the path to the repo that you are working on located in the dev server
# Alternatively you can setup environment variables and use them instead


# This MUST BE DONE ONCE FOR EACH REPO YOU PLAN TO EDIT

# 5. ssh into the dev server and run the command "git config credential.helper store".
#			This will store your git acount information in a plain text file under
#			/homes/PURDUE_ACCOUNT/.git-credentials . Only you and admins can read this file. 
# 6. Perform one git command that will require you to login. This will be the last time you
#			will have to enter your credentials to access this repo.


#	7. Put this in the same folder as your local repo
# 8. Run this script

if [ "$#" < 1 ]
	git commit -a 
else
	git commit -am "$1"
fi

git push origin BRANCH_NAME

sshpass -p $SOME_VAR ssh salter@xinu05.cs.purdue.edu "cd PATH_NAME ; git checkout BRANCH_NAME"
sshpass -p $SOME_VAR ssh salter@xinu09.cs.purdue.edu "cd PATH_NAME ; git pull origin BRANCH_NAME"
