## Git Rebase

### **`git rebase -i <base commit>`**

Interactive rebase to modify commits after `<base commit>`.
You can:

* **reorder** → rearrange commits.
* **reword** → change commit message.
* **squash** → combine commits.
* **fixup** → combine without commit message.
* **edit** → pause to modify commit.
* **drop** → remove a commit.

Steps:

```bash
git rebase -i <base-commit> -- commits after <base-commit> will take part in rebase
```

Opens `git-rebase-todo`:

```
pick <hash> commit message
pick <hash> commit message
```

* Change `pick` to desired command.
* Reorder lines to change order.

When rebase is complete, save the rebase with

```bash
git rebase --continue
```

or discard the whole rebase with 

```bash
git rebase --abort
```

## Split a commit with `rebase`

in the **git-rebase-todo** change `pick` to `e` or `edit` to the desired commit. Note the commit has and message.

when rebase stops at that commit for modification, then

```bash
git reset HEAD^
```

why? HEAD is now at the desired commit which i want to split. it will make all the changes unstagged so that i can partially `add` and do multiple `commit`. now i will do `add` and `commit` as required. 

finally to make the changes final

``bash
git rebase --continue
```