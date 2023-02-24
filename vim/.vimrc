" ===============================================================================
" Info
"   leader: default is `\`, detailed with `:help <leader>``
" ===============================================================================


" ===============================================================================
" General Configuration
" ===============================================================================

set nocompatible  " Use the vim's keyboard setting, not vi

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

set nu  " Set the line number
syntax on  " Syntax highlighting
"set autochdir  " Set the current dir as thr work dir
filetype on  " File type detection
filetype plugin on  " Loading the plugin files for specific file types
filetype indent on  " Loading the indent file for specific file types with
set showcmd
set laststatus=2        " Show the status line at the bottom
set mouse+=a            " A necessary evil, mouse support
set noerrorbells visualbell t_vb=    "Disable annoying error noises
set splitbelow          " Open new vertical split bottom
set splitright          " Open new horizontal splits right
set linebreak           " Have lines wrap instead of continue off-screen
set scrolloff=15        " Keep cursor in approximately the middle of the screen
set updatetime=100      " Some plugins require fast updatetime
set ttyfast             " Improve redrawing
set shortmess-=S        " Show current match position

" Tab and Indent
""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set expandtab  " Use the space to instead of tab
set autoindent  " Copy indent from current line when starting a new line
set smartindent
set cindent
autocmd Filetype c setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd Filetype javascript setlocal tabstop=2 softtabstop=2 shiftwidth=2

