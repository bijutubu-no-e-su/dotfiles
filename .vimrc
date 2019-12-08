"encoding
set encoding=utf-8
scriptencoding utf-8
let $LANG = "en"
set backspace=2
set nrformats=
set fileencodings=ucs-boms,utf-8,euc-jp,cp932

set fileformats=unix,dos,mac
set ambiwidth=double

"tab setting
set expandtab
set tabstop=4
set autoindent
set smartindent
set shiftwidth=4

"search setting
set incsearch
set ignorecase
set smartcase
set hlsearch

nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>

"cursor setting
"set cursorcolumn
set whichwrap=b,s,h,l,<,>,[,],~
set number
set cursorline

nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

"enable backspace key
set backspace=indent,eol,start

"match jump setting
set showmatch
source $VIMRUNTIME/macros/matchit.vim

"complement setting
set wildmenu
set history=5000

"enable mouse
if has ('mouse')
    set mouse=a
    if has('mouse_sgr')
        set ttymouse=sgr
    elseif v:version > 703 || v:version is 703 && has('patch632)
        set ttymouse=sgr
    else
        set ttymouse=xterm2
    endif
endif
"swap setting
set noswapfile

"paste setting
if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

	noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
    cnoremap <special> <Esc>[200~ <nop>
    cnoremap <special> <Esc>[201~ <nop>
endif

let mapleader = ","
set scrolloff=5
set nobackup
set autoread
set showcmd
set showmode
set noundofile


"Vundle setting
filetype off        "required

" set the runtime path to include Vundle and intialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" !! write plugins here !!
Plugin 'cocopon/iceberg.vim'
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/neomru.vim'
Plugin 'yonchu/accelerated-smooth-scroll'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'othree/yajs.vim'
Plugin 'alvan/vim-closetag'
Plugin 'tomtom/tcomment_vim'
Plugin 'itchyny/lightline.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-surround'
Plugin 'nathanaelkane/vim-indent-guides'

"setting for vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1
"setting for lightline.vim
let g:lightline = {
		\ 'colorscheme': 'iceberg',
		\ 'active': {
			\ 'left': [ ['mode', 'paste'], ['readonly', 'filepath' , 'modified'] ]
				\ },
		\ 'component_function':{
			\ 'filepath': 'FilePath'
				\ }
		\ }

function! FilePath()
		if winwidth(0) > 90
			return expand('%:p')
		else
			return expand('%')
		endif
	endfunction
"setting for NERDtree
nnoremap <silent><C-E> :NERDTreeToggle<CR>
"All of your Plugins must be added before the following line
call vundle#end()   "required
filetype plugin indent on   "required

"setting for vim-close-tag
let g:closetag_filenames = '*.html,*.phtml,*.erb,*.php,*.vue,*.jsx,*.js,*.xml'

"setting for unite.vim
""" unite.vim
" 入力モードで開始する
let g:unite_enable_start_insert=1
" インサート／ノーマルどちらからでも呼び出せるようにキーマップ
nnoremap <silent> <C-f> :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
inoremap <silent> <C-f> <ESC>:<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> <C-b> :<C-u>Unite buffer file_mru<CR>
inoremap <silent> <C-b> <ESC>:<C-u>Unite buffer file_mru<CR>
" バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" 常用セット
nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
" 全部乗せ
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q
"color setting
:colorscheme iceberg
set laststatus=2
set noshowmode
:syntax on
