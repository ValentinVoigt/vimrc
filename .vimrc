execute pathogen#infect()

syntax on
colorscheme desert256
set guifont=DejaVu\ Sans\ Mono\ 12

au BufNewFile,BufRead *.mak set filetype=mako

set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_root_markers = ['setup.py']
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|\.hg|\.svn|node_modules)$',
  \ }

set swapfile
set dir=~/.vim/tmp
set backupdir=~/.vim/backups
set cindent
set autochdir

set showcmd
set showmatch
set ignorecase
set mouse=a
set pastetoggle=<F5>
set splitbelow
set splitright

set laststatus=2
set tabstop=4
set shiftwidth=4
