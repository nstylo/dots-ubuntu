set nocompatible
set encoding=utf-8
set fileencoding=utf-8
set number relativenumber
set showcmd
set ignorecase
set autoindent
set hlsearch
set incsearch
set scrolloff=10
set nowrap
set hidden
set smartcase
set autoread

" tabbing
set softtabstop=0
set shiftwidth=4
set tabstop=4
set expandtab
set cindent
set smarttab

filetype plugin on
syntax on

" enable scroll
set mouse=a

call plug#begin('~/.vim/plugged')
" aesthetics
" Plug 'morhetz/gruvbox'
Plug 'rktjmp/lush.nvim'
Plug 'nstylo/gruvbox.nvim' " forked from ellisonleao/gruvbox.nvim
Plug 'markonm/traces.vim'
" status and bufferline
Plug 'mengelbrecht/lightline-bufferline'
Plug 'itchyny/lightline.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'moll/vim-bbye'
" navigation
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
" latex
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
" snippets
Plug 'honza/vim-snippets'
" git
Plug 'airblade/vim-gitgutter'
" formatting
Plug 'scrooloose/nerdcommenter'
Plug 'editorconfig/editorconfig-vim'
" markdown
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install', 'for': 'markdown' }
" linting, syntax highlighting, lsp, colorizer
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
" git
Plug 'tpope/vim-fugitive'
" prisma
Plug 'pantharshit00/vim-prisma'
" haskell
Plug 'vmchale/cabal-project-vim'
" debugging
Plug 'mfussenegger/nvim-dap'
" tree sitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
call plug#end()

" :Man to open man pages
runtime ftplugin/man.vim

" Disable vimwiki filetype for markdown files
let g:vimwiki_global_ext = 0

" specify python providers
let g:python_host_prog = "/usr/bin/python2"
let g:python3_host_prog = "/usr/bin/python3"
let g:chadtree_settings = { 'theme.text_colour_set': 'solarized_dark' }

" setup color scheme
set termguicolors "sets to true colors
let &t_ut=''
colorscheme gruvbox
" highlight Comment gui=italic

" Visual mode colors
highlight Visual guifg=NONE guibg=#458588 gui=NONE

" hexoinkase
let g:Hexokinase_optInPatterns = 'full_hex,triple_hex,rgb,rgba,hsl,hsla,colour_names'

" configure lightline
let g:lightline = {
    \ 'colorscheme': 'gruvbox',
    \ 'component': {
    \ 'lineinfo': "%{line('.') . '/' . line('$')}",
    \ },
    \ 'component_function': {
    \ 'modified': 'LightlineModified',
    \ 'readonly': 'LightlineReadonly',
    \ }
\ }
let g:lightline.active = {
    \ 'left': [ [ 'mode', 'paste' ],
    \           ['absolutepath', 'readonly', 'modified' ] ],
    \ 'right': [ [ 'lineinfo' ],
    \            [ 'fileformat', 'filetype' ] ] }
let g:lightline.inactive = {
    \ 'left': [ [ 'mode', 'paste' ],
    \           ['absolutepath', 'readonly', 'modified' ] ],
    \ 'right': [ [ 'lineinfo' ],
    \            [ 'fileformat', 'filetype' ] ] }

function! LightlineModified()
    return &modifiable && &modified ? '[+]' : ''
endfunction
function! LightlineReadonly()
    return &readonly ? '[]' : ''
endfunction

let g:lightline.tabline          = {'left': [['buffers']], 'right': [['']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}
let g:lightline#bufferline#filename_modifier = ':t'
let g:lightline#bufferline#modified = ' [+]'
let g:lightline#bufferline#read_only = ' []'
let g:lightline#bufferline#enable_devicons = 1
set showtabline=2

" gitgutter
let g:gitgutter_sign_added = '▊'
let g:gitgutter_sign_modified = '▊'
let g:gitgutter_sign_removed = '▊'
let g:gitgutter_sign_removed_first_line = '▊'
let g:gitgutter_sign_removed_above_and_below = '▊'
let g:gitgutter_sign_modified_removed = '▊'
highlight GitGutterAdd    guifg=#98971a
highlight GitGutterChange guifg=#d79921
highlight GitGutterDelete guifg=#cc241d
let g:gitgutter_set_sign_backgrounds = 1

" haskell highlighting
" let g:haskell_classic_highlighting = 1
let g:haskell_indent_guard = 4
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

" disable markdown folding
let g:vim_markdown_folding_disabled = 1

" vimtex options
let g:vimtex_view_method = 'zathura'
let g:livepreview_previewer = 'zathura'
let g:vimex_compiler_progname = 'nvr'
let g:tex_flavor = "latex"
let g:vimtex_quickfix_mode = 0
"spell check for latex
autocmd FileType plaintex,tex,latex setlocal spell
"spell check language
set spelllang=en_gb

" set to 1, nvim will auto close current preview window
" when change from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 0

" set editor update time
set updatetime=200

" buffers jump to existing window
let g:fzf_buffers_jump = 1
" set fzf layout
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.6, 'border': 'rounded' } }

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" CocCommand and CocList abrv
command! -nargs=0 CC :CocCommand
command! -nargs=0 CL :CocList
command! -nargs=0 CA :CocAction

