I'm pretty inexperienced in git so here are some notes on how I'm doing things.

When you clone for the first time, you will get a branch called master and a remote called origin (where you cloned from) with the local master set to track the master on origin. Once this is set up, you can simply say git push and it'll do it. 


## Pulling whilst correcting from github.com

Perhaps unusually I doing git pulls to a local raspberry pi and editing corrections to code from a web browser on another machine. On the Raspberry Pi I then pull the changes to re-test untill its all working.  This requires:
```
cd ~/pioneers
git pull
git reset --hard
git merge
sudo chmod +x config/*
```

The reset --hard looses all the local changes I have been making. As I'm choosing to put changes directly in the origin online this is needed to descard the local changes and avoid conflicts.

That effectively resyncs all the local files from the repo and allows me to execute all the config scripts.

## Pushing changes back

The other common situation I'm finding is that I'm doing live development on the raspberry pi and I need to send new updates back to the repo on github. 
 
Advice for the best way to do this is:

stash your local changes

```
git stash
```

update the branch to the latest code:
```
git pull
```
Merge your local changes into the latest code:
```
git stash apply
```
Add, commit and push your changes:
```
git add
git commit
git push 
```
