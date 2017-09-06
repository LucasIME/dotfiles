filetype indent plugin on " load filetype-specific indent files

call plug#begin()
Plug 'vim-scripts/lastpos.vim' " Goes back to last position you were when opening a file again
Plug 'leafgarland/typescript-vim' " suport for typescript
Plug 'bling/vim-airline' " Cool line on the bottom
Plug 'elzr/vim-json' " Json syntax highlighting 
Plug 'scrooloose/nerdtree' " Tree explorer
Plug 'dracula/vim' " Vim dracula colorscheme
call plug#end()

color dracula

syntax enable 
set tabstop=4 " number of visual spaces per TAB
set softtabstop=4 " number of spaces in tab when editing (backspace delete 4 spaces)
set shiftwidth=4 " affect what happens when you press >>, << or ==. Also affect how automatic indentation works
set expandtab " tabs are spaces
set smarttab " Uses shiftwidth instead of tabstop at start of lines
set number " show line numbers
set showcmd " show command in bottom bar
set wildmenu " visual autocomplete for command menu
set lazyredraw " redraw only when need to
set showmatch " highlight matching [{()}]
set incsearch " search as characters are entered
set hlsearch " highlight matches
set confirm "Instade of failing a command because of unsaved changes, raise a dialogue asking if you with to save changed files
set ruler " Display the cursor position on the last line of the screen or in the status line of a window
set autoindent " Copy the indentation from the previous line when starting a new one
set smartindent " Automatically inserts one extra level of indentation in some cases
set ignorecase " Ignore case when searching
set smartcase " If the pattern contains an uppercase, search is case sensitve. It is case insensitive, otherwise
set nostartofline " Keeps cursor on same column when line is changed due to command
set laststatus=2 " Always show status line on window
set cmdheight=2 " number of screen lines for the command line
set backspace=indent,eol,start " allows backspacing over autoindent, line breaks (join lines) and over the start of insert
set hidden " Hide buffers when they are abandoned
set clipboard=unnamed " Use Windows clipboard
set noswapfile " no swap file, duh
map @ :NERDTreeToggle<CR> " @ as Shortcut to NERD Tree
