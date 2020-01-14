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
"regex setting
nnoremap / /\v
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
set clipboard+=unnamed
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

"auto open QuickFix when vimgrep
augroup grepopen
    autocmd!
    autocmd QuickFixCmdPost vimgrep cw
augroup END

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
Plugin 'Shougo/vimproc.vim'
Plugin 'Shougo/vimshell.vim'
Plugin 'yonchu/accelerated-smooth-scroll'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'othree/yajs.vim'
Plugin 'alvan/vim-closetag'
Plugin 'tomtom/tcomment_vim'
Plugin 'itchyny/lightline.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-surround'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'simeji/winresizer'
Plugin 'Shougo/neocomplete.vim'
Plugin 'https://github.com/twitvim/twitvim.git'

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
" let g:unite_enable_start_insert=0
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

" setting for neocomplete.vim
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  " return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=python3complete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

"setting for ctags
set tags=.tags;~
function! s:execute_ctags() abort
  " 探すタグファイル名
  let tag_name = '.tags'
  " ディレクトリを遡り、タグファイルを探し、パス取得
  let tags_path = findfile(tag_name, '.;')
  " タグファイルパスが見つからなかった場合
  if tags_path ==# ''
    return
  endif

  " タグファイルのディレクトリパスを取得
  " `:p:h`の部分は、:h filename-modifiersで確認
  let tags_dirpath = fnamemodify(tags_path, ':p:h')
  " 見つかったタグファイルのディレクトリに移動して、ctagsをバックグラウンド実行（エラー出力破棄）
  execute 'silent !cd' tags_dirpath '&& ctags -R -f' tag_name '2> /dev/null &'
endfunction
augroup ctags
    autocmd!
    autocmd BufWritePost *  call s:execute_ctags()
augroup END

nnoremap <C-]> g<C-]>

"setting for winresizer
" If you want to start window resize mode by `Ctrl+A`
let g:winresizer_start_key = "<C-T>"

" If you cancel and quit window resize mode by `z` (keycode 122)
let g:winresizer_keycode_cancel = 122

"twitvim setting
autocmd FileType twitvim call s:twitvim_my_setting()
function! s:twitvim_my_setting()
    set nowrap
    set whichwrap=b,s,h,l,<,>,[,]
endfunction
"color setting
:colorscheme iceberg
set laststatus=2
set noshowmode
:syntax on
