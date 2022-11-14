" vim: set foldmethod=marker foldlevel=0:

" vim-plug {{{
call plug#begin('~/.vim/plugged')

" Colorschemes
Plug 'git@github.com:neilparikh/dracula-vim.git'
Plug 'junegunn/seoul256.vim'
Plug 'morhetz/gruvbox'
Plug 'sickill/vim-monokai'
Plug 'altercation/vim-colors-solarized'
Plug 'NLKNguyen/papercolor-theme'

" Git
" Plug 'jreybert/vimagit'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" JavaScript/CoffeeScript
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'kchmck/vim-coffee-script'
" Plug 'mtscout6/vim-cjsx'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

" Python
" Plug 'davidhalter/jedi-vim'
" Plug 'fisadev/vim-isort'

" Ruby
Plug 'vim-ruby/vim-ruby'

" Other languages
" Plug 'elixir-editors/vim-elixir'
" Plug 'neovimhaskell/haskell-vim'
Plug 'ocaml/vim-ocaml'
Plug 'raichoo/purescript-vim'
Plug 'ElmCast/elm-vim'
Plug 'rust-lang/rust.vim'
Plug 'rescript-lang/vim-rescript'

" Other
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Plug 'junegunn/goyo.vim'
" Plug 'junegunn/limelight.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'ervandew/supertab'
" Plug 'vim-syntastic/syntastic'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'
Plug 'mhinz/vim-startify'
Plug 'majutsushi/tagbar'
Plug 'w0rp/ale'
" Plug 'itchyny/calendar.vim'
" Add one or both of these
" Plug 'easymotion/vim-easymotion'
" Plug 'justinmk/vim-sneak'
Plug 'junegunn/rainbow_parentheses.vim'

call plug#end()
" }}}

" misc {{{
set backup
set writebackup
set backupdir=~/.vim_backups//
set undofile
set undodir=~/.vim_backups//
set mouse=a
set hidden
filetype plugin indent on
nnoremap <space> :noh<CR>
vnoremap <space> "+y
nnoremap <c-_> :
" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif

set backspace=start,indent,eol

au InsertLeave * set nopaste

" from https://github.com/garybernhardt/dotfiles/blob/master/.vimrc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EXTRACT VARIABLE (SKETCHY)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ExtractVariable()
    let name = input("Variable name: ")
    if name == ''
        return
    endif
    " Enter visual mode (not sure why this is needed since we're already in
    " visual mode anyway)
    normal! gv

    " Replace selected text with the variable name
    exec "normal c" . name
    " Define the variable on the line above
    exec "normal! O" . name . " = "
    " Paste the original selected text to be the variable value
    normal! $p
endfunction
vnoremap <leader>rv :call ExtractVariable()<cr>

autocmd VimLeave * :mksession! ~/.vim/sessions/last.vim
" Copy the current file name to the system clipboard
nnoremap cp :let @+ = expand("%")<CR>

" Make navigating long, wrapped lines behave like normal lines
noremap <silent> k gk
noremap <silent> j gj
noremap <silent> gk k
noremap <silent> gj j
noremap <silent> 0 g0
noremap <silent> g0 0
noremap <silent> $ g$
noremap <silent> g$ $
noremap <silent> ^ g^
noremap <silent> g^ ^
noremap <silent> _ g_

if exists('&breakindent')
  set breakindent      " Indent wrapped lines up to the same level
endif

set scrolloff=3        " don't let the cursor touch the edge of the viewport

" Show potential matches above completion, complete first immediately
set wildmenu
set wildmode=full
" }}}

" Show better meta info {{{
syntax on
set number
set ruler
set showcmd
set colorcolumn=80
set title
" }}}

" Indent settings {{{
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
" }}}

" Searching {{{
set incsearch
set hlsearch
set ignorecase
set smartcase
" }}}

" Better splits {{{
set splitbelow
set splitright
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" }}}

" Enable folding {{{
set foldmethod=indent
set foldlevel=99
" }}}

" Plugins {{{
if isdirectory($HOME.'/.vim/plugged')
  colorscheme dracula
  " Show airline
  set laststatus=2
  " FZF
  source ~/dotfiles/fzf.vim
  " Syntastic
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*
  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_check_on_open = 0
  let g:syntastic_check_on_wq = 0
  let g:syntastic_javascript_checkers = ['eslint']
  let g:syntastic_haskell_checkers = ['hlint']
  let g:syntastic_quiet_messages = { "!level": "errors" }
  map <Leader>s :SyntasticToggleMode<CR>
  " ale
  let g:ale_linters = {'haskell': ['stack-ghc-mod', 'hlint'] }
  " vim-jsx
  " let g:jsx_ext_required = 0
  " vim-gitgutter
  set updatetime=250
  if exists('&signcolumn')  " Vim 7.4.2201
    set signcolumn=yes
  else
    let g:gitgutter_sign_column_always = 1
  endif
  " vim-peekaboo
  let g:peekaboo_window = 'vertical botright 50new'
  " tagbar
  nmap <leader>t :TagbarToggle<CR>
  " jedi-vim
  let g:jedi#show_call_signatures = "2"
  let g:jedi#force_py_version = 3
  let g:jedi#use_tabs_not_buffers = 1
  " vim-startify
  let g:startify_session_dir = "~/.vim/sessions"
  let g:startify_change_to_vcs_root = 1
  let g:startify_fortune_use_unicode = 1
  " gitgutter
  command Ggnh GitGutterNextHunk
  " commentary.vim
  autocmd FileType crontab setlocal commentstring=#\ %s
endif
" }}}

if filereadable($HOME."/dotfiles/local.vim")
    source ~/dotfiles/local.vim
endif
