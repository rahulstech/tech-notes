## Git Special Commands

### **`git cat-file -t|-s|-p <hash>`**

Inspect Git objects directly. `<hash>` may be a commit, tree, blob, or tag.

* `-t`: show type (`commit`, `tree`, `blob`, `tag`).
* `-s`: show size of object.
* `-p`: pretty-print object contents.

  * Blob → file content.
  * Commit → metadata + diff.
  * Tree → directory listing.

---