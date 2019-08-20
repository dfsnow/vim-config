# Dotfiles

A collection of useful dotfiles + setup scripts + configs for cloning to remote computers

## Vim Stuff

Some vim tips + tricks I've pulled from StackOverflow [1](https://stackoverflow.com/questions/1218390/what-is-your-most-productive-shortcut-with-vim/1220118#1220118) [2](https://stackoverflow.com/questions/30130553/whats-the-vim-way-to-select-multiple-instances-of-current-word-and-change-them?rq=1) and various blogs 

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
