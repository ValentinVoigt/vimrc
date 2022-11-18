" Install vim-plug if not found
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
	\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Download coc-settings.json if not found
if empty(glob('~/.config/nvim/coc-settings.json'))
	silent !curl -fLo ~/.config/nvim/coc-settings.json
	\ https://raw.githubusercontent.com/ValentinVoigt/vimrc/master/coc-settings.json
endif

" Plugin list
call plug#begin()
	" Colorschemes
	Plug 'rakr/vim-one'
	Plug 'brafales/vim-desert256'
	Plug 'w0ng/vim-hybrid'
	Plug 'tomasr/molokai'

	" Languages
	Plug 'sophacles/vim-bundle-mako'
	Plug 'yuezk/vim-js'
	Plug 'chase/vim-ansible-yaml'
	Plug 'hashivim/vim-terraform'
	Plug 'leafgarland/typescript-vim'

	" COC
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'neoclide/coc-css'
	Plug 'neoclide/coc-git'
	Plug 'neoclide/coc-html'
	Plug 'neoclide/coc-json'
	Plug 'neoclide/coc-tsserver'
	Plug 'neoclide/coc-prettier'
	Plug 'josa42/coc-docker'
	Plug 'josa42/coc-sh'
	Plug 'fannheyward/coc-pyright'

	" Telescope
	Plug 'kyazdani42/nvim-web-devicons'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
	Plug 'nvim-telescope/telescope.nvim'
	Plug 'nvim-telescope/telescope-project.nvim'
	Plug 'fannheyward/telescope-coc.nvim'
	Plug 'nvim-telescope/telescope-file-browser.nvim'

	" Misc
	Plug 'adelarsq/vim-matchit'
	Plug 'airblade/vim-gitgutter'
	Plug 'airblade/vim-rooter'
	Plug 'akinsho/toggleterm.nvim'
	Plug 'mcauley-penney/tidy.nvim'
	Plug 'mhinz/vim-startify'
	Plug 'tpope/vim-abolish'
	Plug 'tpope/vim-repeat'
	Plug 'tpope/vim-sensible'
	Plug 'tpope/vim-sleuth'
	Plug 'tpope/vim-surround'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'vim-scripts/SearchComplete'
call plug#end()

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
	\| PlugInstall --sync | source $MYVIMRC
\| endif

" Basic config
syntax on
colorscheme hybrid

au BufNewFile,BufRead *.mak set filetype=mako

let g:ctrlp_root_markers = ['setup.py']
let g:ctrlp_custom_ignore = {'dir': '\v[\/](\.git|\.hg|\.svn|node_modules)$',}
autocmd FileType python let b:coc_root_patterns = ['setup.py']
let g:rooter_patterns = ['setup.py']
let g:rooter_change_directory_for_non_project_files = 'current'

set autochdir
set cindent
set exrc
set formatoptions=qjrn
set hidden
set hlsearch
set ignorecase
set laststatus=2
set mouse=a
set nobackup
set nowritebackup
set number
set pastetoggle=<F5>
set secure
set shiftwidth=4
set showcmd
set showmatch
set signcolumn=number
set splitbelow
set splitright
set swapfile
set tabstop=4
set textwidth=80
set updatetime=300
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

" Allow copy paste in neovim
let g:neovide_input_use_logo = 1
map <D-v> "+p<CR>
map! <D-v> <C-R>+
tmap <D-v> <C-R>+

" Highlight same words
autocmd CursorHold * silent call CocActionAsync('highlight')

" Leader commands:
let mapleader = ","
nmap <silent> <leader>, <cmd>noh<cr>
nmap <silent> <leader>? <cmd>call CocAction("doHover")<cr>
nmap <silent> <leader>c <cmd>Telescope coc commands<cr>
nmap <silent> <leader>p <cmd>Telescope coc document_symbols<cr>
nmap <silent> <leader>o <cmd>CocCommand editor.action.organizeImport<cr>
nmap <silent> <leader>f <cmd>CocCommand tsserver.executeAutofix<cr>

" Ctrl+J / Ctrl+K for next/previous error
nmap <silent> <C-j> <cmd>call CocAction('diagnosticNext')<cr>
nmap <silent> <C-k> <cmd>call CocAction('diagnosticPrevious')<cr>

" Press Ctrl-T for Toggleterm-terminal
lua << EOF
	require("toggleterm").setup{
		open_mapping = [[<c-t>]],
		direction = "float",
	}
EOF

" Ctrl+g for live grep in whole project
nmap <silent> <C-g> <cmd>Telescope live_grep cwd=.<cr>
" Ctrl+h for live grep in current file's directory
nmap <silent> <C-h> <cmd>Telescope live_grep cwd=%:h<cr>
" Ctrl+p for find files by fuzzy name
nmap <silent> <C-p> <cmd>Telescope find_files<cr>
" Ctrl+e for file browser in the current file's directory
nmap <silent> <C-e> <cmd>Telescope file_browser path=%:h grouped=true<cr>
" Ctrl+ü for project browser
nmap <silent> <C-ü> <cmd>Telescope project<cr>
" Ctrl+l for raw telescope
nmap <silent> <C-l> <cmd>Telescope<cr>

lua << EOF
	require'nvim-web-devicons'.setup{
		default = true,
	}
EOF

" Setup Telescope
lua << EOF
	require('telescope').setup{
		extensions = {
			project = {
				base_dirs = {
					'~/src',
				},
			}
		}
	}
	require('telescope').load_extension('project')
	require('telescope').load_extension('coc')
	require("telescope").load_extension('file_browser')
EOF
