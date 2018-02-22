"font: https://github.com/be5invis/Iosevka
"use NerdFonts
"may have to use 'term' version to avoid '=' overlapping characters
"Part of this file is shamelessly stolen from Greg 'wincent' Hurrell
"lots of ideas for plugins came zhranklin's init
"https://github.com/zhranklin/init.vim/blob/master/files/.config/nvim/init.vim
"done to 100th line
"
"http://coderoncode.com/tools/2017/04/16/vim-the-perfect-ide.html
"not started
set background=dark

"set spell spelllang=en_us
set nocompatible
set spell spelllang=pl
set encoding=utf8

set autoindent                        " maintain indent of current line
set backspace=indent,start,eol        " allow unrestricted backspacing in insert mode

if exists('&belloff')
  set belloff=all                     " never ring the bell for any reason
endif

"backup files
if exists('$SUDO_USER')
  set nobackup                        " don't create root-owned files
  set nowritebackup                   " don't create root-owned files
else
  set backupdir=~/.vim/tmp/backup//    " keep backup files out of the way
endif

"swap
if exists('$SUDO_USER')
  set noswapfile                      " don't create root-owned files
else
  set directory=~/.vim/tmp/swap//    " keep swap files out of the way
endif

"persistent undo files and turn on
if has('persistent_undo')
  if exists('$SUDO_USER')
    set noundofile                    " don't create root-owned files
  else
    set undodir=~/.vim/tmp/undo//      " keep undo files out of the way
    set undofile                      " actually use undo files
  endif
endif

"folding method and sign
if has('folding')
  if has('windows')
    set fillchars=vert:┃              " BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
  endif
  set foldmethod=indent               " not as cool as syntax, but faster
  set foldlevelstart=99               " start unfolded
endif

set formatoptions+=n                  " smart auto-indenting inside numbered lists

if exists('&inccommand')
  set inccommand=split                " live preview of :s results
endif

set laststatus=2                      " always show status line

if has('linebreak')
  set linebreak                       " wrap long lines at characters in 'breakat'
endif

set nojoinspaces                      " don't autoinsert two spaces after '.', '?', '!' for join command

set number                            " show line numbers in gutter

set scrolloff=3                       " start scrolling 3 lines before edge of viewport
set shiftround                        " always indent by multiple of shiftwidth
set shiftwidth=2                      " spaces per tab (when shifting)
set shortmess+=A                      " ignore annoying swapfile messages
set shortmess+=I                      " no splash screen
set shortmess+=O                      " file-read message overwrites previous

set sidescrolloff=3                   " same as scrolloff, but for columns
set smarttab                          " <tab>/<BS> indent/dedent in leading whitespace

if has('windows')
  set splitbelow                      " open horizontal splits below current window
endif

if has('vertsplit')
  set splitright                      " open vertical splits to the right of the current window
endif

if exists('&swapsync')
  set swapsync=                       " let OS sync swapfiles lazily
endif
set switchbuf=usetab                  " try to reuse windows/tabs when switching buffers

set tabstop=4                         " spaces per tab
set softtabstop=4 "unifying
set shiftwidth=4 "indent/outdent by 4 columns
set shiftround            " always indent/outdent to the nearest tabstop
set expandtab                         " always use spaces instead of tabs

set textwidth=80                      " automatically hard wrap at 80 columns

set updatecount=80                    " update swapfiles every 80 typed chars
set updatetime=2000                   " same as YCM

set ignorecase        "ignore the case when search texts
set smartcase         "if searching text contains uppercase case will not be ignored

if (has("nvim"))
    """For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
   let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"I guess only this termguicolors one is critical
if (has("termguicolors"))
    set termguicolors
endif

syntax on
filetype plugin on		"needed for NERDcommenter

let mapleader = ","
let maplocalleader = "\\" "it's a single slash ofc


"plugin manager
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'	"airline
Plug 'iCyMind/NeoSolarized'	"colorscheme #1
Plug 'morhetz/gruvbox' "colorscheme #2
Plug 'vim-airline/vim-airline-themes' "color theme for airline
Plug 'scrooloose/nerdtree'	"NERDtree
Plug 'Xuyuanp/nerdtree-git-plugin' "git flags for NERDtree
Plug 'airblade/vim-gitgutter'	"shows if the line was added, deleted etc
Plug 'tpope/vim-surround'	"surround changer
Plug 'wellle/targets.vim'	"getting ci( to work as I want it to work
Plug 'tpope/vim-repeat'   "repeating the unrepeatable
Plug 'tpope/vim-obsession' "session keeper
Plug 'lervag/vimtex'        "yet another latex plugin
Plug 'w0rp/ale'  "async linter
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } "deoplete completion plugin
Plug 'zchee/deoplete-jedi' "deoplete library for Python
Plug 'zchee/deoplete-clang' "deoplete c/c++ library
Plug 'Shougo/neoinclude.vim' "c/c++ include deoplete lib, UNTESTED
Plug 'SirVer/ultisnips' "snippets engine
Plug 'honza/vim-snippets' "snippets library
Plug 'ludovicchabant/vim-gutentags' "ctags
Plug 'ryanoasis/vim-devicons' "cool glyphs MUST COME AFTER SUPPORTED PLUGINS
Plug 'christoomey/vim-tmux-navigator' "same keybindings for vim and tmux panes
Plug 'edkolev/tmuxline.vim' "tmux line theme match nvim
call plug#end()

colorscheme gruvbox    "chooses theme
"let g:airline_theme='solarized'	"chooses theme for airline
let g:deoplete#enable_at_startup = 1	"enables deoplete
let g:deoplete#enable_smart_case = 1  "smart-case deoplete
autocmd CompleteDone * pclose!  "close preview window after compl is done

set guicursor=n:blinkon1      "trying to get the coursor to stop blinking
let g:tex_flavor='latex'

"UltiSnips conf
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

let g:vimtex_complete_close_braces=1

if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
endif
let g:deoplete#omni#input_patterns.tex = g:vimtex#re#deoplete







" new
" NERDTree conf
" open NT
nnoremap <Leader>f :NERDTreeToggle<Enter> " toggle
nnoremap <silent> <Leader>v :NERDTreeFind<CR> " open on file
"map <C-n> :NERDTreeToggle<CR>

"quit on opening a file
let NERDTreeQuitOnOpen = 1

"auto delete buffer if file deleted with NT
let NERDTreeAutoDeleteBuffer = 1

"off annoying msg on top"
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

"close if NT is last buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"glyphs for airline
let g:airline_powerline_fonts = 1


"ALE config
let g:ale_lint_on_text_changed = 'never' "do not run linters on text change, only save

nnoremap <space>n :lnext<CR>
nnoremap <space>p :lprevious<CR>
nnoremap <space>r :lrewind<CR>

" LaTeX linters:
" lacheck
" chktex
" RedPen (???)


" gutentags
" use Universal Ctags
" https://askubuntu.com/questions/796408/installing-and-using-universal-ctags-instead-of-exuberant-ctags


"deoplete
" let g:deoplete#sources#jedi#server_timeout = 100
" /usr/lib/llvm-4.0/lib/libclang.so
" find with: find / -name libclang.so
let g:deoplete#sources#clang#libclang_path = '/usr/lib/llvm-4.0/lib/libclang.so'
let g:deoplete#sources#clang#clang_header = '/usr/lib/clang'
