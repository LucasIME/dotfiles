filetype indent plugin on " load filetype-specific indent files

syntax enable 
set tabstop=4 " number of visual spaces per TAB
set softtabstop=4 " number of spaces in tab when editing (backspace delete 4 spaces)
set shiftwidth=4 " affect what happens when you press >>, << or ==. Also affect how automatic indentation works
set expandtab " tabs are spaces
set smarttab " Uses shiftwidth instead of tabstop at start of lines
set number " show line numbers
set showcmd " show command in bottom bar
set cursorline " highlight current line
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

