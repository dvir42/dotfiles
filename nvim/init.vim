" PLUGINS:
" {{{
call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rsi'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'yuttie/comfortable-motion.vim'
Plug 'tpope/vim-fugitive'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'w0rp/ale'
Plug 'majutsushi/tagbar'
Plug 'Shougo/echodoc.vim'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': './install.sh'
    \ }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'sebastianmarkow/deoplete-rust'
Plug 'PotatoesMaster/i3-vim-syntax'

call plug#end()
" }}}

" BASIC CONFIG:
" {{{
syntax enable
filetype plugin on
set tabstop=4 shiftwidth=4 expandtab
let mapleader=','
" }}}

" FOLDING:
" {{{
set foldenable
set foldcolumn=2
set foldmethod=marker
" }}}

" FONT:
" {{{
set encoding=utf8
set guifont=DejaVuSansMono\ Nerd\ Font\ 12
let g:airline_powerline_fonts=1
" }}}

" THEME:
" {{{
"set termguicolors
set background="dark"
colorscheme ron
hi Folded ctermbg=NONE
hi FoldColumn ctermbg=NONE
hi SignColumn ctermbg=NONE
let g:airline_theme='base16_shell'
" }}}

" COMFORTABLE MOTION:
" {{{
let g:comfortable_motion_scroll_down_key = 'j'
let g:comfortable_motion_scroll_up_key = 'k'
noremap <silent> <ScrollWheelDown> :call comfortable_motion#flick(40)<CR>
noremap <silent> <ScrollWheelUp>   :call comfortable_motion#flick(-40)<CR>
let g:comfortable_motion_no_default_key_mappings = 1
let g:comfortable_motion_impulse_multiplier = 1  " Feel free to increase/decrease this value.
nnoremap <silent> <C-d> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 2)<CR>
nnoremap <silent> <C-u> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -2)<CR>
nnoremap <silent> <C-f> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 4)<CR>
nnoremap <silent> <C-b> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -4)<CR>
" }}}

" AIRLINE:
" {{{
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#branch#enabled=1
" }}}

" NUMBERING:
" {{{
" Configure hybrid line numbers
" Relative is default, absolute is for insert mode, and non-focused
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END
" }}}

" FINDING FILES:
" {{{
set path+=**
set wildmenu
" }}}

" TAG JUMPING:
" {{{
" - Use ^] to jump to tag under cursor
" - Use g^] for ambiguous tags
" - Use ^t to jump back up the tag stack
command! MakeTags !ctags -R .
" }}}

" FILE BROWSING:
" {{{
" - :edit a folder to open a file browser
" - <CR>/v/t to open in an h-split/v-split/tab

" Tweaks for browsing
let g:netrw_banner=0		" disable annoying banner
let g:netrw_browse_split=4	" open in prior window
let g:netrw_altv=1		" open splits to the right
let g:netrw_liststyle=3		" tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
" }}}

" NERDTREE:
" {{{
map <C-n> :NERDTreeToggle<CR>
augroup NerdTreeConfig
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END
" }}}

" SNIPPETS:
" {{{

" Basic HTML template. Puts the cursor beween title tags and enter insert mode
nnoremap <leader>html :-1read $HOME/.config/nvim/snips/skeleton.html<CR>3jwf>a
" }}}

" ALE:
" {{{
let g:airline#extensions#ale#enabled=1
nmap <silent> <C-p> <Plug>(ale_previous_wrap)
nmap <silent> <C-l> <Plug>(ale_next_wrap)

let g:ale_fix_on_save=1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\   'python': ['yapf', 'isort'],
\   'rust': ['rustfmt'],
\   'haskell': ['brittany']
\ }

hi link ALEError Error
hi Warning term=underline cterm=underline ctermfg=Yellow gui=undercurl guisp=Gold
hi link ALEWarning Warning
hi link ALEInfo SpellCap
" }}}

" ECHODOC:
" {{{
set noshowmode
let g:echodoc#enable_at_startup=1
" }}}

" DEOPLETE:
" {{{
let g:deoplete#enable_at_startup=1
set completeopt-=preview

" rust:
let g:deoplete#sources#rust#racer_binary=systemlist('which racer')[0]
let g:deoplete#sources#rust#rust_source_path=systemlist('rustc --print sysroot')[0].'/lib/rustlib/src/rust/src'
" }}}

" LSP:
" {{{
let g:LanguageClient_serverCommands = { 'haskell': ['hie-wrapper'] }
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
let g:LanguageClient_rootMarkers = ['*.cabal', 'stack.yaml']
" }}}

" TAGBAR:
" {{{
nmap <F8> :TagbarToggle<CR>
" }}}

" DISABLE ARROW KEYS:
" {{{
no <down> <Nop>
no <left> <Nop>
no <right> <Nop>
no <up> <Nop>

ino <down> <Nop>
ino <left> <Nop>
ino <right> <Nop>
ino <up> <Nop>

vno <down> <Nop>
vno <left> <Nop>
vno <right> <Nop>
vno <up> <Nop>
" }}}
