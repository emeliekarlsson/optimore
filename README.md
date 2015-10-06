# optimore
Optimore. A CDIO project in applied mathematics at Linköping university 2015.

When in dubt abot ssh, always refer to the ssh generating ssh keys tutorial.
https://help.github.com/articles/generating-ssh-keys/


General procedure using git:

Setup:

1. Get git client: Git termian client, Github GUI, Sourcetree, etc..
 
2. setup ssh keys with github: https://help.github.com/articles/generating-ssh-keys/

3. git clone https://github.com/victorbergelin/optimore.git

4. Git config:
git config --global user.name “victor bergelin“
git config --global user.email “victor.bergelin@gmail.com"


Usage: 
1. Open your local client. Github gui or general terminal git interface.

2. Only working on local content currently? git checkout *your branch* and keep working. 

3. git pull
	or: git pull origin *your branch*

4. git branch *your branch* # create new branch 

4. git checkout *your branch* # grab your new or old branch and keep working on it

5. get working, work on files as before.

..

6. git add *filepath* # stage files for commit
	git add --all # stage all files
	git add logs/* # stage multiple files
	git commit -a # fastest commit method

7. git commit -m "*Commit message*" # update branch with lates files
8. git push # push updates to server
	git push origin *your branch*
	git push origin master

8. git checkout master # now grab the master code to merge into
	git merge *your branch* # merge your branch 
	git commit -m "Branch merge" # make updates
	git push # send updates


More about git branching and merging:
https://git-scm.com/book/en/v2/Git-Branching-Basic-Branching-and-Merging


Git usage:

Git force overwright on local:
git fetch --all
git reset --hard origin/master

Git undo commit:
$ git commit ...              (1)
$ git reset --soft HEAD~1     (2)
<< edit files as necessary >> (3)
$ git add ....                (4)
$ git commit -c ORIG_HEAD     (5)

