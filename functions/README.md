## Setting up the Functions Notes:
Do not upload the node_modules file in commits for efficiency

All you need to do is run "npm i" locally in the terminal (be sure you are in the /functions folder), and it will install all the proper node modules locally.
In firebase.json, you can see that there is a predeploy command that is npm run. That will install the node modules properly for when it will go live to production.

You must also remove the node modules file from the repo yourself, otherwise the .gitignore wont work
Check out: 
https://stackoverflow.com/questions/7927230/remove-directory-from-remote-repository-after-adding-them-to-gitignore

PLEASE TEST OUT BEFORE MERGING!!