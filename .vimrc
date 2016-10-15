" Yo. This is my .vimrc. I don't know what I'm doing, but I'm learning.
"
" Packages that I've installed:
"   Pathogen package manager
"   vim-ruby    for improving ruby-specific tags
"   vroom       for running ruby minitest



"--------------------------------------------------
"   Pathogen plugin manager
"--------------------------------------------------
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
" Pathogen needs syntax highlighting and autoindentation enabled, but this is done elsewhere.



"--------------------------------------------------
"     Basic mappings
"--------------------------------------------------
" Remap the keader to something very accessible
map <Space> <leader>

" save the current file
map ,w :w<CR>
inoremap ,w <Esc>:w<CR>

" exit insert mode
inoremap jk <Esc>
inoremap kj <Esc>

" exit insert mode and save
inoremap lj <Esc>:w<CR>

" ,l toggle linenumbers
map ,l :setlocal nu!<CR>

" Switch between split windows
nnoremap <C-h> <C-w><C-h>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>

" Map Alt to switch between tabs
" TMux can't distinguish between Ctrl and Ctrl+Shift.
" GNOME terminal sends Alt as ^[
" Vim responds to ^[ as <Esc>
nnoremap <Esc>h :tabp<CR>
nnoremap <Esc>l :tabn<CR>
nnoremap <Esc>t :tabnew<CR>

" Resize split windows
map ,< <C-w><
map ,> <C-w>>
map ,- <C-w>-
map ,+ <C-w>+

" Undo
inoremap <C-z> <Esc>ui

" copy from cursor to end of line
map Y y$

" copy to system clipboard
map ,yy "+yy
map ,Y "+Y
map ,yw "+yw
vmap ,y "+y

" paste from system clipboard
map ,p :set paste<CR>"+p:set nopaste<CR>

" paste in Insert mode
inoremap <C-v> <C-o>p

" highlight the current word instead of the next one
noremap * *N



"--------------------------------------------------
"     Persistent Macros
" Type the macro in vim.
" The actual key sequence can be accessed using
" insert mode: <C-r><C-r><macro_key>
" This inserts the contents of a register literaly.
" See :h i_CTRL-R
"--------------------------------------------------
" insert fprintf
nnoremap ,f ofprintf(stderr, "\n");F\i
nnoremap ,F Ofprintf(stderr, "\n");F\i

" Reindent comments and prepend a space
map ,x \x\xI l

" Surround a line with curly braces
nnoremap ,{ O{jo}k

" Surround a line with curly braces and indent it
nnoremap ,} O{jo}k>>

" Insert header guard
nnoremap ,h i#ifndef _INCLUDED#define _INCLUDED#endif^3kf_



"--------------------------------------------------
"     Shell commands
"--------------------------------------------------
" Run rake from vim directory
nnoremap <Space>r :!clear; rake<CR>

" Figure out how to make this run silently and fail gracefully
" nnoremap <Space>fm :silent !cyberdata_make_flash<CR>



"--------------------------------------------------
"   Colors
"--------------------------------------------------
"colorscheme molokai    " This doesn't work properly :(
"colorscheme slate      " This doesn't change the color of C code that is
"commented out.
colorscheme default


"--------------------------------------------------
"   Tabs
"--------------------------------------------------
set expandtab       " use spaces instead of tabs
set tabstop=4       " number of spaces for a tab
set shiftwidth=4    " number of spaces for autoindent



"--------------------------------------------------
"   Search
"--------------------------------------------------
set hlsearch                " Highlight /pattern search results
set smartcase               " Do smart case search
nnoremap <CR> :noh<CR><CR>  " Remove search highlighting by unsetting the 'last search pattern' register.



"--------------------------------------------------
"   Auto indentation
"--------------------------------------------------
set autoindent
syntax on
filetype plugin indent on



"--------------------------------------------------
"   Folding
"--------------------------------------------------
set foldmethod=indent
" set foreground color for folds
hi Folded ctermfg=2
" set background color for folds to 8, which is undefined? It uses the terminal background color
hi Folded ctermbg=8



