
call plug#begin('~/.vim/vim-plug')

" UI and colors
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'liuchengxu/vim-which-key'
Plug 'dracula/vim',{'as':'dracula'}

" Git integration
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Movement and formatting
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'

" Better integration
Plug 'wincent/terminus'
Plug 'tmux-plugins/vim-tmux-focus-events'

" Convenience functions
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Linting and completion
Plug 'dense-analysis/ale'
Plug 'maximbaz/lightline-ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Table of Contents
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sections:
"    -> General
"    -> VIM User Interface
"    -> Colors and Fonts
"    -> Files and Backups
"    -> Text, Tab and Indent Related
"    -> Moving Around, Tabs and Buffers
"    -> Editing Mappings
"    -> Spell Checkings
"    -> Helper Functions
"    -> Miscellaneous
"    -> Plugins
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" Fast quitting and saving
nmap <leader>q :q<cr>
nmap <leader>Q :q!<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null
command Q :q!


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM User Interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Avoid garbled characters in Chinese language windows OS
let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hidden

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif

" Add a bit extra margin to the left
set foldcolumn=0

" Show the line number
set number

" Show a highlight on the cursorline
set cursorline

" Show the 80 char column
set colorcolumn=80


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

" Set the default font
set guifont=DejaVu_Sans_Mono:h14

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

set background=dark

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, Backups and Undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, Tab and Indent Related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Keep text selected on indent
vnoremap < <gv
vnoremap > >gv


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, Tabs, Windows and Buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Split new buffers to the right
set splitright
set splitbelow

" Window movement with leader
nnoremap <leader>j <C-W><C-J>
nnoremap <leader>k <C-W><C-K>
nnoremap <leader>l <C-W><C-L>
nnoremap <leader>h <C-W><C-H>

" Open new buffers
map <leader>bb :new<cr>
map <leader>bv :vnew<cr>
map <leader>bn :enew<cr>

" Close the current buffer
map <leader>bd :Bclose<cr>
map <leader>bc :Bclose<cr>

" Close all the buffers
map <leader>ba :bufdo bd<cr>

" Switch between buffers in windows
map <leader>ll :bnext<cr>
map <leader>bl :bnext<cr>
map <leader>bh :bprevious<cr>
map <leader>hh :bprevious<cr>

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell Checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Miscellaneous
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle paste mode on and off
map <leader>v :setlocal paste!<cr>

" Better line joins
if v:version > 703 || v:version == 703 && has('patch541')
  set formatoptions+=j
endif

" R indentation fix
let r_indent_align_args = 0

