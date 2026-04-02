filetype indent plugin on " load filetype-specific indent files

syntax enable
set nocompatible "be iMproved
set showmode " Show current mode (Insert, Visual, etc...)
set encoding=utf8
set expandtab " tabs are spaces
set smarttab " Uses shiftwidth instead of tabstop at start of lines
set number " show line numbers
set relativenumber " show other line numbers relative to where the cursor is
set showcmd " show command in bottom bar
set wildmenu " visual autocomplete for command menu
set lazyredraw " redraw only when need to
set showmatch " highlight matching [{()}]
set incsearch " search as characters are entered
set hlsearch " highlight matches
set confirm "Instead of failing a command because of unsaved changes, raise a dialogue asking if you with to save changed files
set ruler " Display the cursor position on the last line of the screen or in the status line of a window
set autoindent " Copy the indentation from the previous line when starting a new one
set smartindent " Automatically inserts one extra level of indentation in some cases
set copyindent " Copy the previous indentation on autoindenting
set ignorecase " Ignore case when searching
set smartcase " If the pattern contains an uppercase, search is case sensitive. It is case insensitive, otherwise
set nostartofline " Keeps cursor on same column when line is changed due to command
set laststatus=2 " Always show status line on window
set cmdheight=2 " number of screen lines for the command line
set backspace=indent,eol,start " allows backspacing over autoindent, line breaks (join lines) and over the start of insert
set hidden " Hide buffers when they are abandoned
set clipboard^=unnamed,unnamedplus " Use system clipboard
set noswapfile " no swap file, duh
set scrolloff=10 " minimal number of screen lines to keep above and below the cursor
set t_Co=256 " 256 colors
set display+=uhex " display hex codes for non printable characters
set shortmess-=S " display number of matches up to 99 when searching something
set visualbell " visual bell rather than beeping
set list " show EOL sign, trailing spaces, etc...
hi Visual cterm=none ctermbg=darkgrey ctermfg=cyan " Make visual selection readable
set cursorline " Show which line your cursor is on
match ErrorMsg '\s\+$'

" Remaps
map @ :NERDTreeToggle<CR> " @ as Shortcut to NERD Tree
map <C-_> <Plug>NERDCommenterToggle
nnoremap <C-p> :Files<cr>

set rtp+=/usr/local/opt/fzf