"--------------------------------------------------
"   Screen settings
"--------------------------------------------------
set laststatus=2    " Always display the status bar.
set display+=lastline           " don't display a bunch of @'s for long lines at end of screen
set scrolloff=1                 " scroll n lines before the end of the screen



"--------------------------------------------------
"   Buffers
"--------------------------------------------------
" start the buffer explorer
" QuickBuf
map ,b <F4>

" BufExplorer
"map ,b :BufExplorer<CR>

" quit the current buffer (closes all instances of this buffer)
map ,q :bd<CR>

" close the current buffer (close this single instance of the buffer)
map ,c :clo<CR>



"--------------------------------------------------
"   Explorer
"--------------------------------------------------
" open the Explorer
map ,e :Explore<CR>
" map ,e :EditVifm<CR>:only<CR>

" open the Explorer in a vertical split
map ,ve :Vex<CR>

" open the Explorer in a horizontal split
map ,he :Sex<CR>



"--------------------------------------------------
"   vroom plugin for running ruby minitest
"--------------------------------------------------
let g:vroom_use_colors = 1
imap <leader>r <Esc><leader>r



"--------------------------------------------------
"   Enhanced Commentify
"--------------------------------------------------
let g:EnhCommentifyFirstLineMode = 'Yes'
let g:EnhCommentifyRespectIndent = 'Yes'
let g:EnhCommentifyUseBlockIndent = 'Yes'
let g:EnhCommentifyPretty='Yes'



"--------------------------------------------------
"   TMux Navigator
"--------------------------------------------------
let g:tmux_navigator_no_mappings = 1

" Map Alt to TMux Navigator because
" TMux can't distinguish between Ctrl and Ctrl+Shift.
" GNOME terminal sends Alt as ^[
" Vim responds to ^[ as <Esc>
"Lately I've been using vim in a devoted tmux window so I don't need to switch
"in this fashion. I've remapped Alt to navigate between Vim tabs.
"nnoremap <silent> <Esc>h :TmuxNavigateLeft<cr>
"nnoremap <silent> <Esc>j :TmuxNavigateDown<cr>
"nnoremap <silent> <Esc>k :TmuxNavigateUp<cr>
"nnoremap <silent> <Esc>l :TmuxNavigateRight<cr>
"nnoremap <silent> <Esc>p :TmuxNavigatePrevious<cr>



"--------------------------------------------------
"   CScope
"--------------------------------------------------
" Careful, this path is hard-coded!
cmap cs0 :cs add /home/kmatthews/source/uClinux-dist.2009/user/cyberdata/sip_devices/cscope.out
" cmap cs9 :cs add /home/kmatthews/source/uClinux-dist.2009/user/cyberdata/intercom/cscope.out

" These are the bare minimum key mappings
nnoremap <leader>fa :call cscope#findInteractive(expand('<cword>'))<CR>
"nnoremap <leader>l :call ToggleLocationList()<CR>
nnoremap <leader>t :call ToggleLocationList()<CR>

" Some optional key mappings to search directly.

" s: Find this C symbol
nnoremap  <leader>fs :call cscope#find('s', expand('<cword>'))<CR>
" g: Find this definition
nnoremap  <leader>fg :call cscope#find('g', expand('<cword>'))<CR>
" d: Find functions called by this function
nnoremap  <leader>fd :call cscope#find('d', expand('<cword>'))<CR>
" c: Find functions calling this function
nnoremap  <leader>fc :call cscope#find('c', expand('<cword>'))<CR>
" t: Find this text string
nnoremap  <leader>ft :call cscope#find('t', expand('<cword>'))<CR>
" e: Find this egrep pattern
nnoremap  <leader>fe :call cscope#find('e', expand('<cword>'))<CR>
" f: Find this file
nnoremap  <leader>ff :call cscope#find('f', expand('<cword>'))<CR>
" i: Find files #including this file
nnoremap  <leader>fi :call cscope#find('i', expand('<cword>'))<CR>
