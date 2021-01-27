if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'asheq/close-buffers.vim'
Plug 'cocopon/vaffle.vim'
Plug 'cohama/lexima.vim'
Plug 'cormacrelf/dark-notify'
Plug 'honza/vim-snippets'
Plug 'jlanzarotta/bufexplorer'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'norcalli/nvim-colorizer.lua'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'sainnhe/edge'
Plug 'sainnhe/gruvbox-material'
Plug 'sheerun/vim-polyglot'
Plug 'simnalamburt/vim-mundo'
Plug 'szw/vim-maximizer'
Plug 'thaerkh/vim-workspace'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'vimwiki/vimwiki'
Plug 'wellle/targets.vim'
call plug#end()

if ! filereadable(expand("~/.config/nvim/lastupdate"))
      \ || readfile(glob("~/.config/nvim/lastupdate"))[0] < (localtime() - 604800)
  execute 'PlugUpdate'
  silent execute '!echo ' . (localtime()) . ' > ~/.config/nvim/lastupdate'
endif

set diffopt+=algorithm:patience,indent-heuristic
set foldmethod=syntax
set foldnestmax=1
set foldminlines=3
set foldlevel=4
set gdefault
set hidden
set hlsearch
set lazyredraw
set ignorecase smartcase
set inccommand=split
set matchpairs+=<:>
set mouse=a
set noshowmode
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
set number relativenumber
set noshowcmd
set pumblend=10
set rtp+=/usr/local/opt/fzf
set sessionoptions-=help
set signcolumn=number
set shiftround
set shortmess+=acWI
set splitbelow splitright
set termguicolors
set undofile
set updatetime=200

augroup autocommands
  autocmd!
  autocmd BufRead,BufNewFile .{eslint,babel,stylelint,prettier}rc set ft=json5
  autocmd SessionLoadPost,VimResized * wincmd =
  autocmd WinEnter,BufWinEnter * setlocal cursorline | autocmd WinLeave * setlocal nocursorline
  autocmd BufWritePre * %s/\s\+$//e
  autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif
  autocmd TextYankPost,FocusGained,FocusLost * if exists(':rshada') | rshada | wshada | endif
augroup END

" THEME SETTINGS: {{{
let g:edge_diagnostic_line_highlight = 1
let g:edge_sign_column_background = 'none'
let g:gruvbox_material_diagnostic_line_highlight = 1
let g:gruvbox_material_sign_column_background = 'none'
if len(systemlist('defaults read -g AppleInterfaceStyle'))==1
  set background=dark
  colorscheme gruvbox-material
else
  set background=light
  colorscheme edge
endif

lua << EOF
require'colorizer'.setup()
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  highlight = {
    enable = true,
  },
}
require('dark_notify').run({
  schemes = {
    dark  = "gruvbox-material",
    light = "edge"
  },
})
EOF
" }}}

" PLUGIN SETTINGS: {{{
" misc plugin settings
let g:mundo_preview_bottom = 1
let g:vaffle_show_hidden_files = 1
let g:vimwiki_list = [{'path': '~/Documents/vimwiki'}]
let g:vimsyn_embed = 'l'

" airline
call airline#parts#define_minwidth('branch', 180)
call airline#parts#define_minwidth('coc_status', 180)
call airline#parts#define_minwidth('filetype', 100)
let g:airline#extensions#whitespace#enabled = 0
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline_left_alt_sep = '┊'
let g:airline_left_sep=''
let g:airline_powerline_fonts = 1
let g:airline_right_alt_sep = '┊'
let g:airline_right_sep=''
let g:airline_section_z = '%3l/%L:%2v'
if !exists('g:airline_symbols')
  let g:airline_symbols = {'dirty':'!'}
endif

" coc
let g:coc_global_extensions = [
      \ 'coc-css',
      \ 'coc-eslint',
      \ 'coc-flow',
      \ 'coc-html',
      \ 'coc-json',
      \ 'coc-prettier',
      \ 'coc-snippets',
      \ 'coc-styled-components',
      \ 'coc-stylelintplus',
      \ 'coc-tsserver',
      \ 'coc-yaml',
      \ ]

