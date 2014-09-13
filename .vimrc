syntax on
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()
runtime! macros/matchit.vim

set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent
set number
set expandtab
set autoread
set incsearch
set smartcase
set linebreak
set clipboard=unnamed
set encoding=utf-8
set winwidth=79 winheight=5 winminheight=5 winheight=999
set splitbelow splitright
set laststatus=2

Plugin 'Lokaltog/vim-easymotion'
Plugin 'epmatsw/ag.vim'
Plugin 'gmarik/vundle'
Plugin 'godlygeek/tabular'
Plugin 'mattn/gist-vim'
Plugin 'mattn/webapi-vim'
Plugin 'scrooloose/nerdtree'
Plugin 'sjl/gundo.vim'
Plugin 'tjennings/git-grep-vim'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-ragtag'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'vim-ruby/vim-ruby'
Plugin 'groenewege/vim-less'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'mattn/emmet-vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'mxw/vim-jsx'
Plugin 'briancollins/vim-jst'
Plugin 'bling/vim-airline'
Plugin 'b2l/molokai'
Plugin 'scrooloose/syntastic'

filetype plugin indent on
set wildignore+=*~,*#,public/assets/**

" Run a given vim command on the results of fuzzy selecting from a given shell
" command. See usage below.
function! SelectaCommand(choice_command, selecta_args, vim_command)
  try
    silent let selection = system(a:choice_command . " | selecta " . a:selecta_args)
  catch /Vim:Interrupt/
    " Swallow the ^C so that the redraw below happens; otherwise there will be
    " leftovers from selecta on the screen
    redraw!
    return
  endtry
  redraw!
  exec a:vim_command . " " . selection
endfunction
" Find all files in all non-dot directories starting in the working directory.
" Fuzzy select one of those. Open the selected file with :e.
nnoremap <C-p> :call SelectaCommand("find * -type f", "", ":e")<cr>

" CtrlP
"let g:ctrlp_max_files = 10000
"let g:ctrlp_user_command = { 'types': { 1: ['.git/', 'cd %s && git ls-files'] }, 'fallback': 'find %s -type f | head -' . g:ctrlp_max_files }

" Go stuff
autocmd FileType go match ErrorMsg //
autocmd FileType go set makeprg=go\ build

" Set colorscheme
" colorscheme sexy-railscasts-256 " desert256

" Autocommands
autocmd BufWritePre *.rb,*.js,*.erb,*.feature %substitute/ / /ge " Remove nbsp
autocmd User Rails silent! Rlcd " Rails plugin
" autocmd BufRead,BufNewFile *.txt set filetype=markdown
autocmd BufEnter,BufWinEnter,CursorHold * :checktime

" Highlight tabs and trailing whitespace (except on end of line)
match ErrorMsg /\s\+\%#\@<!$\|\t\+/
autocmd InsertLeave * redraw!

" REST OF FILE CONTAINS MAPPINGS
let mapleader = " "

" Vertical split to alternative file
map <C-w>t <C-w>v<C-w>l:A<CR>
nmap <Leader>- :sp<CR>
nmap <Leader>= :vsp<CR>

nmap Q <Nop>
nmap K <Nop>

" Navigate splits
map <C-h> <C-w>h
map <C-l> <C-w>l
map <C-k> <C-w>k
map <C-j> <C-w>j

" cnext/prev
map <Left> :bprevious<CR>
map <Right> :bnext<CR>
map <Up> :cprevious<CR>
map <Down> :cnext<CR>
map <S-Up> :cpfile<CR>
map <S-Down> :cnfile<CR>

" save w/ ctrl-s
map <C-s> :write<CR>
imap <C-s> <Esc>:write<CR>i

" Copy current file and line number to unnamed register ("")
nmap <Leader>l Os rspec <Esc>"%pA:<C-R>=line(".")<CR><Esc>0d$"uu

" vim-commentary
xmap ,,  \\
nmap ,,  \\
nmap ,,, \\\

" ZenCoding
let g:user_zen_expandabbr_key = '<c-e>'

" NERDTree
map <silent> <Leader>n :NERDTreeToggle<CR>

" Remap jump to tag
map <silent> å <C-]>

" Delete trailing space
map <silent> <Leader>s m`:%s/\s\+$//<CR>``

" Command mode
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-F> <Right>
cnoremap <C-G> <C-F>
cnoremap <C-B> <Left>
cnoremap <C-D> <Del>
cnoremap <C-K> <C-E><C-U>

" Underline with = / - with F5 / F6
nnoremap gmu yyp<c-v>$r-:redraw!<CR>
nnoremap gmU yyp<c-v>$r=:redraw!<CR>

" Tab switching
nmap <Tab> :tabn<CR>
nmap <S-Tab> :tabp<CR>
nmap <C-t> :tabnew<CR>

colorscheme molokai
let g:airline_theme = 'molokai'