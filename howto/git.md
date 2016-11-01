# Git Workflow

To allow collaboration on a shared git repository it is good practise to not work on the master branch of the upstream repository, but use a `branch` to do the actual work and submit a so call PullRequest to get it in the master branch of the upstream repository.

This can be done on the upstream repository itself (in our case `markusklems/cp2017`) or on a individual fork (which is done by using the `fork` button at the top of the aforementioned repository).

Once this is done one will be forwarded to the individual branch.

![](pics/git_fork.png)

### Clone
```
➜  git $ git clone git@github.com:ChristianKniep/cp2017.git ~/src/github.com/ChristianKniep/cp2017
Cloning into '/Users/kniepbert/src/github.com/ChristianKniep/cp2017'...
remote: Counting objects: 7, done.
remote: Compressing objects: 100% (7/7), done.
remote: Total 7 (delta 0), reused 7 (delta 0), pack-reused 0
Receiving objects: 100% (7/7), done.
Checking connectivity... done.
➜  git $ cd cp2017
```
### Add remote repository

After cloning the repository one should create a `remote` repository be able to fetch upstream changes.

```
➜  cp2017 git:(master) $ git remote add upstream git@github.com:markusklems/cp2017.git
```

### Work on a feature branch

To not work on the master branch (which will be easier when creating a PullRequest), we create a (somewhat meaningfully named) `feature branch`.

```
➜  cp2017 git:(master) $ git checkout -b create_git_clone_howto 
Switched to a new branch 'create_git_clone_howto'
```
Now everything is set to actually do some work.

```
➜  cp2017 git:(create_git_clone_howto) $ <do some work>
```

### Push featurebranch 

### 