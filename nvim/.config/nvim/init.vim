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
Plug 'hrsh7th/vim-vsnip'

call plug#end()

" Load settings from vimrc
set runtimepath^=/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc


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
  buf_set_keymap('n', '<leader>ld', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<leader>li', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<leader>lf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  buf_set_keymap('n', '<leader>lr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

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
" => Additional Plugin Settings
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
    \ 'ld' : ['<cmd>lua vim.lsp.buf.definition()<CR>'    , 'which_key_ignore'],
    \ 'li' : ['<cmd>lua vim.lsp.buf.implementation()<CR>', 'which_key_ignore'],
    \ 'lf' : ['<cmd>lua vim.lsp.buf.formatting()<CR>'    , 'which_key_ignore'],
    \ 'lr' : ['<cmd>lua vim.lsp.buf.references()<CR>'    , 'which_key_ignore'],
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
