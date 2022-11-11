set nocompatible                            " be iMproved, required
set hidden
source $HOME/.vim/plugins.vim

"| ------------------------------
"| Main
"| ------------------------------
syntax enable
set number
set backspace=indent,eol,start
set noshowmode
set noerrorbells visualbell t_vb=

set encoding=UTF-8
set laststatus=2

"| ------------------------------
"| Files, backups
"| ------------------------------
set nobackup
set noswapfile
set nowb

"| ------------------------------
"| Visuals
"| ------------------------------
" colorscheme atom-dark-256
try
    colorscheme nord
catch
endtry
set guifont=Source\ Code\ for\ Powerline:h14
" set macligatures
if !has('gui_running')
    set t_CO=256
endif
set linespace=13
set nowrap
set background=dark
set cursorline

set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R

"highlight line numbers
"hi LineNr guibg=bg
"hi LineNr ctermbg=bg

"Left padding for each window
set foldcolumn=2
"hi foldcolumn guibg=bg
"hi foldcolumn ctermbg=bg

"Get rid of ugly split borders
"hi vertsplit ctermfg=bg ctermbg=bg
"hi vertsplit guifg=bg guibg=bg

if (has("termguicolors"))
  set termguicolors
endif

"| ------------------------------
"| Tabs
"| ------------------------------
set expandtab
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4

"| ------------------------------
"| Split Management
"| ------------------------------
nmap <Leader>vs :vsplit<cr>
nmap <Leader>sp :split<cr>

nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-H> <C-W><C-H>
nmap <C-L> <C-W><C-L>

nmap <D-a> <esc>ggVG
nmap <D-CR> o<esc>

" Close all buffers
map <Leader>ba :bufdo bd<cr>

" Leader
let mapleader = ','                         "The default leader is \, but a comma is much better.
nmap <Leader>w :w!<cr>
nmap <Leader>q :q!<cr>
nmap <Leader>wq :wq!<cr>

"| ------------------------------
"| Search
"| ------------------------------
set hlsearch
set incsearch

"| ------------------------------
"| Mappings
"| ------------------------------
" Make it easy to edit the Vimrc file.
" nmap - mapping sprcial for NORMAL mode
" imap - mapping special for INSERT mode
nmap <Leader>ev :vsp $MYVIMRC<cr>
nmap <Leader>es :e $HOME/.vim/snippets/<cr>
nmap <Leader>ssh :e ~/.ssh/config<cr>
map <Leader>zsh :e ~/.zshrc<cr>

"Add simple highlight removal.
nmap <Leader><space> :nohlsearch<cr>

"Sort lines in visual mode by length (from Jeffery Way videos)
vmap <Leader>su ! awk '{ print length(), $0 \| "sort -n \| cut -d \\  -f2-" }'<cr>

" Return to normal mode with key bindings
imap df <Esc>l
vmap df <Esc>l

" Find and Replace all occurrences under cursor
nnoremap <Leader>h :%s/\<<C-r><C-w>\>//g<Left><Left>

"| ------------------------------
"| Plugins
"| ------------------------------

"|
"| Easymotion
"|
 nmap s <Plug>(easymotion-sn)
 omap s <Plug>(easymotion-tn)


"|
"| Ariline
"|
" airline tabline
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#formatter = 'default'
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'
"let g:airline_left_sep = ''
"let g:airline_right_sep = ''

let g:airline_powerline_fonts = 1
let g:enable_transparent_background = 1
let g:airline_theme="nord"

"|
"| Lightline
"|
let g:lightline = {
  \ 'colorscheme': 'nord',
  \ 'active': {
  \   'left': [ [ 'filename' ],
  \             [ 'linter',  'gitbranch' ] ],
  \   'right': [ [ 'percent', 'lineinfo' ],
  \              [ 'fileencoding', 'filetype' ] ]
  \ },
  \ 'component_function': {
  \   'modified': 'WizMod',
  \   'readonly': 'WizRO',
  \   'gitbranch': 'WizGit',
  \   'filename': 'WizName',
  \   'fileencoding': 'WizEncoding',
  \   'mode': 'WizMode',
  \ },
  \ 'component_expand': {
  \   'linter': 'WizErrors',
  \ },
  \ 'component_type': {
  \   'readonly': 'error',
  \   'linter': 'error'
  \ },
  \ 'separator': { 'left': '▓▒░', 'right': '░▒▓' },
  \ 'subseparator': { 'left': '▒', 'right': '░' }
  \ }

