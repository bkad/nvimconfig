set expandtab
set tabstop=2
set shiftwidth=2
set textwidth=110
let &wrapmargin=&textwidth
set formatoptions=cqrol
filetype indent plugin on

syntax enable
nmap <C-J> vip=
set showmatch
set ruler
set nohls
set number
set relativenumber
let g:zenburn_high_Contrast=1
colorscheme zenburn

let g:python_host_prog = '/Users/kevin/.local/share/virtualenvs/neovim2/bin/python'
let g:python3_host_prog = '/Users/kevin/.local/share/virtualenvs/neovim3/bin/python'

" Adjust zenburn's garish search/visual colors.
hi IncSearch guifg=NONE guibg=#545449
hi Search    guifg=NONE guibg=#545449
hi Visual    guifg=NONE guibg=#444444
hi VisualNOS guifg=NONE guibg=#444444
hi IndentGuidesOdd  guibg=#353535
hi IndentGuidesEven guibg=#494949

"adjust YCM menu
hi Pmenu guifg=NONE guibg=#444444

omap <silent> iw <Plug>CamelCaseMotion_iw
xmap <silent> iw <Plug>CamelCaseMotion_iw
omap <silent> ib <Plug>CamelCaseMotion_ib
xmap <silent> ib <Plug>CamelCaseMotion_ib
omap <silent> ie <Plug>CamelCaseMotion_ie
xmap <silent> ie <Plug>CamelCaseMotion_ie
map <silent> w <Plug>CamelCaseMotion_w
map <silent> W <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> E <Plug>CamelCaseMotion_ge
sunmap w
sunmap W
sunmap e
sunmap E

" remap the Home key to behave like ^
map <Home> ^
imap <Home> <Esc>^i

" tab navigation
nmap <C-S-tab> :tabprevious<cr>
nmap <C-tab> :tabnext<cr>
map <C-S-tab> :tabprevious<cr>
map <C-tab> :tabnext<cr>
imap <C-S-tab> <ESC>:tabprevious<cr>i
imap <C-tab> <ESC>:tabnext<cr>i
nmap <C-t> :tabnew<cr>
imap <C-t> <ESC>:tabnew<cr>

" Remap omni-complete
inoremap <C-Space> <C-x><C-o>

nnoremap <C-p> :Files<CR>

function TrimWhiteSpace()
  %s/\s*$//
  ''
:endfunction

" Map the F2 key to the clean white space command
map <F2> :call TrimWhiteSpace()<CR>
map! <F2> :call TrimWhiteSpace()<CR>


set wildignore+=*.swp,*.swo,*.swn,*.pyc
set rtp+=/usr/local/opt/fzf

" Go specific settings
augroup go
  au!
  au FileType go setlocal noexpandtab
augroup END

noremap <Space> :call NERDComment("n", "Toggle")<cr>

let python_highlight_all = 1
let mapleader = ','
let g:NERDChristmasTree=1 " more colorful NERDTree

autocmd FileType typescript setlocal completeopt+=menu,preview

" enable True Color support in terminal
set termguicolors
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 1
let &colorcolumn = &wrapmargin
hi ColorColumn guibg=#4E4E4E

let g:indent_guides_auto_colors = 0

" Need this for vim commit editing to make backspace work for some reason
set backspace=indent,eol,start

if has("gui_vimr")
  nmap <D-S-{> :tabprevious<cr>
  nmap <D-S-}> :tabnext<cr>
  map <D-S-{> :tabprevious<cr>
  map <D-S-}> :tabnext<cr>
  imap <D-S-{> <ESC>:tabprevious<cr>i
  imap <D-S-}> <ESC>:tabnext<cr>i
endif
