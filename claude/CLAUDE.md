Thanks for your hard work; I appreciate the effort you put into our tasks.

## General

- Try to be succinct in code comments. Prefer documenting "why" rather than "how", except for very technical or niche code.
- Do not include Claude-Session links in any generated posts (pull requests, merge requests, otherwise).


## Workflow

- Don't propose artificial small or "focused" PR subsets for a coherent batch of work (a refactor, a sweep rename, a test migration) -- do the whole logical piece in one go. This is about not fragmenting one logical change, not about bundling unrelated work.
- For a long-running command (build, test suite) whose output you'll inspect more than once, redirect it to a temp file (`> /tmp/foo.log 2>&1`) and grep that file -- don't re-run the command for each query.
- Once the user has approved a test or command run during an iteration loop, don't re-prompt before each repeat of the same run; just run it (mention the command for transparency). Re-confirm only when the scope changes (a different/larger file, or a global sweep).


## Code style

- Respect existing code style within a file when appropriate. Local style overrides these global rules.
- Use only ASCII characters in source and code files. No em-dashes, en-dashes, smart/curly quotes, ellipsis characters, or other Unicode characters. Use plain ASCII equivalents instead (e.g., `--` for em-dash, `...` for ellipsis, straight `'` and `"` for quotes).
- Put the body of an `if` (and of `else`/single-statement loops) on its own indented line -- never on the same line as the conditional. `if (foo)\n  bar();` or the braced form is fine; `if (foo) bar();` is not.
- Inside functions, separate logical phases (e.g. setup, action, error-check) with single blank lines rather than packing every statement into one solid block. Don't over-fragment -- statements that are part of the same step stay together.
- For "short" function calls, place all arguments on the same line.
- For "long" function calls, prefer using one argument per line, with the first argument on its own line.
- Prefer using multi-line raw strings for embedded strings of code, when supported by the programming language used.


## File reading

- Prefer the `Read` tool with `offset`/`limit` to view file contents. Shelling out to `sed`, `head`, `tail`, or `cat` for reading is fine when auto mode asks for it.


## Git

- When creating a branch, use 'bugfix/' or 'feature/' as a prefix for the branch name as appropriate.
- Prefer using worktrees for code changes.
- When creating a worktree, make sure the worktree directory name matches the branch name. For example, a branch called `feature/virtual-scrollers` should normally be in the directory `.worktress/feature--virtual-scrollers`.
- Please use succinct, lowercase messages in commit titles and PR titles.
- Please prefer making new commits instead of amending old commits.
- Move uncommitted work to a new branch with git (`git stash` then `git stash branch`, or `git diff > patch` + `git apply`, or cherry-pick) -- never by copying whole files over a different base, which silently reverts intervening commits. Afterward, diff against the new base to confirm only intended changes are present.


## tmux

- When `$TMUX_PANE` is set and you start work on a GitHub issue or PR, rename this session's window: `tmux rename-window -t "$TMUX_PANE" '#<N> <short-slug>'` (e.g. `#18937 datatable-crash`). Target `$TMUX_PANE` so the rename hits this session's window, not whichever window is focused. Rename again if the work moves to a different issue or PR.


## R

- When running tests, instead of `testthat::test_file()`, use `devtools::test(filter = <tests>)`.
- For R code that is multi-line, or contains quotes/backslashes that need escaping, write the script to a temp file (e.g., `mktemp -t script.XXXXXX.R`) and run with `Rscript <file>` instead of `Rscript -e '...'`. Inline escaping frequently breaks.
- Avoid inner/nested helper functions in R (closures local to a single caller) as a code-organization tool -- they are hard to grep, debug, and call in isolation. Prefer inline code or a top-level helper. This is R-specific; lambdas and local functions are fine in other languages.


