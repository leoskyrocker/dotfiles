" YARTR "
 let s:yartr_path=expand('<sfile>:p:h')

 map <Leader>t :call YartrRunTestSingle()<CR>
 map <Leader>T :call YartrRunTestAll()<CR>
 
 function! YartrRunTestSingle()
   normal |y$
   let current_line=@"
   let first_line_of_test_match=matchstr(current_line, 'def test.*')
   if empty(first_line_of_test_match)
     execute("?def test") | :normal wyw
     let test_name=@"
   else
     :normal wwyw
     let test_name=@"
   endif
   let file_path=expand('%:p')
   let cd_dir=matchstr(file_path, 'engines/[^/]*')
   let test_path= matchstr(file_path,'test/.*')
   let file_path=substitute(file_path, "/test/.*", "", "")
   execute "silent !osascript ".shellescape(s:yartr_path)."/yartr_lib/run_command 'cd '"file_path" ' && ruby -Itest ' "test_path" ' --name=' "test_name""
 endfunction
 
 function! YartrRunTestAll()
   let file_path=@%
   let cd_dir=matchstr(file_path, 'engines/[^/]*')
   let test_path= matchstr(file_path,'test/.*')
   let file_path=substitute(file_path, "/test/.*", "", "")
   execute "silent !osascript ".shellescape(s:yartr_path)."/yartr_lib/run_command 'cd '"file_path" ' && ruby -Itest ' "test_path""
 endfunction

" Functions "
 function! RestoreSession()
   if argc() == 0 "vim called without arguments
     execute 'source ~/.nvim/Session.vim'
   end
 endfunction

 function! OnVimLeave()
   execute 'tabdo NERDTreeClose'
   mksession! ~/.nvim/Session.vim
 endfunction

 function! SetupVAM()
   let c = get(g:, 'vim_addon_manager', {})
   let g:vim_addon_manager = c
   let c.plugin_root_dir = expand('$HOME', 1) . '/.vim/vim-addons'
   let &rtp.=(empty(&rtp)?'':',').c.plugin_root_dir.'/vim-addon-manager'
   if !isdirectory(c.plugin_root_dir.'/vim-addon-manager/autoload')
     execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '
         \       shellescape(c.plugin_root_dir.'/vim-addon-manager', 1)
   endif
   call vam#ActivateAddons([], {'auto_install' : 0})
 endfun

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   Plugins!
"                               Managed with VAM
"                https://github.com/MarcWeber/vim-addon-manager
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Startup "
 set nocompatible | filetype indent plugin on | syn on
 let g:vim_addon_manager = {}
 let g:vim_addon_manager.shell_commands_run_method='system'

 call SetupVAM()
 " use <c-x><c-p> to complete plugin names

 " My plugin declarations
 VAMActivate ag
"  VAMActivate ctrlp
 VAMActivate delimitMate
"  VAMActivate EasyMotion
 VAMActivate fugitive
 VAMActivate github:airblade/vim-gitgutter
 VAMActivate github:altercation/vim-colors-solarized
"  VAMActivate github:jelera/vim-javascript-syntax
 VAMActivate github:junegunn/fzf
 VAMActivate github:majutsushi/tagbar
 VAMActivate github:MarcWeber/vim-addon-local-vimrc
 VAMActivate github:nathanaelkane/vim-indent-guides
"  VAMActivate github:pangloss/vim-javascript
 VAMActivate github:scrooloose/nerdtree
 VAMActivate github:tpope/vim-bundler
"  VAMActivate html5
"  VAMActivate molokai
 VAMActivate rails
 " VAMActivate Rubytest
"  VAMActivate rust
"  VAMActivate Syntastic
 VAMActivate Tabular
 VAMActivate tComment
"  VAMActivate trailing-whitespace
 VAMActivate UltiSnips
 VAMActivate vim-airline
 VAMActivate vim-coffee-script
 VAMActivate vim-ruby
 VAMActivate vim-snippets
 " VAMActivate YouCompleteMe
 " VAMActivate github:sjl/gundo.vim

" Autocmd "
 autocmd VimEnter * nested call RestoreSession()
 autocmd VimLeave * call OnVimLeave()
 autocmd BufLeave,CursorHold,CursorHoldI,FocusLost * silent! wa " autocmdto save

" Mappings "

 " Add keyboard shortcuts
 map <C-Tab> gt
 map <C-S-Tab> gT
 " ctags opens in new tab
 :nnoremap <silent><Leader><C-]> <C-w><C-]><C-w>T
 nnoremap ; :
 map <NUL> :NERDTreeToggle<CR>
 nmap <C-f> :NERDTreeFind<CR>
 nmap <c-p> :FZF<cr>
 map <C-c> :.!pbcopy<cr>u
 nmap <C-e> :TagbarToggle<CR>

" Set vars "
 set rtp+=~/.fzf
 set backspace=indent,eol,start
 set tags=./tags,tags;$HOME
 set background=light
 colorscheme solarized
 set number
 set updatetime=750
 set sessionoptions-=options  " Don't save options
 set mouse=a
 " Persistent undo
 set undofile
 set undodir=$HOME/.vim/undo
 set undolevels=1000
 set undoreload=10000

 "Ruby standards
 set shiftwidth=2
 set tabstop=2

"  set cursorline
"  set cursorcolumn
 set expandtab
 set autoindent " always set autoindenting on
 set pastetoggle=<F2>

" Application Specific "
 "*** ctrlp ****
  let g:ctrlp_max_depth = 30
  let g:ctrlp_max_files = 0
  let g:ctrlp_follow_symlinks = 1
  let g:ctrlp_clear_cache_on_exit = 0
 "*** NERDTree ****
  let NERDTreeChDirMode=2
 "*** airline ****
  " Just show the filename (no path) in the tab
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#fnamemod = ':t'
  let g:airline#extensions#tabline#fnametruncate = 14
  let g:airline#extensions#tabline#show_tab_nr = 1
  let g:airline#extensions#tabline#show_tabs = 1
  let g:airline#extensions#tabline#tab_nr_type = 1 "tab number type is tab number
