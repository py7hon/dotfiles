" vim-plug
call plug#begin('~/.vim/plug')
" nerdtree
Plug 'scrooloose/nerdtree'
" one-dark
Plug 'joshdick/onedark.vim'
" lightline
Plug 'itchyny/lightline.vim'
" vim-startify
Plug 'mhinz/vim-startify'
" vim-fugitive
Plug 'tpope/vim-fugitive'
call plug#end()

" other
set autoindent
set number
set cul
set ttyfast
set cursorline
set smartindent
set wrap
set linebreak
set showmatch
set showtabline=2
set mouse=a
set ts=4 sw=4

" theme
syntax on
let g:onedark_hide_endofbuffer = 1
colorscheme onedark

highlight LineNr ctermfg=white

" lightline
set laststatus=2
let g:lightline = {
	\ 'colorscheme': 'darcula',
	\ 'active': {
	\	'left': [ [ 'mode', 'paste' ],
	\			[ 'gitbranch', 'readonly', 'filename', 'modified' ]
	\	]
	\ },
	\	'component': {
	\		'lineinfo': ' %3l:%-2v',
	\ },
	\	'component-function': { 'gitbranch': 'fugitive#head' },
	\}
let g:lightline.separator = {
	\ 'left': '', 'right': ''
	\ }
let g:lightline.subseparator = {
	\ 'left': '', 'right': '' 
	\ }

" returns all modified files of the current git repo
" `2>/dev/null` makes the command fail quietly, so that when we are not
" in a git repo, the list will be empty
function! s:gitModified()
	let files = systemlist('git ls-files -m 2>/dev/null')
	return map(files, "{'line': v:val, 'path': v:val}")
endfunction

" same as above, but show untracked files, honouring .gitignore
function! s:gitUntracked()
	let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
	return map(files, "{'line': v:val, 'path': v:val}")
endfunction

let g:startify_lists = [
		\ { 'type': 'files',     'header': ['   MRU']            },
		\ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
		\ { 'type': 'sessions',  'header': ['   Sessions']       },
		\ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
		\ { 'type': function('s:gitModified'),  'header': ['   git modified']},
		\ { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
		\ { 'type': 'commands',  'header': ['   Commands']       },
		\ ]

" nerdtree
let NERDTreeIgnore = ['\.o$']

" map & remap collection
" nertree open
map <C-n> :NERDTree<CR>
" nerdtree
map <C-n><C-n> :NERDTreeClose<CR>
" new tab
map <C-t><C-t> :tabnew<CR>
" close tab
map <C-t><C-w> :tabclose<CR>
" save file
map <C-s> :w<CR>
" exit vim
map <C-x> :q<CR>
" force exit
map <C-S-x> :q!<CR>
" go to prev tab 
map <S-Left> gT
" go to next tab
map <S-Right> gt