" fzf
let g:fzf_history_dir = '~/.local/share/fzf-history'
command! -bang -nargs=* RgOnlyLines call fzf#vim#grep('rg '.shellescape(<q-args>), 1,
      \ fzf#vim#with_preview({'options':'--delimiter : --nth 3..'}), <bang>0)

" vim workspace
let g:workspace_session_disable_on_args = 1
let g:workspace_autosave = 0
let g:workspace_persist_undo_history = 0
let g:workspace_session_directory = $HOME.'/.local/share/nvim/sessions/'
" }}}

" KEYMAPS: {{{
" misc
let mapleader = ' '
nnoremap j gj
nnoremap k gk
nnoremap <silent> dm :execute 'delmarks '.nr2char(getchar())<cr>
nnoremap <silent> <Esc> :nohl<cr>
nnoremap <silent> - :call vaffle#init(expand('%'))<cr>
nnoremap <leader><leader> :write<cr>
nnoremap <leader>z zA
nnoremap <expr> <leader>x &foldlevel ? 'zM' :'zR'
nnoremap <leader>tw :ToggleWorkspace<cr>
nnoremap <leader>u :MundoToggle<cr>
nnoremap <Leader>s :%s/<C-r><C-w>//c <Left><Left><Left>
xnoremap <Leader>s "sy:%s/<C-r>s//c <Left><Left><Left>
xnoremap < <gv
xnoremap > >gv
xmap ga <Plug>(EasyAlign)
nmap <leader>c <Plug>(qf_qf_toggle)
nmap ç <Plug>(qf_qf_switch)
nnoremap <leader>b :ToggleBufExplorer <cr>
nnoremap <leader>m :MaximizerToggle <cr>

" tabs
nnoremap <silent> <C-t> :tabnew %<cr>
nnoremap <silent> <leader>1 1gt
nnoremap <silent> <leader>2 2gt
nnoremap <silent> <leader>3 3gt
nnoremap <silent> <leader>4 4gt
nnoremap <silent> <leader>5 5gt
nnoremap <silent> <C-Q> :tabclose<cr>

" close-buffers
nnoremap Q :Bdelete menu<cr>
nnoremap Qa :Bdelete all<cr>
nnoremap Qh :Bdelete hidden<cr>
nnoremap Qo :Bdelete other<cr>
nnoremap Qt :Bdelete this<cr>
nnoremap Qs :Bdelete select<cr>

" coc
imap <silent> <C-l> <Plug>(coc-snippets-expand-jump)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> <leader>h :call CocAction('doHover')<cr>
nmap <silent> <leader>g <Plug>(coc-git-commit)
nmap <silent> <leader>p <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>n <Plug>(coc-diagnostic-next)
nmap <silent> <leader>f <Plug>(coc-format)
nmap <silent> <leader>l :CocList<cr>
nmap <silent> <leader>a <Plug>(coc-codeaction)
vmap <silent> <leader>a <Plug>(coc-codeaction-selected)

" fzf
nnoremap <silent> <leader>I :Rg <cr>
nnoremap <silent> <leader>i :RgOnlyLines <cr>
xnoremap <silent> <leader>i "fy :Rg <C-R>f<cr>
nnoremap <silent> <leader>o :Files<cr>
nnoremap <silent> <leader>q :History:<cr>
nnoremap <silent> <leader>/ :BLines:<cr>

" fugitive
nnoremap <silent> <leader>gb :Gblame<cr>
nnoremap <silent> <leader>gl :0Gclog<cr>
xnoremap <silent> <leader>gl :'<,'>Gclog<cr>

" unimpaired on non-US layouts
nmap <Left> [
omap <Left> [
xmap <Left> [
nmap <Right> ]
omap <Right> ]
xmap <Right> ]
" }}}
