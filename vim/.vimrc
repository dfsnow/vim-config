call plug#begin('~/.vim/vim-plug')

" UI and colors
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'maximbaz/lightline-ale'
Plug 'liuchengxu/vim-which-key'
Plug 'dracula/vim',{'as':'dracula'}
Plug 'junegunn/goyo.vim'

" Git integration
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'

" Formatting
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-commentary'

" Terminal integration
Plug 'wincent/terminus'

" Movement and search
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Linting, LSP and autocompletion
Plug 'dense-analysis/ale'
Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'hrsh7th/nvim-compe'

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
"    -> Linting, LSP and Autocompletion
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

" Fast quitting and saving
nmap <leader>w :w!<cr>
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

" Set background color
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
" Turn backup off, since most stuff is in SVN, git, etc anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, Tab and Indent Related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable smart auto indent and line wrapping
set ai
set si
set wrap

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

" Return to last edit position when opening files
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

" Spellfile language and location
set spelllang=en
set spellfile=$HOME/dotfiles/vim/.vim/spell/en.utf-8.add


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
" Enable folding
set foldcolumn=1
set foldmethod=indent
set foldlevel=99
nnoremap <space> za

" Open README file with helpful tips
map <leader>r :e ~/dotfiles/README.md<CR>

" Toggle paste mode on and off
map <leader>v :setlocal paste!<cr>

" Better line joins
set formatoptions+=j

" Fix R indentation 
let r_indent_align_args = 0

" Remap enter and backspace in Normal mode
nnoremap <BS> {
onoremap <BS> {
vnoremap <BS> {
nnoremap <expr> <CR> empty(&buftype) ? '}' : '<CR>'
onoremap <expr> <CR> empty(&buftype) ? '}' : '<CR>'
vnoremap <CR> }

" Replace word with last yank
nnoremap S diw"0P
vnoremap S "_d"0P"

" Decrease update time
set updatetime=100

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Linting, LSP and Autocompletion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Linting config via ALE
let g:ale_disable_lsp = 1
let g:ale_fix_on_save = 0
let g:ale_linters_explicit = 1
let g:ale_fixers = {
    \ '*'          : ['remove_trailing_lines', 'trim_whitespace']             ,
    \ 'python'     : ['isort', 'black']                                       ,
    \ 'rmd'        : ['styler']                                               ,
    \ 'r'          : ['styler']                                               ,
    \ 'css'        : ['stylelint']                                            ,
    \ }

let g:ale_linters = {
    \ 'python'     : ['flake8']                                               ,
    \ 'r'          : ['lintr']                                                ,
    \ 'rmd'        : ['lintr']                                                ,
    \ 'sh'         : ['shellcheck']                                           ,
    \ 'css'        : ['stylelint']                                            ,
    \ 'html'       : ['htmlhint']                                             ,
    \ }

nnoremap <leader>at :ALEToggle<CR>
nnoremap <leader>af :ALEFix<CR>
nnoremap <leader>as :ALEFixSuggest<CR>
nnoremap <leader>ai :ALEInfo<CR>
nnoremap <leader>an :ALENextWrap<CR>
nnoremap <leader>ap :ALEPreviousWrap<CR>

" Config for native neovim LSP and autocomplete 
lua << EOF
require'lspinstall'.setup()

-- Map keys after lang server attaches to buffer
local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', '<leader>ld', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<leader>li', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<leader>lr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>lf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- List installed servers, manually add R server
local servers = require'lspinstall'.installed_servers()
table.insert(servers, "r_language_server")

-- Loop to setup installed servers and map keybindings
for _, server in pairs(servers) do
  nvim_lsp[server].setup { on_attach = on_attach }
end

-- Compe (autocomplete) setup
vim.o.completeopt="menuone,noinsert"

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    nvim_lsp = true;
  };
}

-- Compe tab completion
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn.call("vsnip#available", {1}) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

EOF


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Signify
nmap <leader>gg :SignifyToggle<CR>
nmap <leader>gu :SignifyHunkUndo<CR>
nmap <leader>gd :SignifyHunkDiff<CR>
nmap <leader>gn <plug>(signify-next-hunk)
nmap <leader>gp <plug>(signify-prev-hunk)

" Git Fugitive
nmap <leader>gs :Git<CR>
nmap <leader>gb :Git blame<CR>
nmap <leader>gc :Git commit<CR>

" Goyo
nmap <leader>y :Goyo<CR>

" Dracula
let g:dracula_colorterm = 0
colorscheme dracula

" Lightline
set laststatus=2
set noshowmode
let g:lightline = {
    \ 'colorscheme'         : 'dracula',
    \ 'component_function'  : {'gitbranch': 'fugitive#head'}                  ,
    \ }

let g:lightline.tabline = {
    \ 'left'                : [['buffers']]                                   ,
    \ 'right'               : [['close']]                                     ,
    \ }

let g:lightline.component_expand = {
    \ 'buffers'             : 'lightline#bufferline#buffers'                  ,
    \ 'linter_checking'     : 'lightline#ale#checking'                        ,
    \ 'linter_warnings'     : 'lightline#ale#warnings'                        ,
    \ 'linter_errors'       : 'lightline#ale#errors'                          ,
    \ 'linter_ok'           : 'lightline#ale#ok'                              ,
    \ }

let g:lightline.component_type = {
    \ 'buffers'             : 'tabsel'                                        ,
    \ 'linter_checking'     : 'left'                                          ,
    \ 'linter_warnings'     : 'warning'                                       ,
    \ 'linter_errors'       : 'error'                                         ,
    \ 'linter_ok'           : 'left'                                          ,
    \ }

