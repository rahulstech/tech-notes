# Git Intermediate Commands

### **`git diff`**

Show a list of staged and unstaged files and contents.

---

### **`git checkout <commit hash>`**

Creates a **detached HEAD** (headless state) at `<commit hash>`.

* This does not modify the original branch.
* To save this state as a new branch:

  ```bash
  git switch -c <branch-name>
  ```
* To return to the previous branch:

  ```bash
  git switch -
  ```

**Note:** If you don’t save this state, it will be lost.

---

### **`git checkout <commit hash> <file-path>`**

Restore `<file-path>` from a previous commit into the current branch.
Useful to bring back deleted/modified files from an older commit.

---

### **`git reset --soft|--mixed|--hard <commit hash>`**

Moves the branch pointer back to `<commit hash>` and **removes all later commits** from history.
Behavior depends on the mode:

* `--soft`: keeps all later changes **staged**.
* `--mixed`: keeps all later changes **unstaged** (default).
* `--hard`: deletes all later changes from both **staging and working directory**. ⚠ Dangerous!

Example:

```
c0 → c1 → c2 → c3 (HEAD)

git reset --soft c1
```

History after new commit:

```
c0 → c1 → c4 (HEAD)
```

---

### **`git rebase <branch>`**

Changes the base of the current branch to the tip of `<branch>`.

Example:

```
master:  c0 → c1 → c2 (HEAD)
                 \
feature:          c3 → c4 (HEAD)
```

After `git switch feature && git rebase master`:

```
master:  c0 → c1 → c2
feature:                  c3 → c4 (HEAD)
```

* Can cause **conflicts** if both branches modified the same file.
* Resolve conflicts → stage → continue rebase:

  ```bash
  git rebase --continue
  ```
* Abort:

  ```bash
  git rebase --abort
  ```

---

### **`git revert <commit hash>`**

Creates a **new commit** that undoes the changes from `<commit hash>`.

Example:

```
Before:  c0 → c1 → c2 → c3 (HEAD)
git revert c1
After:   c0 → c1 → c2 → c3 → c4 (HEAD)
```

* Unlike `reset`, history is preserved.
* May cause conflicts (resolve, stage, and continue).

  ```bash
  git revert --continue
  ```
* Abort:

  ```bash
  git revert --abort
  ```

---

### **`git cherry-pick <commit hash>`**

Apply the exact changes of `<commit hash>` into the current branch.

* `<commit hash>` may belong to **any branch**.
* ⚠ May cause conflicts if overlapping changes exist.

---

### **`git reflog`**

Shows a log of all branch movements (including orphaned commits).

* Use a hash from reflog with `git checkout` or `git reset`.
* If the commit is unreachable from HEAD, `reset` will fail.

---

### **`git show <commit hash>`**

Displays details of a commit:

* Metadata (author, email, date, hash).
* Commit message.
* Diff (like `git diff` output).

---

### **`git restore [--staged] <file>`**

Restore files to the last committed/staged state.

* Without `--staged`: restore working directory file.
* With `--staged`: unstage the file.
* ⚠ Cannot restore files deleted in old commits (use `checkout <commit> <file>` instead).

---

### **`git merge --squash <branch>`**

Merge changes from `<branch>` into current branch as a **single commit**.

* No commit history from `<branch>` is preserved.

---

### **`git merge --ff <branch>`**

Fast-forward merge. Moves the branch pointer forward without creating a merge commit.

```
master:  c0 — c1 — c2 (HEAD)
feature:              \ f0 — f1 (HEAD)

After:
master:  c0 — c1 — c2 — f0 — f1 (HEAD)
```

* History remains **linear**.
* No merge commit created.

---

### **`git merge --no-ff <branch>`**

Always creates a **merge commit**, even if fast-forward is possible.

```
master:  c0 — c1 — c2 (HEAD)
feature:              \ f0 — f1 (HEAD)

After:
master:  c0 — c1 — c2 ———— M (HEAD)
                      \   /
                      f0 — f1
```

* Merge commit `M` has **two parents**.
* Preserves explicit branch history.

---
