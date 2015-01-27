"----- Top -----

"#########################################
"##### filetypeを一旦OFF(最下行でON) #####
"#########################################
filetype off
filetype plugin indent off
  
"########################
"##### 非互換モード #####
"########################
set nocompatible

"###################
"##### 表示系 ######
"###################
set enc=utf-8 "エンコードを変更
set fenc=utf-8
set fencs=iso-2022-jp,euc-jp,cp932

syntax on "カラー表示
set number "行番号表示
set showmode "モード表示
set title "編集中のファイル名を表示
set ruler "ルーラーの表示
set cursorline "カーソルのある行を強調
set showcmd "入力中のコマンドをステータスに表示する
set showmatch "括弧入力時の対応する括弧を表示
set laststatus=2 "ステータスラインを常に表示
set t_Co=256 "256色モード

" 起動と同時にNERDTreeを開く(指定したファイルを開く際は開かない)
if !argc()
    autocmd vimenter * NERDTree
endif
" ブックマークを最初から表示
let g:NERDTreeShowBookmarks=1
" 左にNERDTreeを表示
let g:NERDTreeWinPos="left"

"###################################
"##### プログラミングヘルプ系 ######
"###################################
" 行の見た目で上下移動
nnoremap j gj
nnoremap k gk
set noswapfile "スワップファイルを作成しない
set smartindent "オートインデント
set expandtab "タブの代わりに空白文字挿入
set ts=4 sw=4 sts=0 "Tabを入力した場合の空白量
set clipboard+=unnamed "無名レジスタに入るデータを*レジスタにも入れる

" ファイルを開いた際に、前回終了時の行で起動
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
set backspace=indent,eol,start "バックスペースで何でも消せる

" 入力モード中に素早くjjと入力した場合はESCとみなす
inoremap jj <Esc> 

" Esc2度押しで検索結果のハイライトOFF
nnoremap <Esc><Esc> :noh<cr>

"##################
"##### 検索系 #####
"##################
set ignorecase"検索文字列が小文字の場合は大文字小文字を区別なく検索する
set smartcase"検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan"検索時に最後まで行ったら最初に戻る
set incsearch"検索文字列入力時に順次対象文字列にヒットさせる
set nohlsearch"検索結果文字列の非ハイライト表示
set hlsearch"検索マッチテキストをハイライト

"#####################
"##### NeoBundle #####
"#####################

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
call neobundle#end()

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" Recommended to install
" After install, turn shell ~/.vim/bundle/vimproc, (n,g)make -f
" your_machines_makefile
NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
    \ 'windows' : 'make -f make_mingw32.mak',
    \ 'cygwin' : 'make -f make_cygwin.mak',
    \ 'mac' : 'make -f make_mac.mak',  
    \ 'unix' : 'make -f make_unix.mak',
  \ },
\ }

" 未インストールのbundleがないかチェック
NeoBundleCheck

" GitHubリポジトリにあるプラグインを利用する
" --> NeoBundle 'USER/REPOSITORY-NAME'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'davidoc/taskpaper.vim'
NeoBundle 'nanotech/jellybeans.vim' "カラースキーム(jellybeans)
NeoBundle 'altercation/vim-colors-solarized' "カラースキーム(solarized)
NeoBundle 'tomasr/molokai' "カラースキーム(molokai)
NeoBundle 'croaker/mustang-vim' "カラースキーム(mustang)
hi SpellBad ctermfg=white ctermbg=darkred "エラー表示のカラー
hi Search ctermfg=white ctermbg=black "検索結果表示のカラー
"NeoBundle 'itchyny/lightline.vim' "ステータスラインのカラースキームを変更(wombat)
"let g:lightline = {
"        \ 'colorscheme': 'wombat'
"        \ }

" https://sites.google.com/site/fudist/Home/vim-nihongo-ban/-vimrc-sample
""""""""""""""""""""""""""""""
" 挿入モード時、ステータスラインの色を変更
""""""""""""""""""""""""""""""
let g:hi_insert = 'highlight StatusLine guifg=white guibg=darkred gui=none ctermfg=white ctermbg=darkred cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction
  redir END

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction
""""""""""""""""""""""""""""""

NeoBundle 'nathanaelkane/vim-indent-guides'
" vim-indent-guidesの設定
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   ctermbg=233
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  ctermbg=234
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=4

" vim_easymotion
NeoBundle 'Lokaltog/vim-easymotion'
" ホームポジションに近いキーを使う
let g:EasyMotion_keys='hjklasdfgyuiopqwertnmzxcvbHJKLASDFGYUIOPQWERTNMZXCVB'
" 「;」 + 何かにマッピング
let g:EasyMotion_leader_key=";"
" 1 ストローク選択を優先する
let g:EasyMotion_grouping=1
" カラー設定変更
hi EasyMotionTarget ctermbg=none ctermfg=red
hi EasyMotionShade  ctermbg=none ctermfg=blue

NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'git://github.com/kevinw/pyflakes-vim.git'
NeoBundle 'honza/vim-snippets'
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'
" vim-scripts リポジトリにあるプラグインを利用する
NeoBundle 'surround.vim'

" Git以外のリポジトリにあるプラグインを利用する
NeoBundle 'http://svn.macports.org/repository/macports/contrib/mpvim/'
NeoBundle 'https://bitbucket.org/ns9tks/vim-fuzzyfinder'
NeoBundle 'https://bitbucket.org/ns9tks/vim-l9/' 
NeoBundle 'scrooloose/nerdtree'

"##########################################
"##### 頭で無効化したfiletypeを有効化 #####
"##########################################
filetype plugin indent on

"----- END -----
