if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif
call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'jackguo380/vim-lsp-cxx-highlight'

Plug 'justinmk/vim-syntax-extra'

Plug 'LnL7/vim-nix'

Plug 'luochen1990/rainbow'

Plug 'vim-airline/vim-airline'

" uses sign column to indicate added/modifed/removed in a VCS
Plug 'mhinz/vim-signify'

Plug 'f-person/git-blame.nvim'

Plug 'kien/ctrlp.vim'

Plug 'preservim/tagbar'

Plug 'wfxr/minimap.vim', {'do': ':!cargo install --locked code-minimap'}

"Plug 'lukas-reineke/indent-blankline.nvim'

Plug 'embear/vim-localvimrc'

call plug#end()

set hidden

set matchpairs+=<:>

"set background=dark
hi CocFloating ctermbg=black
hi FgCocInfoFloatBgCocFloating ctermfg=159
hi DiagnosticInfo ctermfg=159

" show syntax highlight groups
nnoremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" look for 'tags' in current directory and work up the tree towards root until
" one is found
set tags+=tags;/
set path+=**

" better diff result
set diffopt+=internal,algorithm:patience

set mouse=

set number
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
:  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
set signcolumn=yes

"set showmode    " status line displays 'insert' or 'visual' when not in normal mode

match ErrorMsg '\s\+$'

set shiftwidth=2 " shiftwidth, number of spaces for autoindent
set tabstop=2   " tabstop, number of spaces for tab character
set expandtab

set ignorecase  " ignore case in searches
set smartcase   " only care about case if search word uses upper case (use with ignorecase)
set scrolloff=1 " lines of content shows above cursor
set nosmarttab

"set showmatch  " causes some trouble in fast typeing

set splitbelow
set splitright

set confirm

" insert mode
"inoremap <C-c> <ESC>
"inoremap <C-w> <C-[>diwa
"inoremap <C-h> <BS>
"inoremap <C-d> <Del>
"inoremap <C-u> <C-G>u<C-U>
"inoremap <C-b> <Left>
"inoremap <C-f> <Right>
"inoremap <C-a> <Home>
"inoremap <C-n> <Down>
"inoremap <C-p> <Up>

" command line mappings
cnoremap <C-a> <Home>
cnoremap <C-b> <S-Left>
cnoremap <C-f> <S-Right>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>
cnoremap <C-h> <BS>


"""""""""""""""""""""" f-person/git-blame.nvim
let g:gitblame_date_format = '%y/%m/%d %H:%M:%S'
let g:gitblame_highlight_group = "NonText"

"""""""""""""""""""""" lukas-reineke/indent-blankline.nvim
"lua <<EOF
"vim.opt.list = true
"require("indent_blankline").setup {}
"  space_char_blankline = ' '
"EOF

"""""""""""""""""""""" embear/vim-localvimrc
let g:localvimrc_persistent = 1

"""""""""""""""""""""" luochen1990/rainbow
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

"""""""""""""""""""""" mhinz/vim-signify
" default updatetime 4000ms is not good for async update
set updatetime=100

"""""""""""""""""""""" minimap
let g:minimap_highlight_range = 1
let g:minimap_highlight_search = 1
let g:minimap_git_colors = 1

"""""""""""""""""""""" hobbes syntax """""""""""""""
au BufRead,BufNewfile *.hob set filetype=hobbes

"""""""""""""""""""""" ctrlp
let g:ctrlp_match_window = 'results:100' " overcome limit imposed by max height
let g:ctrlp_working_path_mode = ""
let g:ctrlp_max_depth = 400
let g:ctrlp_max_files = 0
let g:ctrlp_custom_ignore = {
        \ 'dir':  '\v[\/]\.(git|hg|svn)$',
        \ 'file': '\v\.(exe|so|dll)$',
        \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
        \ }

if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files
  let g:ctrlp_user_command='ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

"""""""""""""""""""""" coc.nvim
"let g:coc_global_extensions = [
"      \ 'coc-json',
"      \ 'coc-spell-checker'
"      \ 'coc-clangd'
"      \ 'coc-explorer'
"      \ 'coc-rust-analyzer'
"      \ 'coc-copilot'
"      \ ]

"""""""""""""""""""""" coc-clangd
nnoremap <Leader>si  :CocCommand clangd.symbolInfo<CR>
nnoremap <Leader>sh  :CocCommand clangd.switchSourceHeader<CR>
nnoremap <Leader>ast :CocCommand clangd.ast<CR>


"""""""""""""""""""""" coc-explorer
nnoremap <Leader>e :CocCommand explorer<CR>

"""""""""""""""""""""" coc-spell-checker
 " conflict?
vmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

"""""""""""""""""""""" luochen1990/rainbow
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle
let g:rainbow_conf = {
      \ 'separately': {
      \    'cmake': 0,
      \ }
\}

"""""""""""""""""""""" coc.nvim example

" May need for Vim (not Neovim) since coc.nvim calculates byte offset by count
" utf-8 byte sequence
set encoding=utf-8
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
