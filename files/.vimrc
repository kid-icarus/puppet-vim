set nocompatible
set t_Co=256
set encoding=utf-8
set fileencoding=utf-8
call pathogen#infect()
set comments=sr:/**,m:*\ ,ex:*/,://

"Enable filetypes
filetype on
filetype plugin on
filetype indent on
syntax on

"Enable code folding
set foldenable
set foldmethod=indent
set foldlevelstart=99

" Set colorscheme
colorscheme solarized
hi Normal ctermbg=NONE

"call togglebg#map("<F5>")
" Mapping to switch light/dark background
nnoremap ]g :ToggleBG<CR>

"Write the old file out when switching between files.
set autowrite

"Display current cursor position in lower right corner.
set ruler

"Ever notice a slight lag after typing the leader key + command? This lowers
"the timeout.
set timeoutlen=500

"Switch between buffers without saving
set hidden

"Tab stuff
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
au FileType python setlocal tabstop=8 expandtab shiftwidth=4 softtabstop=4

"Show command in bottom right portion of the screen
set showcmd

"Show line numbers
set number

"Indent stuff
set smartindent
set autoindent

"Always show the status line
set laststatus=2

"Prefer a slightly higher line height
set linespace=3

"Better line wrapping
set wrap
set textwidth=79
set formatoptions=qrn1

"Set incremental searching"
set incsearch

"Highlight searching
set hlsearch

" case insensitive search
set ignorecase
set smartcase

"Hard-wrap paragraphs of text
nnoremap <leader>q gqip


"Session settings
set sessionoptions=resize,winpos,winsize,buffers,tabpages,folds,curdir,help

"Set up an HTML5 template for all new .html files
"autocmd BufNewFile * silent! 0r $VIMHOME/templates/%:e.tpl

"Load the current buffer in Firefox - Mac specific.
abbrev ff :! open -a firefox.app %:p<cr>

"Saves time; maps the spacebar to colon
nnoremap <space> :

"Map escape key to jj -- much faster
inoremap jk <esc>

"Delete all buffers (via Derek Wyatt)
nnoremap <silent> <leader>da :exec "1," . bufnr('$') . "bd"<cr>

" Snipmate
"For autocompletion of Snipmate plugin
let g:acp_behaviorSnipmateLength = 1
:filetype plugin on

" Yank text to the OS X clipboard
set clipboard=unnamed
noremap <leader>y "+y
noremap <leader>yy "+yy

" Preserve indentation while pasting text from the OS X clipboard
noremap <leader>p :set paste<CR>:put *<CR>:set nopaste<CR>

" Use Return key to clear search highlighting
nmap <CR> :nohlsearch<CR>
autocmd BufReadPost quickfix nmap <buffer> <CR> <CR>

"set t_Co=256
set backspace=2 "

" Random stuff
set colorcolumn=80

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
 
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

" Write/quit aliases
:command WQ wq
:command Wq wq
:command W w
:command Q q


" fun learning
inoremap <c-u> <esc>viWUEa
nnoremap <c-u> viWUEa
nnoremap <leader>ev :vsp $VIMRC
nnoremap <leader>es :source $VIMRC

" Plugin Config 

" Syntastic
let g:syntastic_error_symbol="💩"
let g:syntastic_style_error_symbol="🍔"
let g:syntastic_php_checkers=['php', 'phpcs', 'phpmd']
"let g:syntastic_javascript_checkers=['jshint']
"let g:syntastic_php_phpcs_args='--standard=Drupal'

" VDebug
" let g:vdebug_options['break_on_open'] = 0
"let g:vdebug_options['path_maps'] = {"/var/www/html": "/Users/ryankois/Sites/jaars.dev/jaars"}

" Signify
"let g:signify_sign_overwrite = 0

" Blockify
let g:blockify_pairs = { 'php': [ '{', '}' ] }

" Delimate settings
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1

" Powerline
" A fancy status bar
let g:Powerline_symbols = 'fancy'