" Remapping enter and backspace in Normal mode
nnoremap <BS> {
onoremap <BS> {
vnoremap <BS> {
nnoremap <expr> <CR> empty(&buftype) ? '}' : '<CR>'
onoremap <expr> <CR> empty(&buftype) ? '}' : '<CR>'
vnoremap <CR> }

" Replace word with last yank
nnoremap S diw"0P
vnoremap S "_d"0P"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDcommenter
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1

" ALE
let g:ale_sign_column_always = 1
let g:ale_disable_lsp = 1
let g:ale_fix_on_save = 0
let g:ale_linters_explicit = 1
let g:ale_fixers = {
    \ '*'          : ['remove_trailing_lines', 'trim_whitespace']  ,
    \ 'python'     : ['isort', 'black']                ,
    \ 'rmd'        : ['styler']                        ,
    \ 'r'          : ['styler']                        ,
    \ 'css'        : ['stylelint']                     ,
    \ }

let g:ale_linters = {
    \ 'python'     : ['flake8']                        ,
    \ 'r'          : ['lintr']                         ,
    \ 'rmd'        : ['lintr']                         ,
    \ 'sh'         : ['shellcheck']                    ,
    \ 'css'        : ['stylelint']                     ,
    \ 'html'       : ['htmlhint']                      ,
    \ }

nnoremap <leader>at :ALEToggle<CR>
nnoremap <leader>af :ALEFix<CR>
nnoremap <leader>as :ALEFixSuggest<CR>
nnoremap <leader>ai :ALEInfo<CR>
nnoremap <leader>an :ALENextWrap<CR>
nnoremap <leader>ap :ALEPreviousWrap<CR>

" CoC.nvim
let g:coc_global_extensions = [
    \ 'coc-json'    ,
    \ 'coc-html'    ,
    \ 'coc-css'     ,
    \ 'coc-yaml'    ,
    \ 'coc-toml'    ,
    \ 'coc-sh'      ,
    \ 'coc-pyright'
    \ ]

function! s:check_back_space() abort
let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()

if has("patch-8.1.1564")
  set signcolumn=number
else
  set signcolumn=yes
endif

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
  \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" GitGutter
let g:gitgutter_map_keys = 0
nnoremap <c-N> :GitGutterNextHunk<CR>
nnoremap <c-P> :GitGutterPrevHunk<CR>
nnoremap <c-U> :GitGutterUndoHunk<CR>
nmap <leader>gg :GitGutterToggle<CR>
nmap <leader>gn :GitGutterNextHunk<CR>
nmap <leader>gp :GitGutterPrevHunk<CR>
nmap <leader>ga :GitGutterStageHunk<CR>
nmap <leader>gv :GitGutterPreviewHunk<CR>
nmap <leader>gu :GitGutterUndoHunk<CR>

" Git Fugitive
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gl :exe ':!cd ' . expand('%:p:h') . '; git l'<CR>
nnoremap ? :GFiles<CR>

" Easymotion
nmap <space> <Plug>(easymotion-prefix)s
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)
let g:EasyMotion_smartcase = 1

" Dracula
let g:dracula_colorterm = 0
colorscheme dracula

" Lightline
set laststatus=2
set noshowmode
let g:lightline = {
    \ 'colorscheme'         : 'dracula',
    \ 'component_function'  : {'gitbranch': 'fugitive#head'}  ,
    \ }

let g:lightline.tabline = {
    \ 'left'                : [['buffers']]            ,
    \ 'right'               : [['close']]              ,
    \ }

let g:lightline.component_expand = {
    \ 'buffers'             : 'lightline#bufferline#buffers' ,
    \ 'linter_checking'     : 'lightline#ale#checking' ,
    \ 'linter_warnings'     : 'lightline#ale#warnings' ,
    \ 'linter_errors'       : 'lightline#ale#errors'   ,
    \ 'linter_ok'           : 'lightline#ale#ok'       ,
    \ }

let g:lightline.component_type = {
    \ 'buffers'             : 'tabsel'                 ,
    \ 'linter_checking'     : 'left'                   ,
    \ 'linter_warnings'     : 'warning'                ,
    \ 'linter_errors'       : 'error'                  ,
    \ 'linter_ok'           : 'left'                   ,
    \ }

let g:lightline.active = {
    \ 'right' : [
    \   ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok'],
    \   ['percent', 'line']                                                 ,
    \   ['fileformat', 'fileencoding', 'filetype'] ]                        ,
    \ 'left' : [
    \   ['mode', 'paste']                                                   ,
    \   ['gitbranch']                                                       ,
    \   ['readonly', 'filename', 'modified'] ]                              ,
    \ }

" FZF
nmap <Leader>fg :GFiles<CR>
nmap <Leader>ff :Files<CR>
nmap <Leader>fb :Buffers<CR>
nmap <Leader>fh :History<CR>
nmap <Leader>fl :BLines<CR>

" WhichKey
nnoremap <silent> <leader><leader> :<c-u>WhichKey  ','<CR>
call which_key#register(',', "g:which_key_map")

" WhichKey defaults
let g:which_key_map = {
    \ 'v' : [':setlocal paste!'             , 'Paste mode']              ,
    \ '?' : ['GFiles'                       , 'Search git files']        ,
    \ 'h' : ['<C-W><C-H>'                   , 'Window left']             ,
    \ 'j' : ['<C-W><C-J>'                   , 'Window down']             ,
    \ 'k' : ['<C-W><C-K>'                   , 'Window up']               ,
    \ 'l' : ['<C-W><C-L>'                   , 'Window right']            ,
    \ 'Q' : ['q!'                           , 'which_key_ignore']        ,
    \ 'w' : ['w!'                           , 'which_key_ignore']        ,
    \ 'q' : ['q'                            , 'which_key_ignore']        ,
    \ 'll': ['bnext'                        , 'Next buffer']             ,
    \ 'hh': ['bprevious'                    , 'Previous buffer']         ,
    \ 'gd': ['<Plug>(coc-definition)'       , 'Go to definition']        ,
    \ 'gy': ['<Plug>(coc-type-definition)'  , 'Go to type definition']   ,
    \ 'gi': ['<Plug>(coc-implementation)'   , 'Go to implementation']    ,
    \ 'gr': ['<Plug>(coc-references)'       , 'Go to references']        ,
    \ }

" WhichKey ale
let g:which_key_map.a = {
    \ 'name' : '+ale' ,
    \ 's' : ['ALEFixSuggest'                   , 'Suggest fixers']         ,
    \ 'i' : ['ALEInfo'                         , 'View runtime info']      ,
    \ 't' : ['ALEToggle'                       , 'Toggle linting']         ,
    \ 'f' : ['ALEFix'                          , 'Run fixers']             ,
    \ 'n' : ['ALENextWrap'                     , 'Next ALE error']         ,
    \ 'p' : ['ALEPreviousWrap'                 , 'Previous ALE error']     ,
    \ }

" WhichKey buffer
let g:which_key_map.b = {
    \ 'name' : '+buffer' ,
    \ 'b' : ['new'        , 'New buffer (horizontal)'] ,
    \ 'v' : ['vnew'       , 'New buffer (vertical)']   ,
    \ 'n' : ['enew'       , 'New buffer (no split)']   ,
    \ 'd' : ['Bclose'     , 'Close buffer']            ,
    \ 'c' : ['Bclose'     , 'Close buffer']            ,
    \ 'l' : ['bnext'      , 'Next buffer']             ,
    \ 'h' : ['bprevious'  , 'Previous buffer']         ,
    \ 'a' : ['bufdo bd'   , 'Close all buffers']       ,
    \ }

" WhichKey nerdcommenter
let g:which_key_map.c = {
    \ 'name' : '+comment' ,
    \ ' ' : ['<plug>NERDCommenterToggle'       , 'Toggle comment']         ,
    \ '$' : ['<plug>NERDCommenterToEOL'        , 'Comment to EOL']         ,
    \ 'c' : ['<plug>NERDCommenterComment'      , 'Comment selection']      ,
    \ 'u' : ['<plug>NERDCommenterUncomment'    , 'Uncomment selection']    ,
    \ 'm' : ['<plug>NERDCommenterMinimal'      , 'Minimal comment']        ,
    \ 's' : ['<plug>NERDCommenterSexy'         , 'Sexy comment']           ,
    \ 'l' : ['<plug>NERDCommenterAlignLeft'    , 'Left side comment']      ,
    \ 'n' : ['<plug>NERDCommenterNested'       , 'Nested comment']         ,
    \ 'i' : ['<plug>NERDCommenterInvert'       , 'Invert comment']         ,
    \ 'A' : ['<plug>NERDCommenterAppend'       , 'which_key_ignore']       ,
    \ 'y' : ['<plug>NERDCommenterYank'         , 'which_key_ignore']       ,
    \ 'a' : ['<plug>NERDCommenterAltDelims'    , 'which_key_ignore']       ,
    \ 'b' : ['<plug>NERDCommenterAlignBoth'    , 'which_key_ignore']       ,
    \ }

" WhichKey fzf
let g:which_key_map.f = {
    \ 'name' : '+fzf' ,
    \ 'g' : ['GFiles'     , 'Search git files']        ,
    \ 'f' : ['Files'      , 'Search all files']        ,
    \ 'b' : ['Buffers'    , 'Search buffers']          ,
    \ 'l' : ['BLines'     , 'Search lines']            ,
    \ 'h' : ['History'    , 'Search history']          ,
    \ }

" WhichKey git
let g:which_key_map.g = {
    \ 'name' : '+git' ,
    \ 'l' : [":exe ':!cd ' . expand('%:p:h') . '; git l'", 'View logs'] ,
    \ 'g' : ['GitGutterToggle'      , 'Toggle GitGutter']                  ,
    \ 'b' : ['Gblame'               , 'View blame']                        ,
    \ 'a' : ['GitGutterStageHunk'   , 'Stage hunk']                        ,
    \ 'd' : ['Gdiff'                , 'View diff']                         ,
    \ 's' : ['Gstatus'              , 'View status']                       ,
    \ 'v' : ['GitGutterPreviewHunk' , 'Preview hunk']                      ,
    \ 'u' : ['GitGutterUndoHunk'    , 'Undo hunk']                         ,
    \ 'n' : ['GitGutterNextHunk'    , 'Next hunk']                         ,
    \ 'p' : ['GitGutterPrevHunk'    , 'Previous hunk']                     ,
    \ }

" WhichKey spellcheck
let g:which_key_map.s = {
    \ 'name' : '+spell' ,
    \ 's' : [':setlocal spell!' , 'Toggle spell check'],
    \ 'n' : [']s'         , 'Next misspelling']        ,
    \ 'p' : ['[s'         , 'Previous misspelling']    ,
    \ 'a' : ['zg'         , 'Add to dictionary']       ,
    \ '?' : ['z='         , 'Search in dictionary']    ,
    \ }
