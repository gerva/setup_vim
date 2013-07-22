" Generic options
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set nu
set paste

" Pathogen
execute pathogen#infect()
filetype plugin indent on

" NERDTree
map <C-e> :NERDTreeToggle<CR>

" Solarized dark
syntax enable
set background=dark
let g:solarized_termcolors=256
"colorscheme solarized

