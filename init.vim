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

" Pymode stuff
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


augroup make
  au!
  au FileType make setlocal noexpandtab shiftwidth=4 softtabstop=0
augroup END


noremap <Space> :call NERDComment("n", "Toggle")<cr>

let python_highlight_all = 1
let mapleader = ','
let g:NERDChristmasTree=1 " more colorful NERDTree

autocmd FileType typescript setlocal completeopt+=menu,preview
au BufWritePost *.ts,*.html,*.json,*.js silent !/Users/kevin/code/tbcode/tbjs/node_modules/.bin/prettier --loglevel error --write %
au BufWritePost *.ts silent !cd /Users/kevin/code/tbcode/tbjs && /Users/kevin/code/tbcode/tbjs/node_modules/.bin/eslint --plugin 'simple-import-sort' --parser '@typescript-eslint/parser' --fix --no-eslintrc --rule '"simple-import-sort/sort": [ "error", { "groups": [ ["^\\u0000"], ["^@?\\w"], ["^@tb/.*"], ["^\\."] ] } ]' %:p
au BufWritePost *.bazel,*.star,WORKSPACE silent !/usr/local/bin/buildifier %
au BufWritePost *.rs silent !/Users/kevin/.cargo/bin/rustfmt %

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

" https://unix.stackexchange.com/a/383044
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
" https://stackoverflow.com/questions/52780939/disable-vim-e211-file-no-longer-available
:autocmd FileChangedShell * execute
" https://stackoverflow.com/a/37889460
autocmd FileType python setlocal indentkeys-=<:>
autocmd FileType python setlocal indentkeys-=:

nnoremap <Leader>g :silent lgrep<Space>
nnoremap <silent> [f :lprevious<CR>
nnoremap <silent> ]f :lnext<CR>

let g:deoplete#enable_at_startup = 1

" Required for operations modifying multiple buffers like rename.
set hidden
let g:LanguageClient_serverCommands = {
  \ 'python': ['/Users/kevin/.local/share/virtualenvs/python-language-server/bin/pyls'],
  \ 'typescript': ['/usr/local/bin/typescript-language-server', '--stdio'],
  \ }
let g:LanguageClient_useVirtualText = "No"
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition({ 'gotoCmd': 'tabnew' })<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
"let g:LanguageClient_loggingFile = '/tmp/LanguageClient.log'
"let g:LanguageClient_loggingLevel = 'INFO'
"let g:LanguageClient_serverStderr = '/tmp/LanguageServer.log'
set signcolumn=yes
nnoremap <Leader>k  :tabnext<CR>
nnoremap <Leader>j  :tabprev<CR>

if executable("rg")
  set grepprg=rg\ -s\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