let g:lightline.active = {
    \ 'right' : [
    \   ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok']  ,
    \   ['percent', 'line']                                                   ,
    \   ['fileformat', 'fileencoding', 'filetype'] ]                          ,
    \ 'left'  : [
    \   ['mode', 'paste']                                                     ,
    \   ['gitbranch']                                                         ,
    \   ['readonly', 'filename', 'modified'] ]                                ,
    \ }

" FZF
nmap <leader>ff :Files<CR>
nmap <leader>fg :GFiles<CR>
nmap <leader>fb :Buffers<CR>
nmap <leader>fh :History<CR>
nmap <leader>fl :BLines<CR>
nmap <leader>fm :Maps<CR>
nmap <leader>fc :Commits<CR>
nmap <leader>fr :Rg<CR>
nnoremap ? :Rg<CR>

" WhichKey
nnoremap <silent> <leader><leader> :<c-u>WhichKey  ','<CR>
call which_key#register(',', "g:which_key_map")

" WhichKey defaults
let g:which_key_map = {
    \ 'v' : [':setlocal paste!'                , 'Paste mode']                ,
    \ 'r' : [':e ~/dotfiles/README.md'         , 'Open README']               ,
    \ '?' : ['Rg'                              , 'Search in files']           ,
    \ 'h' : ['<C-W><C-H>'                      , 'which_key_ignore']          ,
    \ 'j' : ['<C-W><C-J>'                      , 'which_key_ignore']          ,
    \ 'k' : ['<C-W><C-K>'                      , 'which_key_ignore']          ,
    \ 'l' : ['<C-W><C-L>'                      , 'which_key_ignore']          ,
    \ 'Q' : ['q!'                              , 'which_key_ignore']          ,
    \ 'w' : ['w!'                              , 'which_key_ignore']          ,
    \ 'q' : ['q'                               , 'which_key_ignore']          ,
    \ 'll': ['bnext'                           , 'Next buffer']               ,
    \ 'hh': ['bprevious'                       , 'Previous buffer']           ,
    \ 'y' : ['Goyo'                            , 'Distraction-free mode']     ,
    \ }

" WhichKey ale
let g:which_key_map.a = {
    \ 'name' : '+ale' ,
    \ 's' : ['ALEFixSuggest'                   , 'Suggest fixers']            ,
    \ 'i' : ['ALEInfo'                         , 'View runtime info']         ,
    \ 't' : ['ALEToggle'                       , 'Toggle linting']            ,
    \ 'f' : ['ALEFix'                          , 'Run fixers']                ,
    \ 'n' : ['ALENextWrap'                     , 'Next ALE error']            ,
    \ 'p' : ['ALEPreviousWrap'                 , 'Previous ALE error']        ,
    \ }

" WhichKey buffer
let g:which_key_map.b = {
    \ 'name' : '+buffer' ,
    \ 'b' : ['new'                             , 'New buffer (horizontal)']   ,
    \ 'v' : ['vnew'                            , 'New buffer (vertical)']     ,
    \ 'n' : ['enew'                            , 'New buffer (no split)']     ,
    \ 'd' : ['Bclose'                          , 'Close buffer']              ,
    \ 'c' : ['Bclose'                          , 'Close buffer']              ,
    \ 'l' : ['bnext'                           , 'Next buffer']               ,
    \ 'h' : ['bprevious'                       , 'Previous buffer']           ,
    \ 'a' : ['bufdo bd'                        , 'Close all buffers']         ,
    \ }

" WhichKey fzf
let g:which_key_map.f = {
    \ 'name' : '+fzf' ,
    \ 'g' : ['GFiles'                          , 'Search git files']          ,
    \ 'f' : ['Files'                           , 'Search all files']          ,
    \ 'b' : ['Buffers'                         , 'Search buffers']            ,
    \ 'l' : ['BLines'                          , 'Search lines']              ,
    \ 'h' : ['History'                         , 'Search history']            ,
    \ 'm' : ['Maps'                            , 'Search mappings']           ,
    \ 'c' : ['Commits'                         , 'Search commits']            ,
    \ 'r' : ['Rg'                              , 'Search in files']           ,
    \ }

" WhichKey git
let g:which_key_map.g = {
    \ 'name' : '+git' ,
    \ 's' : [':Git'                            , 'Open git']                  ,
    \ 'b' : [':Git blame'                      , 'View blame']                ,
    \ 'c' : [':Git commit'                     , 'Create commit']             ,
    \ 'd' : [':SignifyHunkDiff'                , 'View diff']                 ,
    \ 'n' : ['<plug>(signify-next-hunk)'       , 'Next hunk']                 ,
    \ 'p' : ['<plug>(signify-prev-hunk)'       , 'Previous hunk']             ,
    \ 'u' : [':SignifyHunkUndo'                , 'Undo hunk']                 ,
    \ }

" WhichKey spellcheck
let g:which_key_map.s = {
    \ 'name' : '+spell' ,
    \ 's' : [':setlocal spell!'                , 'Toggle spell check']        ,
    \ 'n' : [']s'                              , 'Next misspelling']          ,
    \ 'p' : ['[s'                              , 'Previous misspelling']      ,
    \ 'a' : ['zg'                              , 'Add to dictionary']         ,
    \ '?' : ['z='                              , 'Search in dictionary']      ,
    \ }
