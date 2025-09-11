### Git Intermediate Commands

#### git diff
  show a list of staged and unstaged files and contents.

#### git checkout <commit hash>
  creates a headless branch with `<commit hash>` as the head. since it's a new branch it does not modify the original branch. to save this branch use the following command
  ```bash
  git switch -c <branch-name>
  ```
  to abort this headless branch use the following command
  ```bash
  git switch -
  ```
  **Note:** untill this headless branch is saved it will loss
  
#### git checkout <commit hash> <filepath>
  apply the changes in the `<filepath>` in the commit `<commit hash>` into the current branch. it's a way to restore any file or files which was deleted in some previous commit
  
#### git reset --soft|--mixed|--hard <commit hash>
  reset removes all the the commits after `<commit hash>` from commit history in the current branch. staging and current working directory changes depends on the reset mode:
  - `--soft` mode keeps all changes in following commits in staging and does not change the working directory. this mode is used when merge some intermediate commits into a final commit.
  - `--mixed` mode keeps all changes in following commits unstagged and does ont change the working directory.
  - `--hard` mode remove all changes in following commits stagging as well as form working directory. this mode is very dangerous as all the changes in the following commits are lot permanently.
  ```
  example: c0 > c1 > c2 > c3 (HEAD)
  git reset --soft|--mixed c1
  changes c2 and c3 are still available but need a new commit. but c2 and c3 are completely removed from the commit history. after the commit it history will look like
  c0 > c1 > c4 (HEAD)
  ```
  
#### git rebase <branch name>
  it changes the base commit of a branch. consider the following example
  ```txt
  master: c0 > c1 > c2 (HEAD)
               \
  feature:     c3 > c4 (HEAD) <- the base of the branch is c1
  
  i want that
  feature: c0> c1 > c2 > c3 > c4 (HEAD) <- the base of the branch is now c2
  ```
  to apply rebase make sure we are in the the branch to rebase (in the example the `feature` branch). otherwise switch to that branch. the `<branch name>` in the rebase command should the src branch name. for example:
  ```bash
  git switch feature
  git rebase master
  ```
  **Note:** `rebase` can lead to conflict. for example: in the above example let i modified the same file in both c2 and c3. in this case there will be conflict as `rebase` can not decide which change to keep and which to discard. this conflict need to solve manually. when all conflicts are resolved then stage changes and continue `rebase` with
  ```bash
  git rebase --continue
  ```
  otherwise to abort the rebase do
  ```bash
  git rebase --abort
  ```

#### git revert <commit hash>
  creates a new commit applying a changes in the commit `<commit hash>` and discarding all the following changes of commit `<commit hash>`. so unlike `reset`, `revet` does not remove the commits from history but apply an older commit with a new commit and makes it HEAD. for example:
  ```txt
  c0 > c1 > c2 > c3 (HEAD)
  
  now executed
  git revert c1
  
  c0 > c1 > c2 > c3 > c4 (HEAD)
  
  so c4 contains all changes in c1 but changes in c2 and c3 are removed.
  ```
  **Note:** `revert` can also rise conflict. let say _file1_ was modified both in c2 and c3. then there will be a conflict. then the conflict need to be resolved and stage the modified file. then continue the revert with
  ```bash
  git revert --continue
  ```
  or abort revert with
  ``bash
  git revert --abort
  ```

#### git cherry-pick <commit hash>
  apply exactly `<commit hash>` commit into current branch. the `<commit hash>` can be from any branch. it does not raise conflict. 
  **Note:** before executing this command make sure you are in the right branch i.e. in the branch where you want to apply the cherry picked commit.
  
#### git reflog
  show a list of all orphaned heads from all branches. use commit hash from `reflog` to `checkout` or `reset` to that commit.
  **Note:** if `reset` commit is not reachable from the current commit of the current branch then the command fails.
  
#### 
