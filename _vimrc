" vim起動時のみruntimepathにneobundle.vimを追加
if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif

" neobundle.vimの初期化 
" NeoBundleを更新するための設定
call neobundle#begin(expand('~/.vim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'
call neobundle#end()

" 読み込むプラグインを記載
NeoBundle 'Shougo/unite.vim'
NeoBundle 'itchyny/lightline.vim'



" 脱初心者を目指すVimmerにオススメしたいVimプラグインや.vimrcの設定
" http://qiita.com/jnchito/items/5141b3b01bced9f7f48f
" vim-indent-guidesを使ってインデントの深さを視覚化する
" インデントに色を付けて見やすくする
NeoBundle 'nathanaelkane/vim-indent-guides'

" vimを立ち上げたときに、自動的にvim-indent-guidesをオンにする
let g:indent_guides_enable_on_vim_startup = 1

" vim-trailing-whitespaceで行末の不要な半角スペースを可視化
" 行末の半角スペースを可視化
NeoBundle 'bronson/vim-trailing-whitespace'

" 全角スペースの可視化
" http://inari.hatenablog.com/entry/2014/05/05/231307
""""""""""""""""""""""""""""""
" 全角スペースの表示
""""""""""""""""""""""""""""""
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme * call ZenkakuSpace()
        autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
    augroup END
    call ZenkakuSpace()
endif
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
" 最後のカーソル位置を復元する
""""""""""""""""""""""""""""""
if has("autocmd")
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
endif
""""""""""""""""""""""""""""""


" VimをIDEっぽく(主にC++/Java用)整える
" http://rcmdnk.github.io/blog/2014/07/25/computer-vim/#tagbar-srcexpl-nerdtree
" タグのリスト表示
" :TagbarToggleでタグリストを新しいウィンドウで表示/非表示。
NeoBundleLazy "majutsushi/tagbar", {
      \ "autoload": { "commands": ["TagbarToggle"] }}
if ! empty(neobundle#get("tagbar"))
   " Width (default 40)
  let g:tagbar_width = 20
  " Map for toggle
  nn <silent> <leader>t :TagbarToggle<CR>
endif

" 関数等の定義場所のソース表示
" :SrcExplToggleで表示/非表示をトグル。
NeoBundleLazy "wesleyche/SrcExpl", {
      \ "autoload" : { "commands": ["SrcExplToggle"]}}
if ! empty(neobundle#get("SrcExpl"))
  " Set refresh time in ms
  let g:SrcExpl_RefreshTime = 1000
  " Is update tags when SrcExpl is opened
  let g:SrcExpl_isUpdateTags = 0
  " Tag update command
  let g:SrcExpl_updateTagsCmd = 'ctags --sort=foldcase %'
  " Update all tags
  function! g:SrcExpl_UpdateAllTags()
    let g:SrcExpl_updateTagsCmd = 'ctags --sort=foldcase -R .'
    call g:SrcExpl_UpdateTags()
    let g:SrcExpl_updateTagsCmd = 'ctags --sort=foldcase %'
  endfunction
  " Source Explorer Window Height
  let g:SrcExpl_winHeight = 14
  " Mappings
  nn [srce] <Nop>
  nm <Leader>E [srce]
  nn <silent> [srce]<CR> :SrcExplToggle<CR>
  nn <silent> [srce]u :call g:SrcExpl_UpdateTags()<CR>
  nn <silent> [srce]a :call g:SrcExpl_UpdateAllTags()<CR>
  nn <silent> [srce]n :call g:SrcExpl_NextDef()<CR>
  nn <silent> [srce]p :call g:SrcExpl_PrevDef()<CR>
endif

" ファイルエクスプローラー
" :NERDTreeToggleで表示/非表示。
NeoBundleLazy "scrooloose/nerdtree", {
      \ "autoload" : { "commands": ["NERDTreeToggle"] }}
if ! empty(neobundle#get("nerdtree"))
  nn <Leader>N :NERDTreeToggle<CR>
endif

" Tagbar, SrcExpl, NERDTreeを全て表示する
" <Leader>Aで全てをトグル。 それぞれの位置はデフォルトのママ
if ! empty(neobundle#get("nerdtree")) &&
    \! empty(neobundle#get("SrcExpl")) &&
    \! empty(neobundle#get("tagbar"))
  nn <silent> <Leader>A :SrcExplToggle<CR>:NERDTreeToggle<CR>:TagbarToggle<CR>
endif









" 読み込んだプラグインも含め、ファイルタイプの検出、ファイルタイプ別プラグイン/インデントを有効化する
filetype plugin indent on

" インストールのチェック
NeoBundleCheck


" .un~ファイルは不要
" http://www.kaoriya.net/blog/2014/03/30/
:set noundofile


