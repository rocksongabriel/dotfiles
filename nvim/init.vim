" GENERAL
" {{{

set regexpengine=0

" Always show the signcolumn, otherwise it would shift
set signcolumn=yes
set lazyredraw " dont't redraw everytime
set synmaxcol=128 " avoid slow rendering for long lines

set guifont=Fira\ Code\ iScript\ 12

filetype plugin indent on
syntax on
"colorscheme onedark

" set background=dark
set clipboard=unnamedplus
" set completeopt=oninsert menuone noselect

set cursorline
set hidden
" set inccomand=split

" set mouse=a
set number
set relativenumber

set splitright
set splitbelow
set title

set ttimeoutlen=0
set wildmenu

" Tabs size
set expandtab
set shiftwidth=2
set tabstop=2
set smartindent

set termguicolors

" Italics
let &t_ZH="\e[3m"
let &t_ZR="\[23m"

" use alt+hjkl to move between split/vsplit panels
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" Folding
set foldenable
" set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent

set list lcs=tab:\|\
" }}}


" PLUGINS
" {{{

call plug#begin("~/.vim/plugged")

Plug 'dracula/vim'
Plug 'joshdick/onedark.vim'
" Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'ghifarit53/tokyonight-vim'

Plug 'scrooloose/nerdcommenter'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'tmhedberg/matchit'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fugitive'

Plug 'jiangmiao/auto-pairs'
Plug 'wakatime/vim-wakatime'
Plug 'mhinz/vim-startify'

Plug 'ryanoasis/vim-devicons'
Plug 'mattn/emmet-vim'
Plug 'christoomey/vim-tmux-navigator'

Plug 'airblade/vim-gitgutter'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'

Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'pangloss/vim-javascript'

Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'airblade/vim-rooter'
Plug 'Yggdroot/indentLine'

call plug#end()

" }}}


" VIMSCRIPT
" {{{

" This will enable code folding.
" Use the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" Highlighting for large files
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

" highlight trailing whitespace
match ErrorMsg '\s\+$'
" remove trailing whitespaces automatically
autocmd BufWritePre * :%s/\s\+$//e

" Auto Commands
augroup auto_commands
	autocmd BufWrite *.py call CocAction('format')
	autocmd FileType scss setlocal iskeyword+=@-@
augroup END
" }}}


" COC
" {{{

" Code action on <leader>a
vmap <leader>a <Plug>(coc-codeaction-selected)<CR>
nmap <leader>a <Plug>(coc-codeaction-selected)<CR>

" Format action on <leader>f
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Goto definition
nmap <silent> gd <Plug>(coc-definition)

" Type definition
nmap <silent> gy <Plug>(coc-type-definition)

" References
nmap <silent> gr <Plug>(coc-references)


" Navigate by jumping to next or previous error
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Performing code actions
nmap <leader>do <Plug>(coc-codeaction)

" Renaming a symbol
nmap <leader>rn <Plug>(coc-rename)


" Open definition in a split window
nmap <silent> gv :vsp<CR><Plug>(coc-definition)<C-W>L

let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json']

if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction
nnoremap <silent> K :call CocAction('doHover')<CR>

" }}}


" NERDTREE
" {{{

nnoremap <leader>n :NERDTreeFocus<CR>
" nnoremap <C-n> :NERDTree<CR>
nnoremap <A-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }

let g:NERDTreeGitStatusUseNerdFonts = 1 " you should install nerdfonts by yourself. default: 0

let g:NERDTreeGitStatusShowClean = 1 " default: 0

" Open the existing NERDTree on each new tab.
" autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif

" }}}


" STATUS LINE
" {{{

let g:lightline = {'colorscheme': 'tokyonight'}

" }}}


" FUGITIVE
" {{{

nnoremap <leader>gd :Gvdiffsplit!<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>

" }}}


" PYTHON
" {{{

let python_highlight_all=1

" }}}


" JAVASCRIPT
" {{{

"configuring emmet
let g:user_emmet_leader_key='<Tab>'
let g:user_emmet_settings = {
  \  'javascript.jsx' : {
    \      'extends' : 'jsx',
    \  },
  \}

" }}}


" INTEGRATED TERMINAL
" {{{

" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" open terminal on ctrl+n
function! OpenTerminal()
  split term://zsh
  resize 10
endfunction
nnoremap <c-n> :call OpenTerminal()<CR>

" }}}


" FZF
" {{{

nnoremap <C-p> :FZF<CR>

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

map <C-f> :Files<CR>
map <leader>b :Buffers<CR>
nnoremap <leader>g :Rg<CR>
nnoremap <leader>t :Tags<CR>
nnoremap <leader>m :Marks<CR>


let g:fzf_tags_command = 'ctags -R'
" Border color
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }

let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
let $FZF_DEFAULT_COMMAND="rg --files --hidden"


" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

"Get Files
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)


" Get text in files with Rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" Ripgrep advanced
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" Git grep
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)
" }}}


" INDENTLINE
let g:indentLine_setColors = 0
let g:indentLine_char_list = ['|', '¦', '┆', '┊']















" Source the colorscheme
" source $HOME/.config/nvim/themes/onedark.vim
source $HOME/.config/nvim/themes/tokyonight.vim
