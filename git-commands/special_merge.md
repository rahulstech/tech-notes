## 🧩 Advanced Git Merge Conflict Resolution Using `.gitattributes`

### 🧠 Overview

When merging branches in Git, conflicts occur if the same files are modified differently across branches.
But in some projects, we already know **which side’s changes should win for specific paths** — for example:

* For `dirA/**` → always keep **our branch’s** version (master or target branch).
* For `dirB/**` → always take **their branch’s** version (incoming branch).

Git allows this level of control using **custom merge drivers** configured via `.gitattributes`.

### ⚙️ 1. The Concept

Git’s merge drivers define **how to resolve file-level conflicts automatically**.

Each file can have a specific merge strategy defined in `.gitattributes`:

```gitattributes
dirA/** merge=ours
dirB/** merge=theirs
```

And in your `.git/config` (or global config), you tell Git **what each driver actually does**:

```ini
[merge "ours"]
    driver = cp "%A" "%A"
[merge "theirs"]
    driver = cp "%B" "%A"
```

> * `%O`: common ancestor (original)
> * `%A`: current branch file ("ours")
> * `%B`: merged-in branch file ("theirs")

**Note:** instead of changing the `.git/config` file manually i will use the commands

```bash
git config merge.ours.driver '"%A" "%A"'
git config merge.theirs.driver '"%B" "%A"'
```

### 🧩 2. Practical Example

### 📁 Initial Repo Structure

In the `master` branch:

```
dirA/
  file.txt
dirB/
  file2.txt
```

Both files contain empty or base content.

### 🪵 Step 1: Create Branches

```bash
git checkout -b branchA
# modify dirA and dirB
echo "branchA" > dirA/file.txt
echo "branchA" > dirB/file2.txt
git add .
git commit -m "branchA changes"
```

```bash
git checkout master
git checkout -b branchB
# modify dirA and dirB
echo "branchB" > dirA/file.txt
echo "branchB" > dirB/file2.txt
git add .
git commit -m "branchB changes"
```

### 🔀 Step 2: Merge `branchA` into `master`

```bash
git checkout master
git merge branchA
```

✅ No conflicts — because we merged into a clean master.

At this point:

```
dirA/file.txt  -> branchA
dirB/file2.txt -> branchA
```

### ⚙️ Step 3: Configure Automatic Merge Rules

Create a `.gitattributes` file in the repository root:

```gitattributes
dirA/** merge=ours
dirB/** merge=theirs
```

Then, configure custom merge drivers in `.git/config` (or using `git config` commands):

```ini
[merge "ours"]
    driver = cp "%A" "%A"

[merge "theirs"]
    driver = cp "%B" "%A"
```

> 🧩 **Important:**
>
> * The `driver` value must be a **shell command**, not a Git command.
> * Commands like `git checkout` won’t work here — Git invokes the driver in a temporary directory.
> * You must explicitly copy one version over `%A`.

### 🧪 Step 4: Merge `branchB` into `master`

```bash
git merge branchB
```

✅ No manual conflict editing required!

### 🧾 Step 5: Final Result

| File             | Result    | Explanation                                                          |
| ---------------- | --------- | -------------------------------------------------------------------- |
| `dirA/file.txt`  | `branchA` | `.gitattributes` rule `merge=ours` keeps master (ours) version       |
| `dirB/file2.txt` | `branchB` | `.gitattributes` rule `merge=theirs` takes incoming (theirs) version |

**Final content after merge:**

```
dirA/file.txt   -> branchA
dirB/file2.txt  -> branchB
```

### 🧠 3. How It Works Internally

During a merge, for every file, Git:

1. Detects that the file path matches a pattern in `.gitattributes`.
2. Looks up the merge driver name (`ours` / `theirs`).
3. Executes the shell command defined under `[merge "<name>"]`.
4. Passes three file versions:

   * `%O`: base
   * `%A`: ours (current)
   * `%B`: theirs (incoming)
5. Expects the driver to **overwrite `%A` with the desired final version**.
6. Uses the exit code (`0` = success, `>0` = failure) to decide if the merge succeeded.


### ⚠️ Common Mistakes

| Mistake                               | Why It Fails                                                         |
| ------------------------------------- | -------------------------------------------------------------------- |
| Using `git checkout` in driver        | Runs outside Git context — can’t find repo or index                  |
| Forgetting to escape quotes (`"%A"`)  | Fails when paths have spaces                                         |
| Writing `.gitattributes` after commit | Needs to exist **before merging** to affect merge behavior           |
| Expecting global behavior             | Rules apply **only to files matching the `.gitattributes` patterns** |

### 🧭 4. When to Use This Approach

| Use Case                                               | Recommended?                    |
| ------------------------------------------------------ | ------------------------------- |
| Generated files (e.g., build artifacts, version files) | ✅ Yes                           |
| Environment-specific configs                           | ✅ Yes                           |
| Files always owned by one team or branch               | ✅ Yes                           |
| Shared frequently edited source files                  | 🚫 No (manual review preferred) |

## 🧰 5. Useful Custom Merge Drivers

| Driver     | Command                                                                           | Behavior                                  |
| ---------- | --------------------------------------------------------------------------------- | ----------------------------------------- |
| **ours**   | `cp "%A" "%A"`                                                                    | Always keep current branch version        |
| **theirs** | `cp "%B" "%A"`                                                                    | Always take merged branch version         |
| **union**  | `cat "%A" "%B" > "%A"`                                                            | Append both versions (like `merge=union`) |
| **smart**  | `bash -c 'if grep -q KEEP_THEIRS "%O"; then cp "%B" "%A"; else cp "%A" "%A"; fi'` | Conditional merge logic                   |

