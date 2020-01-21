filetype indent plugin on " load filetype-specific indent files

" Auto install vim-plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'vim-scripts/lastpos.vim' " Goes back to last position you were when opening a file again
Plug 'sheerun/vim-polyglot' " Syntax highlight for many different languages
Plug 'leafgarland/typescript-vim' " suport for typescript
Plug 'bling/vim-airline' " Cool line on the bottom
Plug 'elzr/vim-json' " Json syntax highlighting
Plug 'scrooloose/nerdtree' " Tree explorer
Plug 'airblade/vim-gitgutter' " Shows git diff on line
Plug 'w0rp/ale' " Asynchronous linting
Plug 'flazz/vim-colorschemes' " Numerous colorschemes
Plug 'ryanoasis/vim-devicons' " Icons
Plug 'wincent/terminus' " Enhance terminal integration with vim
Plug 'Valloric/YouCompleteMe' " Autocomplete plugin
Plug 'fatih/vim-go' " Go development plugin
Plug 'junegunn/fzf.vim' " fzf plugin
Plug 'christoomey/vim-tmux-navigator' " tmux and vim integration
Plug 'rust-lang/rust.vim' " Rust development plugin
Plug 'racer-rust/vim-racer' " Rust autocomplete
call plug#end() " All of your plugins must be added before this line

" Code for randomly chosing between different colorschemes on startup
" let schemes = 'dracula vimbrant sean maroloccio3 Tomorrow-Night-Eighties'
" let seconds = str2nr(strftime('%S'))
" execute 'colorscheme '.split(schemes)[seconds%4]
" redraw

syntax enable
set nocompatible "be iMproved
set showmode " Show current mode (Insert, Visual, etc...)
set encoding=utf8
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
set confirm "Instead of failing a command because of unsaved changes, raise a dialogue asking if you with to save changed files
set ruler " Display the cursor position on the last line of the screen or in the status line of a window
set autoindent " Copy the indentation from the previous line when starting a new one
set smartindent " Automatically inserts one extra level of indentation in some cases
set ignorecase " Ignore case when searching
set smartcase " If the pattern contains an uppercase, search is case sensitive. It is case insensitive, otherwise
set nostartofline " Keeps cursor on same column when line is changed due to command
set laststatus=2 " Always show status line on window
set cmdheight=2 " number of screen lines for the command line
set backspace=indent,eol,start " allows backspacing over autoindent, line breaks (join lines) and over the start of insert
set hidden " Hide buffers when they are abandoned
set clipboard=unnamed " Use Windows clipboard
set noswapfile " no swap file, duh
set scrolloff=9 " start scrolling before end is reached
set t_Co=256 " 256 colors
set display+=uhex " display hex codes for non printable characters
match ErrorMsg '\s\+$'
map @ :NERDTreeToggle<CR> " @ as Shortcut to NERD Tree
let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py' " Youcompleteme fix for cpp
let g:ycm_autoclose_preview_window_after_completion = 1 " Auto close preview window

set rtp+=/usr/local/opt/fzf
