" Requires vim-plug https://github.com/junegunn/vim-plug
" Load vim-enabled plugins from plugins.vim file
let s:path = expand('<sfile>:p:h')
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin(s:path . '/plugged')
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'elixir-editors/vim-elixir'
Plug 'haishanh/night-owl.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'mhinz/vim-mix-format'
Plug 'ntpeters/vim-better-whitespace'
Plug 'preservim/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-syntastic/syntastic'
" Load at the end
Plug 'sheerun/vim-polyglot'
call plug#end()

" Execute Vroom with :terminal when in NeoVim
if has('nvim')
  let g:vroom_use_terminal=1
endif

""""" enable 24bit true color

" If you have vim >=8.0 or Neovim >= 0.1.5
if (has("termguicolors"))
 set termguicolors
endif

" For Neovim 0.1.3 and 0.1.4
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

""""" enable the theme

syntax enable
colorscheme night-owl

" To enable the lightline theme
let g:lightline = { 'colorscheme': 'nightowl' }

" Move between widows holding down ctrl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Disable using arrow keys for nav.. HARD MODE
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Adjust height when focused
set winheight=30

" Make it obvious where 80 character line is
set textwidth=80
set colorcolumn=+1

set backspace=2   " Backspace deletes like most programs in insert mode
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set expandtab
set tabstop=2

" Get if of swapfiles and annoying prompt about file editing
set nobackup
set nowritebackup
set noswapfile

let g:javascript_plugin_jsdoc = 1

" CTRL-P remap
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" Nerd tree remap
map <Leader>n :NERDTreeToggle<CR>

" Better Whitespace
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Neovim, use system clipboard
set clipboard=unnamed
