" Normally this if-block is not needed, because `:set nocp` is done
" automatically when .vimrc is found. However, this might be useful
" when you execute `vim -u .vimrc` from the command line.
if &compatible
  " `:set nocp` has many side effects. Therefore this should be done
  " only when 'compatible' is set.
  set nocompatible
endif

packadd minpac

if !exists('g:loaded_minpac')
  " minpac is not available
else

  call minpac#init()
  " minpac must have {'type': 'opt'} so that it can be loaded with `packadd`.
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  " plugins
  call minpac#add('scrooloose/nerdtree')
  call minpac#add('ctrlpvim/ctrlp.vim')
  call minpac#add('vim-airline/vim-airline')
  call minpac#add('fatih/vim-go')

  packloadall
  " statusline
  " http://stackoverflow.com/questions/5375240/a-more-useful-statusline-in-vim
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*
  let g:syntastic_auto_loc_list=1
  let g:syntastic_loc_list_height=5
  set statusline=
  set statusline+=%7*\[%n]                             "buffernr
  set statusline+=%1*\ %<%F\                           "File+path
  set statusline+=%2*\ %y\                             "FileType
  set statusline+=%3*\ %{''.(&fenc!=''?&fenc:&enc).''} "Encoding
  set statusline+=%3*\ %{(&bomb?\",BOM\":\"\")}\       "Encoding2
  set statusline+=%4*\ %{&ff}\                         "FileFormat (dos/unix..)
  set statusline+=%8*\ %=\ row:%l/%L\ (%03p%%)\        "Rownumber/total (%)
  set statusline+=%9*\ col:%03c\                       "Colnr
  set statusline+=%0*\ \ %m%r%w\ %P\ \                 "Modified? Readonly? Top/bot.
  set laststatus=2


  " NERDTree
  map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
  map <leader>e :NERDTreeFind<CR>
  nmap <leader>nt :NERDTreeFind<CR>
  let NERDTreeShowBookmarks=1
  let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
  let NERDTreeChDirMode=0
  let NERDTreeQuitOnOpen=1
  let NERDTreeMouseMode=2
  let NERDTreeShowHidden=1
  let NERDTreeKeepTreeInNewTab=1
  let g:nerdtree_tabs_open_on_gui_startup=0

endif

" Generic options
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set nu
set nocompatible
set shortmess+=filmnrxoOtT      " abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
set virtualedit=onemore         " allow for cursor beyond last character
set history=1000                " Store a ton of history (default is 20)
set spell                       " spell checking on
set hidden                      " allow buffer switching without saving
set backspace=2                 " http://vim.wikia.com/wiki/Backspace_and_delete_problems

" show 80 chars limit
if exists('+colorcolumn')
  set colorcolumn=80,160
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

syntax enable
set background=dark
colorscheme default

let mapleader = ','
" fun stuff
"set list
"set listchars=tab:▸\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
"set showbreak=↪

" Automatic reloading of .vimrc
"autocmd! bufwritepost .vimrc source %

" Better copy & paste
"set pastetoggle=<F2>
"set clipboard=unnamed
" Highlight trailing white-spaces
highlight WhitespaceEOL ctermbg=Red guibg=Red
match WhitespaceEOL /\s\+$/

highlight ColorColumn ctermbg=7
