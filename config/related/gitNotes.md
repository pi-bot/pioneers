I'm pretty inexperienced in git so here are some notes on how I'm doing things.

Perhaps unusually I doing git pulls to a local raspberry pi and editing corrections to code from a web browser on another machine. On the Raspberry Pi I then pull the changes to re-test untill its all working.  This requires:
```
cd ~/pioneers
git pull
git reset --hard
git merge
sudo chmod +x config/*
```
That effectively resyncs all the local files from the repo and allows me to execute all the config scripts.
