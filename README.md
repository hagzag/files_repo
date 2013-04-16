![picture alt](http://www.tikalk.com/files/upload/1/tikal_com_logo45n45.png "Tikal Community") Using Git for Backup ... [ yes you heard right !]
======================

This repo was populated with a Git based Backup procedure - see: https://gist.github.com/hagzag/5396510

This is shared here for educational purposes.
I created this script as a backup procedure to an assets directory I had on one of my websites, 

Basically this shell script rsyncs a data directory [defaults to /opt/data] into a git repository / or sets one up for you [ defaults to /opt/git-repo]. 

The motivation behind this was to be able to initialize a git repo, add, commit & push to a git repository so I have history of the commits. 

For this Gist I changed the GIT_REMOTE parameter to my github account / files_repo.git. 

If you plan on using this you will need to 

- create a repository [ e.g on GitHub ] 
- set the FILES_DIR parameter [ or default to /opt/data ] 
- set the MY_GIT_REPO parameter [ or default to /opt/git-repo ] 
- set my GIT_REMOTE parameter with the full git url of you repository [I didn't check this via https ... ] 

So i'm not sure how useful this would be for you but here is another great thing you can do with Git. 

BTW why rsync data to a git aware dir ? - just wanted to keep my files dir clean from the .git and it wasn't a matter of disk space, you could use the FILE_DIR and init git there if you want to. 

**Enjoy HP**