## 🧩 6. Summary

| Concept                          | Description                                           |
| -------------------------------- | ----------------------------------------------------- |
| `.gitattributes`                 | Maps file patterns to merge drivers                   |
| `.git/config` `[merge "<name>"]` | Defines the command for each driver                   |
| `%A`, `%B`, `%O`                 | Temporary file paths for “ours”, “theirs”, and “base” |
| Command type                     | Must be a shell command (e.g., `cp`, `cat`, etc.)     |
| Use case                         | When you can safely auto-resolve merges by path       |


### ✅ Example Recap

```bash
# .gitattributes
dirA/** merge=ours
dirB/** merge=theirs
```

```ini
# .git/config
[merge "ours"]
	driver = cp "%A" "%A"
[merge "theirs"]
	driver = cp "%B" "%A"
```

### After merging both branches:

```
dirA/file.txt  → branchA
dirB/file2.txt → branchB
```

### 💡 Key Takeaway

> With `.gitattributes` and custom merge drivers, you can make Git automatically resolve conflicts **based on file paths**, ensuring predictable merges and eliminating repetitive manual conflict edits — **as long as you know which side should always win**.

---

# 🧩 Path-Based Merge Conflict Resolution in Git

### 📘 Overview

When merging branches in Git, conflicts typically occur only when **the same file** has been modified in both branches since their common ancestor.

However, in some workflows, different directories are maintained by different branches — for example:

```
master/
  dirA/
    file1
    file2
  dirB/
    file1
    file2
```

* `branchA` → after merge changes in `dirA` are accepted
* `branchB` → after merge changes in `dirB` are accepted
* if i strictly change in `dirA` files only in `branchA` and `dirB` files in `branchB` there will be no merge conflict
* but if I make changes in files from both the directories in both branches then a merge conflict will happen. 

### The Concept of `ours` and `theirs`

During a merge:

* **`--ours`** → keeps the version from the **current branch (HEAD)**, i.e., the branch I am on when I run `git merge`.
* **`--theirs`** → keeps the version from the **incoming branch**, i.e., the branch I am merging **into** the current branch.

### 🚀 The Path-Based Merge Resolution Strategy

### 🎯 Goal

Automatically resolve merge conflicts by choosing:

* For files in **dirA** → keep **ours** (discard branchB changes)
* For files in **dirB** → keep **theirs** (accept branchB changes)

This approach is ideal when I know ahead of time which directories belong to which branch or module.

### 🪜 Step-by-Step Workflow

### Step 1: Merge the target branch

Run the merge command as usual:

```bash
git switch master

# following merge goes fine 
git merge branchA

# this merge will raise merge conflict
git merge branchB
```

If there are no conflicts, Git will merge automatically and I am done.

If there **are** conflicts, proceed to the next step.


### Step 2: Check conflict status

View conflicted files:

```bash
git status
```

I can see output like:

```
both modified: dirA/file1
both modified: dirB/file2
```

### Step 3: Resolve per directory using path-based checkout

#### For dirA — keep changes from master (ours)

```bash
git checkout --ours -- dirA

# Note I added dirA only
git add dirA
```

Here:

* `ours` → refers to `master`
* `theirs` → refers to `branchB`

#### For dirB — keep changes from branchB (theirs)

```bash
git checkout --theirs -- dirB

# Note I added dirB only
git add dirB
```

Here:

* `ours` → refers to `master`
* `theirs` → refers to `branchB`

### Step 4: Commit the merge

Once the conflicts are resolved and staged:

```bash
git commit -m "Resolved merge: kept ours for dirA, theirs for dirB"
```

This completes the merge cleanly without editing conflict markers manually.


### 🧠 Why There May Be No Conflicts

In most cases, **Git will not produce any conflict at all**, because:

* `branchA` and `branchB` modify **disjoint sets of files**.
* Git merges **per file**, not per directory.
* Unless both branches modify or rename the same file, Git can safely merge automatically.

For example:

| File Path  | Modified in branchA | Modified in branchB | Conflict |
| ---------- | ------------------- | ------------------- | -------- |
| dirA/file1 | ✅ Yes               | ❌ No                | ❌ No     |
| dirA/file2 | ✅ Yes               | ❌ No                | ❌ No     |
| dirB/file1 | ❌ No                | ✅ Yes               | ❌ No     |
| dirB/file2 | ❌ No                | ✅ Yes               | ❌ No     |

Hence, Git sees no overlapping edits and merges everything automatically.

### 💡 When Conflicts Actually Occur

I will only see conflicts if:

* Both branches modify **the same file**.
* One branch **deletes or renames** a file/directory modified by the other.
* Git cannot auto-merge binary files or rename operations.

In those cases, the path-based method described here (`git checkout --ours/--theirs`) becomes useful.


## ✅ Summary

| Directory | Rule                        | Command                                         |
| --------- | --------------------------- | ----------------------------------------------- |
| `dirA/`   | Keep current branch (ours)  | `git checkout --ours -- dirA && git add dirA`   |
| `dirB/`   | Keep merged branch (theirs) | `git checkout --theirs -- dirB && git add dirB` |

Then finish with:

```bash
git commit -m "Resolved dirA with ours and dirB with theirs"
```

### 🧾 Notes

* This approach does **not** require modifying `.gitattributes` or Git config.
* It’s **safe** and **repeatable** for merges where directory ownership is clearly defined.
* Use it as a **manual but semi-automated** solution to selective merge strategies.

