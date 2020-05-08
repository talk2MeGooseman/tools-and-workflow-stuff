" Requires vim-plug https://github.com/junegunn/vim-plug
" Load vim-enabled plugins from plugins.vim file
let s:path = expand('<sfile>:p:h')
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin(s:path . '/plugged')

call plug#end()

" Execute Vroom with :terminal when in NeoVim
if has('nvim')
  let g:vroom_use_terminal=1
endif

" Move between widows holding down ctrl
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
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

" Get if of swapfiles and annoying prompt about file editing
set nobackup
set nowritebackup
set noswapfile
