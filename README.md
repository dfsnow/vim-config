# Dotfiles

A collection of useful dotfiles + setup scripts + configs for cloning to remote computers

### Surround

 * `cs"'` to change `"` to `'`
 * `cs"<q>` to change `"` to `<q>`
 * `ds"` to entirely delete  `"`
 * `yss"` to wrap an entire line in `"`
 * Use linewise visual mode followed by `S` to surround your selection

### Movement

 * `*` and  `#` search for the word under the cursor forward/backward
 * `w` to the next word
 * `W` to the next space-separated word
 * `b` / `e` to the begin/end of the current word. (`B` / `E` for space separated only)
 * `gg` / `G` jump to the begin/end of the file
 * `%` jump to the matching { .. } or ( .. ), etc.
 * `'.` jump back to last edited line
 * `g;` jump back to last edited position

### Handy Tricks

 * `S` will replace the current word last yank
 * `ci(` = change text between ( .. )
 * `J` joins two lines
 * Ctrl+A / Ctrl+X increments/decrements a number
 * `.` repeat last command (a simple macro)
 * `==` fix line indent
 * `>` indent block (in visual mode)
 * `<` unindent block (in visual mode)
 * `:'<,'>s/old/new/g` replace within visual selection
 * `:g/regex/ex` run the given command on the matching regex

### Macros

 * Press `q[ key ]` to start recording
 * Then hit `q` to stop recording
 * The macro can be played with `@[ key ]`

### Multiline Changes

 * Select current word with `*` (go back with `N`)
 * Change word with `gn` motion. e.g. `cgnfoo<esc>`
 * Repeat via `.` command