function! WizMod()
  return &ft =~ 'help\|vimfiler' ? '' : &modified ? '» ' : &modifiable ? '' : ''
endfunction

function! WizRO()
  return &ft !~? 'help\|vimfiler' && &readonly ? ' ' : ''
endfunction

function! WizGit()
  return !IsTree() ? exists('*fugitive#head') ? fugitive#head() : '' : ''
endfunction

function! WizName()
  return !IsTree() ? ('' != WizRO() ? WizRO() : WizMod()) . ('' != expand('%:t') ? expand('%:t') : '[none]') : ''
endfunction

function! WizEncoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &enc : &enc) : ''
endfunction

function! WizErrors() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  return l:counts.total == 0 ? '' : printf(' %d', l:counts.total)
endfunction

function! IsTree()
  let l:name = expand('%:t')
  return l:name =~ 'NetrwTreeListing\|undotree\|NERD' ? 1 : 0
endfunction

"|
"| Webdevicons
"|
let g:webdevicons_enable_nerdtree = 1

"|
"| Powerline
"|
let g:Powerline_symbols = 'fancy'

"|
"| Nerd Tree
"|
let g:NERDTreeWinPos = 'left'
let g:NERDTreeIgnore = ['^node_modules$']
let NERDTreeHiijackNetrw = 0
let NERDTreeShowHidden = 0
nmap <F2> :NERDTreeToggle<cr>
nmap <D-k><D-b> :NERDTreeToggle<cr>

"|
"| CtrlP
"|
let g:ctrlp_custom_ignore = 'node_modules\DS_Strore\|git'
let g:ctrlp_match_window = 'top,order:ttb,min:1,max:30,results:30'
nmap <c-R> :CtrlPBufTag<cr>
nmap <D-e> :CtrlPMRUFiles<cr>
nmap <D-t> <Plug>PeepOpen

"|
"| Greplace.vim
"|
set grepprg=ack
let g:grep_cmd_opts = '--noheading'

"|
"| BufExplorer
"|
map <Leader>o :BufExplorer<cr>

"|
"| Syntastic
"|
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


"|
"| Prettier
"|
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0

"|
"| Laravel Specific
"|
nmap <Leader>lm :!php artisan make:
nmap <Leader>lr :e routes/web.php<cr>
nmap <Leader><Leader>c :e app/Http/Controllers/<cr>
nmap <Leader><Leader>m :e app/<cr>
nmap <Leader><Leader>v :e resources/views/<cr>

"| ------------------------------
"| Run code
"| ------------------------------
" todo: check for terminal
autocmd FileType php noremap <Leader>r :! clear && php -f %<cr>
autocmd FileType javascript noremap <Leader>r :! clear && node %<cr>

" Automatically source the Vimrc file on save.
augroup autosourcing
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
    " if vimrc is linked to another file
    execute "autocmd! BufWritePost ".resolve(expand($MYVIMRC))." source $MYVIMRC"
augroup END

function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction
autocmd FileType php inoremap <Leader>n <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>n :call PhpInsertUse()<CR>

function! IPhpExpandClass()
    call PhpExpandClass()
    call feedkeys('a', 'n')
endfunction

autocmd FileType php inoremap <Leader>nf <Esc>:call IPhpExpandClass()<CR>
autocmd FileType php noremap <Leader>nf :call PhpExpandClass()<CR>

"| ------------------------------
"| Sourcing local vimrc
"| ------------------------------
if filereadable(expand("$HOME/.vimrc.local"))
    source $HOME/.vimrc.local
endif
