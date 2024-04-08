if has('python3')
endif

" file type and syntax highlighting on
filetype plugin indent on
syntax on

imap <silent><script><expr> <S-Tab> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

" auto commands
" autocmd VimEnter * NERDTree | wincmd p
" autocmd BufReadPost *.c TagbarToggle
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
highlight ExtraWhitespace ctermbg=cyan guibg=cyan
autocmd InsertLeave * redraw!
match ExtraWhitespace /\s\+$\| \+\ze\t/
autocmd BufWritePre * :%s/\s\+$//e

" color scheme
colorscheme spacecamp
set background=dark

" sessions
noremap <F4> :NERDTreeToggle <cr>
noremap <F1> :mksession! .vim.session <cr>
noremap <F2> :source .vim.session <cr>
noremap <F3> :! rm .vim.session <cr>
noremap <F8> :TagbarToggle<cr>
nnoremap <leader>n :tabnew<cr>
nnoremap <leader>q :noh<cr>
nnoremap <leader>p :below term ipython3<cr>
nnoremap <leader>t :below terminal<cr>

let g:LanguageClient_serverCommands = {
\  'rust': ['rust-analyzer'],
\}

" Enable Jedi-vim plugin
let g:jedi#auto_initialization = 1

" Enable autocompletion
let g:jedi#completions_enabled = 1

" Use tab for autocompletion
" imap <Tab><Plugin>(jedi_vim_user_completion)

" Enable function signatures in the statusline
let g:jedi#show_call_signatures = '1'

" Virtualenv settings (optional)
let g:jedi#force_py_version = 3  " Set to 2 if you want Python 2 support
let g:jedi#use_splits_not_buffers = 'right'  " Open Jedi-vim splits to the right

" Add this to your .vimrc or init.vim
" let g:vimtex_view_method = 'zathura'
" let g:vimtex_zathura_options = '--fork --synctex-forward'

" Map keybindings to useful Jedi-vim commands
nnoremap <leader>jd :JediD goto-definition<CR>
nnoremap <leader>js :JediD show-doc<CR>

" Split the screen horizontally
nnoremap <leader>h :split<CR>

" Split the screen vertically
nnoremap <leader>v :vsplit<CR>

" Disable Lines Number
nnoremap <leader>l :set nonumber<cr>
nnoremap <leader>s :set number<cr>

" for autoread to auto load
au FocusGained,BufEnter * :silent! !
au FocusLost,WinLeave * :silent! w

" specific settings
let g:pymode_rope = 0
let g:ycm_language_server = 'clangd'
let g:ycm_clangd_binary_path = '/usr/lib/'
let g:tagbar_clang_binary = '/usr/lib/libclang.so'
let g:clang_library_path = '/usr/lib/'

set listchars=tab:>-
set fo+=t
set t_Co=256
set nocursorline
set title
set bs=2
set noautoindent
set ruler
set shortmess=aoOTI
set nocompatible
set showmode
set splitbelow
#set nomodeline
set showcmd
set showmatch
set tabstop=2
set shiftwidth=2
set expandtab
set cinoptions=(0,m1,:1
" set tw=80
set formatoptions=tcqro2
set smartindent
set laststatus=2
#set nomodeline
#set clipboard=unnamed
set softtabstop=2
#set showtabline=1
set sidescroll=5
set scrolloff=4
set hlsearch
set incsearch
set ignorecase
set smartcase
set foldmethod=marker
set ttyfast
set history=10000
set hidden
#set colorcolumn=81
set number
set complete=.,w,b,u,t
set completeopt=longest,menuone,preview
set noswapfile
set foldlevelstart=0
set wildmenu
set wildmode=list:longest,full
" "set nowrap
set wrap
set statusline=%{getcwd()}\/\%f%=%-14.(%l,%c%V%)\ %P
set autoread
set conceallevel=2
set concealcursor=vin

" backup
set undodir=~/.vim/tmp/undo//
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//

" make directories automatically if they don't already exist
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

" close brackets
:inoremap ( ()<Esc>i
" :inoremap < <><Esc>i
:inoremap { {}<Esc>i
:inoremap [ []<Esc>i
:inoremap " ""<Esc>i
:inoremap ' ''<Esc>i
:inoremap ` ``<Esc>i

" cursorline
" au WinLeave * set nocursorline
" au WinEnter * set cursorline
" set cursorline

" clang stuff
" let g:clang_library_path='/usr/lib/llvm/12/lib64/'
""let g:clang_user_options='|| exit 0'
""let g:clang_complete_auto = 0
""let g:clang_compelte_macros=1
""let g:clang_complete_copen = 0
""let g:clang_debug = 1
""let g:clang_snippets=1
""let g:clang_conceal_snippets=1
""let g:clang_snippets_engine='clang_complete'
""let g:clang_auto_select = 1
""let g:clang_use_library = 1
""let g:clang_complete_optional_args_in_snippets = 1

" jedi
let g:jedi#completions_enabled = 1
let g:jedi#force_py_version = 3

" youcompleteme
" let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'

" identLine
" let g:indentLine_char='>'
