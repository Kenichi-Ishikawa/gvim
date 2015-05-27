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
"NeoBundle 'bronson/vim-trailing-whitespace'
" Vimで行末の余分なスペースを取り除く
autocmd BufWritePre * :%s/\s\+$//ge

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
  " トグル用のショートカットは<Leader>E<CR>に。
  " <Leader>Euで現ファイルのタグをアップデート。
  " <Leader>Eaで全てのファイルのタグをアップデート。
  " <Leader>En/pはその関数が複数の場所で定義されてる時などに 次の候補や前の候補への移動。
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


" 非同期処理
NeoBundle 'Shougo/vimproc.vim'


" 補完機能
NeoBundle 'Shougo/neocomplcache'
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Enable heavy features.
" Use camel case completion.
"let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
"let g:neocomplcache_enable_underbar_completion = 1

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplcache_enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplcache_enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
if !exists('g:neocomplcache_force_omni_patterns')
  let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.php =
\ '[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'
let g:neocomplcache_omni_patterns.c =
\ '[^.[:digit:] *\t]\%(\.\|->\)\%(\h\w*\)\?'
let g:neocomplcache_omni_patterns.cpp =
\ '[^.[:digit:] *\t]\%(\.\|->\)\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplcache_omni_patterns.perl =
\ '[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'


" 補完生成機能
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif


" ファイル保存時にシンタックスチェックする
NeoBundle 'scrooloose/syntastic'
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

"let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
let g:syntastic_php_checkers = ['php', 'phpmd']




" 読み込んだプラグインも含め、ファイルタイプの検出、ファイルタイプ別プラグイン/インデントを有効化する
filetype plugin indent on

" インストールのチェック
NeoBundleCheck

" .un~ファイルは不要
" http://www.kaoriya.net/blog/2014/03/30/
:set noundofile

" tabスペースを4個分
set tabstop=4

" 行番号を表示
 set number

" バックアップファイルを作成しない
:set nobackup

" Vimの内部文字コードする(encoding)
set encoding=utf-8