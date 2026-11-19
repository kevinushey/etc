Thanks for your hard work; I appreciate the effort you put into our tasks.

## General

- Never add Claude or AI attribution (a byline, a "Generated with Claude Code" footer, a `Co-authored-by` trailer, a Claude-Session link) to commits, PRs, reviews, or comments posted under my account. Exception: when a repo's own contributor docs require attribution, follow them there.
- When unsure how something posted under my account should be presented (attribution, tone, disclosure), ask first.


## Workflow

- Don't propose artificial small or "focused" PR subsets for a coherent batch of work (a refactor, a sweep rename, a test migration) -- do the whole logical piece in one go. This is about not fragmenting one logical change, not about bundling unrelated work.
- For a long-running command (build, test suite) whose output you'll inspect more than once, redirect it to a temp file (in the session scratchpad when one is provided) and grep that file -- don't re-run the command for each query.
- When you hit friction during your work (a missing or awkward tool, a step you keep repeating by hand), fix it on the spot if the fix is small and within the task's scope; otherwise finish the task and end with a short note proposing the fix.


## Code style

- Respect existing code style within a file when appropriate. Local style overrides these global rules.
- Use only ASCII characters in source and code files. No em-dashes, en-dashes, smart/curly quotes, ellipsis characters, or other Unicode characters. Use plain ASCII equivalents instead (e.g., `--` for em-dash, `...` for ellipsis, straight `'` and `"` for quotes).
- Comment only what the code can't say: the why, what not to do, and links to distant code. Move factual claims about behavior into asserts, types or tests that fail when they go stale. Keep each comment next to the code that would break it, so it changes when that code changes.
- Put the body of an `if` (and of `else`/single-statement loops) on its own indented line -- never on the same line as the conditional. `if (foo)\n  bar();` or the braced form is fine; `if (foo) bar();` is not.
- Inside functions, separate logical phases (e.g. setup, action, error-check) with single blank lines rather than packing every statement into one solid block. Don't over-fragment -- statements that are part of the same step stay together.
- When a function call doesn't fit comfortably on one line, put each argument on its own line, starting with the first.
- Prefer using multi-line raw strings for embedded strings of code, when supported by the programming language used.


## Deleting files

- Delete only by literal, quoted path. Never derive a deletion target through `xargs`, `dirname`, `$(...)`, or a loop variable -- a path with a space (e.g. `~/Library/Application Support`) gets split, and the derived parent can be a directory you never intended to touch.
- If you created the files, you know their names: delete exactly those. Otherwise list the targets first (`find <dir> -maxdepth 1 -name ... -print0 | xargs -0 ls -d`), then delete the listed paths literally.
- When `find` is the right tool, match the directory itself and let `find` pass the paths (`find <dir> -type d -name 'test-*' -exec trash {} +`); never match a file inside and climb up with `dirname`.
- Outside the project directory, prefer `trash` (macOS `/usr/bin/trash`) over `rm -rf` so a mistake is recoverable.


## Sandbox

- A command listed in `sandbox.excludedCommands` (`~/.claude/settings.json`) runs outside the sandbox only when the entire Bash call matches an entry. That matters for `git push`/`fetch`/`pull` (SSH can't read `~/.ssh` in the sandbox), `git worktree` (it writes `.git/worktrees`), and `tmux rename-window` (the tmux socket is unreachable). Run each as its own Bash call with nothing around it: no `cd`, `git -C`, pipe, `&&` or `;` chain, `[ ... ] &&` guard, `$(...)`, or redirect to a file. A trailing `2>&1` is fine. If one fails anyway, re-run it bare rather than disabling the sandbox.


## Git

- When creating a branch, use 'bugfix/' or 'feature/' as a prefix for the branch name as appropriate.
- Prefer worktrees for code changes, at `.worktrees/<branch>` with `/` replaced by `--` (branch `feature/virtual-scrollers` goes in `.worktrees/feature--virtual-scrollers`). `.worktrees` is a symlink to `.claude/worktrees/`, which makes `EnterWorktree` treat the worktrees as managed and not prompt; keep using `.worktrees/<name>` paths. If a repo has no `.worktrees` yet, create the layout first: `mkdir -p .claude/worktrees && ln -s .claude/worktrees .worktrees`. If `.worktrees` is still a real directory, the repo has not been migrated -- leave it alone, and expect `EnterWorktree` to prompt once.
- Please use succinct, lowercase messages in commit titles and PR titles.
- Please prefer making new commits instead of amending old commits.
- Move uncommitted work to a new branch with git -- never by copying whole files over a different base, which silently reverts intervening commits. Use `git diff > <file>` then `git -C <worktree> apply -p0 <file>` (`-p0` because my git config sets `diff.noprefix`; add `--src-prefix=a/ --dst-prefix=b/` to a patch meant for anyone else), or cherry-pick. Avoid `git stash` here: the stash list is shared by every worktree of the repo, and `git stash branch` switches the current checkout's branch, which other sessions may be using. Afterward, diff against the new base to confirm only intended changes are present.
- In the sandbox, `.git/worktrees` is read-only except for worktrees the session itself is in, so git commands that write a worktree's index or HEAD (add, commit, stash, rebase, reset, checkout, ...) fail there. Unless the session was started inside the worktree, enter it with `EnterWorktree`, passing `path`, right after `git worktree add` or before working in an existing worktree; if the session is already in another worktree, leave it first with `ExitWorktree` (`action: "keep"`). Inside it, still pass the worktree's literal absolute path to `git -C`: a global hook blocks `cd <dir> && git`, and some repo hooks read the branch from the `-C` path.
- Run `git push`, `git fetch` and `git pull` bare from inside the repo (see Sandbox). They work from any checkout, so name the remote and branch rather than reaching a worktree with `-C`. If one fails with `Host key verification failed`, it stayed sandboxed: re-run it bare. Disabling the sandbox is only needed when the session is outside the repo.


## tmux

- When `$TMUX_PANE` is set and you start work on a GitHub issue or PR, rename this session's window: `tmux rename-window -t "$TMUX_PANE" '#<N> <short-slug>'` (e.g. `#18937 datatable-crash`). `<N>` is the PR number when one is known -- even if the work started from an issue -- and the issue number otherwise. Target `$TMUX_PANE` so the rename hits this session's window, not whichever window is focused. Rename again when a PR is opened for the issue you're on, or if the work moves to a different issue or PR.
- Run the rename exactly as above as its own Bash call (see Sandbox). Check whether `$TMUX_PANE` is set in a separate call first, and never disable the sandbox for the rename.


## R

- When running tests, instead of `testthat::test_file()`, use `devtools::test(filter = <tests>)`.
- For R code that is multi-line, or contains quotes/backslashes that need escaping, write the script to a file (in the session scratchpad, or from `mktemp` when there is none) and run it with `Rscript <file>` instead of `Rscript -e '...'`. Inline escaping frequently breaks.
- Avoid inner/nested helper functions in R (closures local to a single caller) as a code-organization tool -- they are hard to grep, debug, and call in isolation. Prefer inline code or a top-level helper. This is R-specific; lambdas and local functions are fine in other languages.