" autocomplete
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<C-l>'
let g:coc_snippet_prev = '<C-h>'

" nerdcommenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
" let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1


function! ZLookup(z_arg)
  let z_command = 'cd ' . system('. /usr/share/z/z.sh && _z -e ' . a:z_arg)
  " Strip empty newline so that command line doesn't grow when echoing
  let z_command = substitute(z_command, "\n", "", "")
  execute z_command
  echo z_command
endfunction

" Change working directory using z.sh
command! -nargs=+ Z call ZLookup(<q-args>)

" assign mapleader
let mapleader=" "

" disable ex mode
nnoremap Q <Nop>
" disable command line history
nnoremap q: <Nop>

" copy to clipboard
vnoremap Y "+y

" paste from yank register
nnoremap p "0p
vnoremap p "0p

" easy navigation
map <C-l> :bn<CR>
map <C-h> :bp<CR>
map <Leader>q :q<CR>
map <Leader>d :Bdelete<CR>
map <Leader>n :enew<CR>
map <Leader>v :vsplit<CR>
map <Leader>h :split<CR>

map <Up> :res +5<CR>
map <Down> :res -5<CR>
map <Right> :vertical res +5<CR>
map <Left> :vertical res -5<CR>

" substitute makro
nnoremap <Leader>r :%s/\<<C-r><C-w>\>/

" double esc to disable hlsearch
nnoremap <silent> <Esc><Esc> <Esc>:nohlsearch<CR><Esc>

" map fzf
map <C-p> <CMD>Telescope find_files<CR>
map <C-f> <CMD>Telescope live_grep<CR>
map <C-j> <CMD>Telescope buffers<CR>
map <C-k> :Lines<CR>

" special filytype mappings
autocmd FileType tex map <C-m> :LLPStartPreview<CR>
autocmd FileType markdown map <C-m> :MarkdownPreview<CR>

" Sidemenu toggle
map <C-n> :CHADopen<CR>

" remap nerdcomment
nnoremap <C-_> :call nerdcommenter#Comment(0, "toggle")<CR>
vnoremap <C-_> :call nerdcommenter#Comment(0, "toggle")<CR>

" close all buffers
map bd :bufdo bd<CR>

" git mappings
nmap gl :Gclog<CR>
nmap gb :Git blame<CR>
nmap gc :Git commit -v<CR>
nmap gs <Plug>(GitGutterStageHunk)
nmap gu <Plug>(GitGutterUndoHunk)
nmap gp <Plug>(GitGutterPreviewHunk)

" set invisible characters
set listchars=tab:>·,trail:$,extends:>,precedes:<
set list

lua <<EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = 'maintained',    -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ignore_install = { },               -- List of parsers to ignore installing
    highlight = {
    enable = true,                      -- false will disable the whole extension
    disable = { 'javascript', 'vim' },  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}


local actions = require('telescope.actions')
require('telescope').setup {
  defaults = {
    mappings = {
      n = {
        ["<C-c>"] = actions.close,
        -- Hack: override default behaviour with essentially "do nothing"
        ["<Esc>"] = function() end,
      }
    }
  },
  pickers = {
    find_files = {
      find_command = {
          "rg",
          "--color=never",
          "--files",
          "--hidden",
          "--smart-case",
          "-g",
          "!Music",
          "-g",
          "!Bulk",
          "-g",
          "!node_modules",
          "-g",
          "!.git",
      },
      previewer = false,
    }
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')
EOF
