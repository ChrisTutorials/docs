---
description: Repository sync (status → commit → push)
---

## git-sync Workflow

Follow these steps whenever you need to capture work across the repo and push it upstream. Replace placeholders (`<message>`, etc.) with real values.

1. **Verify clean tree & remotes**
   - `git status -sb`
   - `git remote -v`

2. **Stage changes**
   - All: `git add -A`
   - Selective: `git add <file1> <file2>`

3. **Review staged diff**
   - `git diff --cached`

4. **Commit**
   - `git commit -m "<concise summary>"`
   - If no changes: skip commit and continue with pull/push check.

5. **Update from origin**
   - `git pull --rebase`

6. **Push to origin**
   - `git push origin HEAD`

7. **Push to backup (if configured)**
   - `git push backup HEAD`

8. **Final verification**
   - `git status -sb`
   - Ensure working tree is clean before moving on.
