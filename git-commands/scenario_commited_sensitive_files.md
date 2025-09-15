### How to untrack commited sensitive file

**Scenario**
  Let's say _credentials.csv_ contains some sensitive data which was commited accidentally. Here the commit log and here it was commit:

  ```
  c3 fourth (HEAD)
  c2 third 
  c1 second <- credentials.csv commited here
  c0 first
  ```

  The task is to untrack this _credentials.csv_ so that these sensitive data can no way retrived.

  **solution 1**
  - Start interactive `rebase` on c0
  - Set todo edit c1 and keep rest as it is
  - _reset mix_ the c1 commit
  - Ignore _credentials.csv_
  - Commit again
  - Continue rebase

  This solution works but the problem is _credentials.csv_ still exists in the git object database. Therefore it can be restored again.

  **solution 2**
  - Start interactive `rebase` on c0
  - Set todo edit c1 and keep rest as it is
  - Unstage _credentials.csv_ from the commit using:
    ```bash
    git reset "HEAD^" -- credentials.csv
    
    # or

    git rm --cached credentials.csv 
    ```
  - Ignore _credentials.csv_
  - Amend the commit
  - Continue rebase

  This solution works but the problem is _credentials.csv_ still exists in the git object database. Therefore it can be restored again.

  Since the blob still exists in the object database it can be retrived using `cat-file` command. Even if the commit is not reachable from head, it still exists in `reflog`. So, the solutions are good if the repo is completely local. otherwise those sensitive informations can be restored anyway.

  