" Seach and Match
"""""""""""""""""""""""""""""""""""""""""
set hlsearch  " Highlight the search result
set incsearch  " Real-time search
set ignorecase
set smartcase  " Make case sensitive when there is uppercase
set showmatch  " When a bracket is inserted, briefly jump to the matching one
" Turn off search highlight
vnoremap <C-h> :nohlsearch<cr>
nnoremap <C-h> :nohlsearch<cr>
" <C-l>: quick temp disable hlsearch
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
set wildignore+=*/.git/*,*/tmp/*,*.swp


" Undo
"""""""""""""""""""""""""
set undofile
set undodir=~/.vim/undodir

" Folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
" space open/closes folds
" nnoremap <space> za
set foldmethod=indent   " fold based on indent level
" This is especially useful for me since I spend my days in Python.
" Other acceptable values are marker, manual, expr, syntax, diff.
" Run :help foldmethod to find out what each of those do.
" " Folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
" space open/closes folds
" nnoremap <space> za
set foldmethod=indent   " fold based on indent level
" This is especially useful for me since I spend my days in Python.
" Other acceptable values are marker, manual, expr, syntax, diff.
" Run :help foldmethod to find out what each of those do.

" Movement
"""""""""""""""""""""""""
"hightlight last inserted text
nnoremap gV `[v`]

" Jump to head and end of line
map H ^
map L $

" indents
vnoremap <Tab> >
vnoremap <S-Tab> <


" Display
"""""""""""""""""""""""""
set showmode  " Show the current mode
set t_Co=256  " If under tty, use 256

" Display tab and trail space
set list
set listchars=tab:>-,trail:.
" Not display above list
nmap <leader>l :set list!<CR>


" Other
set nobackup
set fileencodings=utf-8,gb18030,cp936,big5 " Set the encode
" set pastetoggle=<F10>  " Bind `F10` to `:set paste`
set pastetoggle=<leader>p
set backspace=indent,eol,start
nmap Q <Nop>
" Q in normal mode enters Ex mode. You almost never want this.

" Press `shift` while selecting with the mouse can disable into visual mode
" In mac os, hold `alt/option` is easier
" ref: http://stackoverflow.com/questions/4608161/copy-text-out-of-vim-with-set-mouse-a-enabled
"set mouse=a  " Enable mouse

set foldmethod=indent  " The kind of folding used for the current window
set foldlevel=99



" -------------------------------------------------------------------------------
" Enhanced
" -------------------------------------------------------------------------------

au BufRead,BufNewFile *.md set filetype=markdown  " .md default is modula2

" Execute python file being edited with <Shift> + e:
map <buffer> <S-e> :w<CR>:!/usr/bin/env python % <CR>

" Auto add head info
" .py file auto add header
function HeaderPython()
    call setline(1, "#!/usr/bin/env python")
    call append(1,  "# -*- coding: utf-8 -*-")
    call append(2,  "# Vegeka @ " . strftime('%Y-%m-%d', localtime()))
    normal G
    normal o
endf
autocmd bufnewfile *.py call HeaderPython()

" .sh file auto add header
function HeaderBash()
    call setline(1, "#!/bin/bash")
    call append(1,  "# Vegeka @ " . strftime('%Y-%m-%d', localtime()))
    normal G
    normal o
endf
autocmd bufnewfile *.sh call HeaderBash()

" ref: http://stackoverflow.com/questions/158968/changing-vim-indentation-behavior-by-file-type
" autocmd FileType html set shiftwidth=2|set expandtab
" autocmd FileType htmljinja setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
" autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
" autocmd FileType css setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
" autocmd Filetype javascript setlocal ts=2 sts=2 sw=2 expandtab
" autocmd FileType sh setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab
" autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab
" autocmd FileType vim setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
"


" enable quick jump between keyword, such as if/endif
runtime macros/matchit.vim

" quick expand current active file's directory (not work directory)
" use `%%' to auto expand instead of `%:h<Tab>'
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" -------------------------------------------------------------------------------
" Custom key binds
" -------------------------------------------------------------------------------

let mapleader=" "

" <Esc> remap
inoremap jj <Esc>
inoremap jk <Esc>

" quick save
nmap <Leader><Leader>w :w<CR>
nmap <Leader><Leader>q :q<CR>
nmap <Leader><Leader>wq :wq<CR>
nmap <Leader><Leader>Q :q!<CR>


" ------------------------------------------------------------------------------
" # Autocommands
" ------------------------------------------------------------------------------

" Prevent accidental writes to buffers that shouldn't be edited
autocmd BufRead *.orig set readonly
autocmd BufRead *.bk set readonly

" Jump to last edit position on opening file
if has("autocmd")
  " https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
  au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Help filetype detection
autocmd BufRead *.plot set filetype=gnuplot
autocmd BufRead *.md set filetype=markdown
autocmd BufRead *.tex set filetype=tex
autocmd BufRead *.rss set filetype=xml

" -------------------------------------------------------------------------------
" Platform
" -------------------------------------------------------------------------------
" ref: https://unix.stackexchange.com/a/253202/45725
let g:platform = 0
let g:distro = 0
if filereadable("/etc/gentoo-release")
    let g:platform="Linux"
    let g:distro="Gentoo"
elseif filereadable("/etc/debian_version")
    let g:platform="Linux"
    let g:distro="Debian"
elseif has('mac')
    let g:platform="Darwin"
    let g:distro="OS X"
else
    let g:platform="Unknown"
endif


" ===============================================================================
" Plug Configuration
" ===============================================================================

call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

" Display
"Plugin 'Lokaltog/vim-powerline'  " newer powerline is https://github.com/powerline/powerline
" Plug 'vim-airline/vim-airline'
Plug 'itchyny/lightline.vim'          " Better Status Bar
Plug 'mhinz/vim-startify'             " Better start screen
Plug 'kien/rainbow_parentheses.vim'
Plug 'Yggdroot/indentLine'
" Note vim-colorschemes will cause vim-powerline not work if :tabnew
" Plugin 'flazz/vim-colorschemes'  " themes collection

" Color Scheme
" Plug 'chriskempson/tomorrow-theme'
Plug 'morhetz/gruvbox'

" Search
Plug 'romainl/vim-cool'               " Disables highlight when search is done
Plug 'haya14busa/incsearch.vim'       " Better incremental search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }  " FZF plugin, makes Ctrl-P unnecessary
Plug 'junegunn/fzf.vim'

" Movement
Plug 'justinmk/vim-sneak'
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'wikitopian/hardmode'            " Disable arrow keys and similar


" Edit
" -------------------------------------------------------------------------------------
Plug 'tpope/vim-sensible'             " Some better defaults
Plug 'tpope/vim-unimpaired'           " Pairs of mappings
Plug 'tpope/vim-surround'             " Surround with parentheses & co
Plug 'joom/vim-commentary'            " To comment stuff out
" Plug 'terryma/vim-multiple-cursors'   " Multiple cursors like sublime
Plug 'godlygeek/tabular'              " For alignment
Plug 'junegunn/vim-easy-align'        " Easier alignment
Plug 'foosoft/vim-argwrap'            " convert lists of arguments into blocks of arguments
" Interacts with coc Plug 'tpope/vim-endwise'              " Ends control flow indentifiers
Plug 'tpope/vim-repeat'               " Adds repeat thorugh . to other packages
" Plug 'tpope/vim-speeddating'          " Dates in vim
"

"Writing
Plug 'junegunn/goyo.vim'               " Distraction free mode
Plug 'junegunn/limelight.vim'          " Focus on current paragraph
Plug 'rhysd/vim-grammarous'            " GrammarCheck using LanguageTool
Plug 'ron89/thesaurus_query.vim'       " Synonym query

" Linter
" ------------------------------------------------------------------------------
Plug 'w0rp/ale'
Plug 'maximbaz/lightline-ale'          " Lightline + Ale
" Plug 'davidhalter/jedi-vim'

" python
" Plug 'nvie/vim-flake8'
" if g:distro != 'Gentoo'
"     " under gentoo, conflict with dev-python/jinja builtin vim-jinja extension
"     Plug 'mitsuhiko/vim-jinja'
" endif
"Plugin 'kevinw/pyflakes-vim'
"Plugin 'fs111/pydoc.vim'
"Plugin 'Pydiction'
"Plugin 'pep8'

"json
Plug 'elzr/vim-json'

"css/html
Plug 'mattn/emmet-vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'ap/vim-css-color'

" Plug 'pangloss/vim-javascript'  " improved indentation
" Plug 'ternjs/tern_for_vim'  " js autocompletion
" Plug 'Shutnik/jshint2.vim'

" go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

"markdown/latex
Plug 'sjl/badwolf'
Plug 'plasticboy/vim-markdown'
Plug 'lervag/vimtex'

" Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}


" other
Plug 'pprovost/vim-ps1'
Plug 'liuchengxu/vista.vim'
Plug 'liuchengxu/vim-which-key'

" Git
" ------------------------------------------------------------------------------
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'                " TIG like navigation for vim
Plug 'xuyuanp/nerdtree-git-plugin'    " Show status of files in NerdTree
Plug 'tveskag/nvim-blame-line'        " Add git blame on line

" Enhanced
" ------------------------------------------------------------------------------
Plug 'scrooloose/nerdtree'
" Plug 'jistr/vim-nerdtree-tabs'
" Plug 'ervandew/supertab'
" Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'  " needed with SirVer/ultisnips
" Plug 'AndrewRadev/splitjoin.vim'  " transition between multiline and single-line code
Plug 'majutsushi/tagbar'
" Plug 'jiangmiao/auto-pairs'
" Plug 'hotoo/pangu.vim'
Plug 'simnalamburt/vim-mundo'
Plug 'machakann/vim-highlightedyank'  " Highlight yanks
Plug 'ojroques/vim-oscyank'           " Yank from remote sessions
Plug 'andymass/vim-matchup'           " Highlight corresponding blocks e.g. if - fi in bash
Plug 'kshenoy/vim-signature'          " Show marks in the gutter
Plug 'yggdroot/indentline'            " Shows indentation levels
Plug 'tpope/vim-eunuch'               " Unix helpers
Plug 'moll/vim-bbye'                  " optional dependency for vim-symlink
Plug 'aymericbeaumet/vim-symlink'     " Resolve symlinks before editing, plays nicely with undodir

" https://github.com/dyng/ctrlsf.vim
Plug 'dyng/ctrlsf.vim'


if has('mac') || has('macunix')
    Plug 'rizzatti/dash.vim'
endif

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting

if isdirectory($HOME . "/.vim/plugged/coc.nvim")
    call coc#add_extension(
       \'coc-explorer',
       \'coc-git',
       \'coc-go',
       \'coc-pyright',
       \'coc-json',
       \'coc-lua',
       \'coc-prettier',
       \'coc-highlight',
       \'coc-clangd',
       \'coc-rls',
       \'coc-sh',
       \'coc-vimlsp',
       \'coc-yaml',
       \'coc-eslint',
       \'coc-tsserver',
       \'coc-xml',
       \'coc-css',
       \'coc-stylelint',
       \'coc-html'
     \)
endif



" Enables and Disables
let g:gitgutter_enabled = 0          " vim-gitgutter
let g:indentLine_enabled = 0         " indentline
let g:SignatureEnabledAtStartup = 0  " vim-signature
let g:startify_custom_header =[]     " Disable startify header

" Coc
" -------------------------------------------------------------------------------
if !exists("*VSCodeNotify") && isdirectory($HOME . "/.vim/plugged/coc.nvim")

    let g:coc_custom_config = '1'
    let g:coc_node_path = $HOME . '/.nvm/versions/node/v16.18.0/bin/node'
    " let g:coc_disable_startup_warning = 1

    let g:vista_default_executive = 'coc'

    source ~/.vim/coc.vim
    " Use autocmd to force lightline update.
    autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

    " Lightline mods for CoC compatibility
    let g:lightline = {
          \ 'active': {
          \   'left': [ [ 'mode', 'paste' ],
          \             [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified', 'fugitive' ] ],
          \   'right': [ [ 'lineinfo' ],
		  \             [ 'percent' ],
		  \              [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok', 'filetype', 'fileencoding'] ]
          \ },
          \ 'component_function': {
          \   'filename': 'LightlineFilename',
          \   'cocstatus': 'coc#status',
          \   'currentfunction': 'CocCurrentFunction'
          \ },
          \ }
    function! LightlineFilename()
      return expand('%:t') !=# '' ? @% : '[No Name]'
    endfunction

    function! CocCurrentFunction()
        return get(b:, 'coc_current_function', '')
    endfunction


let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_infos': 'lightline#ale#infos',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }

let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_infos': 'lightline#ale#infos',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }

    " vim-easymotion disturbs diagnostics
    " See https://github.com/neoclide/coc.nvim/issues/110
    " let g:easymotion#is_active = 0
    " function! EasyMotionCoc() abort
    "   if EasyMotion#is_active()
    "     let g:easymotion#is_active = 1
    "     CocDisable
    "   else
    "     if g:easymotion#is_active == 1
    "       let g:easymotion#is_active = 0
    "       CocEnable
    "     endif
    "   endif
    " endfunction
    " autocmd TextChanged,CursorMoved * call EasyMotionCoc()

   nnoremap <silent> <space>Y  :<C-u>CocList -A --normal yank<cr>

   command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

endif

" Lokaltog/vim-powerline
" -------------------------------------------------------------------------------
" let g:Powerline_symbols = 'unicode' " compatible/unicode/fancy
" set laststatus=2   " Always show the statusline
" set encoding=utf-8 " Necessary to show Unicode glyphs
" set t_Co=256 " Explicitly tell Vim that the terminal supports 256 colors


" -------------------------------------------------------------------------------
" vim-airline/vim-airline
" -------------------------------------------------------------------------------
" Keep vim-powerline configuration opened
" In Mac with iTerm2, need to select patched font for non-ascii font, in
" Profiles -> Text
" let g:airline_powerline_fonts = 1
" let g:airline_theme='simple'


"-------------------------------------------------------------------------------
" Lightline
"-------------------------------------------------------------------------------
set noshowmode  "unnecessary when lighline enabled"

"-------------------------------------------------------------------------------
" fzf
"-------------------------------------------------------------------------------
set rtp+=/usr/local/opt/fzf
let g:fzf_layout = { 'down': '~20%' }

" -------------------------------------------------------------------------------
" kien/rainbow_parentheses.vim
" -------------------------------------------------------------------------------
" always on
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" the outer layer is the last pair
" remove black for dark terminal
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 16

" -------------------------------------------------------------------------------
" Yggdroot/indentLine
" -------------------------------------------------------------------------------
"   https://github.com/Yggdroot/indentLine
let g:indentLine_char='┆'
let g:indentLine_enabled = 0

" -------------------------------------------------------------------------------
" w0rp/ale
" -------------------------------------------------------------------------------
let g:ale_enabled = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_fix_on_save = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%code%]'
nmap <silent> [a <Plug>(ale_previous_wrap)
nmap <silent> ]a <Plug>(ale_next_wrap)

let g:ale_fixers = {
    \   '*': ['remove_trailing_lines', 'trim_whitespace'],
    \   'javascript': ['prettier'],
    \   'css': ['prettier'],
    \   'html': ['prettier'],
    \   'markdown': ['prettier'],
    \   'json': ['prettier'],
    \   'yaml': ['prettier'],
    \}
let g:ale_linters = {
    \ 'cpp': ['clang'],
    \ 'c' : ['clang'],
    \ 'python' : ['pylint'],
    \ 'javascript' : ['prettier']
  \ }
" -------------------------------------------------------------------------------
" davidhalter/jedi-vim
" -------------------------------------------------------------------------------
"   Goto assignments <leader>g (typical goto function)
"   Goto definitions <leader>d (follow identifier as far as possible, includes
"   imports and statements)
"   Show Documentation/Pydoc K (shows a popup with assignments)
"   Renaming <leader>r
"   Usages <leader>n (shows all the usages of a name)
"   Open module, e.g. :Pyimport os (opens the os module)
" autocmd FileType python setlocal completeopt-=preview    " disable docstring
" let g:jedi#completions_command = "<C-N>"

" -------------------------------------------------------------------------------
" nvie/vim-flake8
" " -------------------------------------------------------------------------------
" autocmd FileType python map <buffer> <F3> :call Flake8()<CR>
" let g:flake8_quickfix_height=5
" let g:flake8_show_in_gutter=1
" highlight link Flake8_Error      Error
" highlight link Flake8_Warning    WarningMsg
" highlight link Flake8_Complexity WarningMsg
" highlight link Flake8_Naming     WarningMsg
" highlight link Flake8_PyFlake    WarningMsg
"autocmd BufWritePost *.py call Flake8()

" ----------------------------------------------------------------------------
" mattn/emmet-vim
" ----------------------------------------------------------------------------
"   trigger key: <c-y>,  " note with comma
"   html:5
"   <c-y>n: next edit point
"   <c-y>N: previous edit point
"   <c-y>d: select whole label
"   <c-y>D: select whole label content
"   <c-y>k: delete current label


" ----------------------------------------------------------------------------
" hail2u/vim-css3-syntax
" ----------------------------------------------------------------------------
augroup VimCSS3Syntax
  autocmd!

  autocmd FileType css setlocal iskeyword+=-
augroup END

" ----------------------------------------------------------------------------
" ternjs/tern_for_vim
" " ----------------------------------------------------------------------------
" let tern_show_signature_in_pum = 1
" let tern_show_argument_hints = 'on_hold'
" autocmd FileType javascript nnoremap <leader>d :TernDef<CR>
" autocmd FileType javascript setlocal omnifunc=tern#Complete



"----------------------------------------------------------------------------
" Shutnik/jshint2.vim
" ----------------------------------------------------------------------------
" let jshint2_save = 1
" jshint validation
" nnoremap <leader>j :JSHint<CR>

" ----------------------------------------------------------------------------
" plasticboy/vim-markdown
" https://github.com/plasticboy/vim-markdown
" ----------------------------------------------------------------------------
let g:vim_markdown_folding_style_pythonic = 1
let g:vim_markdown_folding_level = 3
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toc_autofit = 1

" ----------------------------------------------------------------------------
" scrooloose/nerdtree and jistr/vim-nerdtree-tabs
" ----------------------------------------------------------------------------
"nmap <leader>ne :NERDTreeToggle<CR>
" nmap <leader>ne :NERDTreeTabsToggle<CR>
" autocmd vimEnter *.go NERDTree
" Close vim if only window left is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" ----------------------------------------------------------------------------
" ervandew/supertab
" ----------------------------------------------------------------------------
" set completeopt=longest,menu,preview
" let g:SuperTabDefaultCompletionType = "<c-x><c-o>"  " use omni completion instead of default
" let g:SuperTabCrMapping = 1  " disable <enter> with newline, https://github.com/ervandew/supertab/issues/142


" Recommended key-mappings.
" <TAB>: completion.
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" Close popup by <Space>.
" inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"


" Enable omni completion.
" autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
" autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
" autocmd FileType javascript setlocal omnifunc=tern#Complete  " for ternjs
" autocmd FileType python setlocal omnifunc=jedi#completions  " for jedi
" autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" ----------------------------------------------------------------------------
" SirVer/ultisnips
" ----------------------------------------------------------------------------
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<c-b>"
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"

" ----------------------------------------------------------------------------
" Tagbar
" ----------------------------------------------------------------------------
nmap <F8> :TagbarToggle<CR>
map <leader>tb :TagbarToggle<CR>
let g:tagbar_sort = 0

"let g:tagbar_type_markdown = {
"    \ 'ctagstype': 'markdown',
"    \ 'ctagsbin' : '/Users/TankyWoo/.dotfiles/markdown2ctags.py',
"    \ 'ctagsargs' : '-f - --sort=yes',
"    \ 'kinds' : [
"        \ 's:sections',
"        \ 'i:images'
"    \ ],
"    \ 'sro' : '|',
"    \ 'kind2scope' : {
"        \ 's' : 'section',
"    \ },
"    \ 'sort': 0,
"\ }

" ----------------------------------------------------------------------------
" airblade/vim-gitgutter
" ----------------------------------------------------------------------------
let g:gitgutter_max_signs = 500
"let g:gitgutter_highlight_lines = 1
highlight clear SignColumn
nmap ghs <Plug>(GitGutterStageHunk)
nmap ghu <Plug>(GitGutterUndoHunk)
nmap ghp <Plug>(GitGutterPreviewHunk)


" ----------------------------------------------------------------------------
" SirVer/ultisnips
" ----------------------------------------------------------------------------
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" ----------------------------------------------------------------------------
" rizzatti/dash.vim
" ----------------------------------------------------------------------------
" https://raw.githubusercontent.com/rizzatti/dash.vim/master/doc/dash.txt
let g:dash_map = {
  \ 'python' : ['py', 'python2', 'py3', 'python3']
  \ }
nmap <silent> <leader>da <Plug>DashSearch

" ----------------------------------------------------------------------------
" godlygeek/tabular
" ----------------------------------------------------------------------------
" use `Tab /|` to auto align '|'

" ----------------------------------------------------------------------------
" hotoo/pangu.vim
" https://github.com/hotoo/pangu.vim
" ----------------------------------------------------------------------------
"autocmd BufWritePre *.markdown,*.md call PanGuSpacing()

" ----------------------------------------------------------------------------
" easymotion/vim-easymotion
" https://github.com/easymotion/vim-easymotion
" ----------------------------------------------------------------------------
" Use uppercase target labels and type as a lower case
let g:EasyMotion_use_upper = 1
let g:EasyMotion_keys = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ;'
" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1
map <Leader> <Plug>(easymotion-prefix)

" incsearch
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" incsearch-easymotion
map z/ <Plug>(incsearch-easymotion-/)
map z? <Plug>(incsearch-easymotion-?)
map zg/ <Plug>(incsearch-easymotion-stay)


" ----------------------------------------------------------------------------
" dyng/ctrlsf.vim
" https://github.com/dyng/ctrlsf.vim
" ----------------------------------------------------------------------------
nmap     <C-F>f <Plug>CtrlSFPrompt
"vmap     <C-F>f <Plug>CtrlSFVwordPath
vmap     <C-F>f <Plug>CtrlSFVwordExec
nmap     <C-F>n <Plug>CtrlSFCwordPath
"nmap     <C-F>p <Plug>CtrlSFPwordPath
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>
let g:ctrlsf_search_mode = 'async'  " vim >= 8.0
" let g:ctrlsf_winsize = '40%'

"--------------------------------------------------------------------------------------------
" vim-easy-align
" -------------------------------------------------------------------------------------------
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"-------------------------------------------------------------------------------------------
" argwrap
"-------------------------------------------------------------------------------------------
" aw    -- ArgWrap
nnoremap <Leader>aw :ArgWrap<CR>

"---------------------------------------------------------------------------------------
" remote yanks
"----------------------------------------------------------------------------------------
autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '+' | execute 'OSCYankReg +' | endif

let g:secure_modelines_allowed_items = [
                \ "textwidth",   "tw",
                \ "softtabstop", "sts",
                \ "tabstop",     "ts",
                \ "shiftwidth",  "sw",
                \ "expandtab",   "et",   "noexpandtab", "noet",
                \ "filetype",    "ft",
                \ "foldmethod",  "fdm",
                \ "readonly",    "ro",   "noreadonly", "noro",
                \ "rightleft",   "rl",   "norightleft", "norl",
                \ "colorcolumn"
                \ ]

"---------------------------------------------------------------------------------------
" vimtex
"----------------------------------------------------------------------------------------
let g:tex_flavor = "latex"

" * Limelight
let g:limelight_conceal_ctermfg = 'gray'
"autocmd! User GoyoEnter Limelight
"autocmd! User GoyoLeave Limelight!

"===============================================================================
" Custom Function & Key Binds
"===============================================================================
"
function! ToggleALEFix()
    if(g:ale_fix_on_save == 1)
        let g:ale_fix_on_save = 0
    else
        let g:ale_fix_on_save = 1
    endif
endfunc

function! ToggleLineNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc

function! ToggleColorColumn()
    if &colorcolumn == ""
        set colorcolumn=88
    else
        set colorcolumn=
    endif
endfunction

function! ToggleZoom(toggle)
  if exists("t:restore_zoom") && (t:restore_zoom.win != winnr() || a:toggle == v:true)
      exec t:restore_zoom.cmd
      unlet t:restore_zoom
  elseif a:toggle
      let t:restore_zoom = { 'win': winnr(), 'cmd': winrestcmd() }
      vert resize | resize
  endif
endfunction
augroup restorezoom
    au WinEnter * silent! :call ToggleZoom(v:false)
augroup END


command! LineNumberToggle call ToggleLineNumber()
command! ALEfixToggle call ToggleALEFix()
command! ColorColumnToggle call ToggleColorColumn()


" Modifiers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <C-g> :Goyo<CR>
map <C-p> :Files<CR>
map <C-h> :History<CR>


" <Nothing> -- vim-which-key
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

"  <Space>  --  <leader><leader> toggles between buffers
nnoremap <Leader><Leader> <c-^>

"  - |     --  Split with leader
nnoremap <Leader>- :sp<CR>
nnoremap <Leader>\| :vsp<CR>

"  e g H -- FZF
nmap <Leader>; :Buffers<CR>
nnoremap <Leader>g :Rg<CR>
nnoremap <Leader>e :Files<CR>
nnoremap <Leader>H :History<CR>

" Quick copy/paste to system clipboard
nmap <Leader>y "+y
nmap <Leader>d "+d
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" toggles
nnoremap <Leader>oa :ALEToggle<CR>
nnoremap <Leader>ob :ToggleBlameLine<CR>
nnoremap <Leader>oc :ColorToggle<CR>
nnoremap <Leader>oe :NERDTreeToggle<CR>
nnoremap <Leader>of :ALEfixToggle<CR>
nnoremap <Leader>og :GitGutterToggle<CR>
nnoremap <Leader>ol :ColorColumnToggle<CR>
nnoremap <Leader>om :SignatureToggle<CR>
nnoremap <Leader>on :LineNumberToggle<CR>
" nnoremap <Leader>op :RainbowToggle<CR>
nnoremap <Leader>ot :Vista!!<CR>
nnoremap <Leader>os :setlocal spell! spelllang=en_us<CR>
nnoremap <Leader>u :MundoToggle<CR>

"  z   -- Toggle Pane Zoom
nnoremap <silent> <Leader>+ :call ToggleZoom(v:true)<CR>

" `  `v  `z  rv  -- edit vimrc/zshrc and load vimrc bindings
nnoremap <Leader>` :Startify<CR>
nnoremap <Leader>`z :vsp ~/.zshrc<CR>
nnoremap <Leader>`v :vsp ~/.vimrc<CR>
nnoremap <Leader>rv :source ~/.vimrc<CR>

" hjkl  s j k t / ? g/   -- EasyMotion
map <Leader>h <Plug>(easymotion-linebackward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>w <Plug>(easymotion-w)
map <Leader>b <Plug>(easymotion-b)

" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)
" vim-sneak behaviour through easymotio
map <Leader>t <Plug>(easymotion-t2)
nmap <Leader>t <Plug>(easymotion-overwin-t2)
map <Leader>s <Plug>(easymotion-f2)
nmap <Leader>s <Plug>(easymotion-overwin-f2)

map <Leader>/ <Plug>(incsearch-easymotion-/)
map <Leader>? <Plug>(incsearch-easymotion-?)
map <Leader>g/ <Plug>(incsearch-easymotion-stay)

" numbers
nnoremap <Leader>1 1gt<CR>
nnoremap <Leader>2 2gt<CR>
nnoremap <Leader>3 3gt<CR>
nnoremap <Leader>4 4gt<CR>
nnoremap <Leader>5 5gt<CR>
nnoremap <Leader>6 6gt<CR>
nnoremap <Leader>7 7gt<CR>
nnoremap <Leader>8 8gt<CR>
nnoremap <Leader>9 9gt<CR>
nnoremap <Leader>n :tabnew<CR>
nnoremap <Leader>x :tabclose<CR>

" rn F a ac af U -- Conquer of Completion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
if exists('g:coc_custom_config')
    " Symbol renaming.
    nmap <leader>rn <Plug>(coc-rename)

    nmap <Leader>! :<C-u>CocList diagnostics<CR>

    " TODO figure out
    " Formatting selected code.
    " xmap <leader>F  <Plug>(coc-format-selected)
    " nmap <leader>F  <Plug>(coc-format-selected)
    " Applying codeAction to the selected region.
    " Example: `<leader>aap` for current paragraph
    " xmap <leader>a  <Plug>(coc-codeaction-selected)
    " nmap <leader>a  <Plug>(coc-codeaction-selected)

    " Remap keys for applying codeAction to the current buffer.
    " nmap <leader>ac  <Plug>(coc-codeaction)
    " Apply AutoFix to problem on the current line.
    " nmap <leader>af  <Plug>(coc-fix-current)

    """"""""""""" Coc-Git
    " Undo git chunk (closest to linewise undo)
    " nmap <Leader>U :CocCommand git.chunkUndo<CR>
    " " Toggle GitGutter
    " nmap <Leader>og :CocCommand git.toggleGutters<CR>
    " " " navigate chunks of current buffer
    " nmap [c <Plug>(coc-git-prevchunk)
    " nmap ]c <Plug>(coc-git-nextchunk)
    " " show chunk diff at current position
    " nmap gs <Plug>(coc-git-chunkinfo)
    " " show commit contains current position
    " nmap gc <Plug>(coc-git-commit)
    " " " create text object for git chunks
    " omap ig <Plug>(coc-git-chunk-inner)
    " xmap ig <Plug>(coc-git-chunk-inner)
    " omap ag <Plug>(coc-git-chunk-outer)
    " xmap ag <Plug>(coc-git-chunk-outer)

    " Play nicely with EasyMotion
    autocmd User EasyMotionPromptBegin silent! CocDisable
    autocmd User EasyMotionPromptEnd silent! CocEnable
endif



" ===============================================================================
" Color Settings
" ===============================================================================
" test color with run `:runtime syntax/colortest.vim`

set t_Co=256

if exists('+colorcolumn')
    " cc is only exist >= `Vim7.3`
    set cc=90 " Short for colorcolumn
else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif
hi ColorColumn ctermbg=lightgrey guibg=lightgrey  " Highlighter cc

try
    set background=dark
    colorscheme gruvbox
    " Below syntax will affect vim-airline statusbar; write colorscheme
    " directly is ok
    " autocmd BufEnter * colorscheme Tomorrow-Night-Bright
    " autocmd BufEnter *.md,*.mkd,*.markdown colorscheme badwolf
catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme desert
endtry

" for gui, such as macvim
if has("gui_running")
  "set guifont=Monaco:h12
  set guifont=Source\ Code\ Pro\ for\ Powerline:h12  " for vim-airline
  set gcr=a:blinkon0  "Disable cursor blink
  set lines=60
  set columns=150
endif

" Highlight TODO/FIXME/XXX
highlight myTODO cterm=bold term=bold ctermbg=yellow ctermfg=black
match myTODO /\(TODO\|XXX\|FIXME\)/

" this options can be setted with colors, and must be put after colorscheme
set cursorline " Highlighter the current line
set cursorcolumn " Highlighter the vertical line"
hi search cterm=underline ctermfg=white

highlight PmenuSel cterm=underline,bold ctermfg=blue
highlight Normal guibg=NONE ctermbg=NONE
