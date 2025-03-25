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
   let file_path=expand('%:p')
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
   let c.plugin_root_dir = expand('$HOME', 1) . '/.nvim/vim-addons'
   let &rtp.=(empty(&rtp)?'':',').c.plugin_root_dir.'/vim-addon-manager'
   if !isdirectory(c.plugin_root_dir.'/vim-addon-manager/autoload')
     execute '!git clone --depth=1 git@github.com:MarcWeber/vim-addon-manager.git '
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
 VAMActivate github:benekastah/neomake
 VAMActivate github:jelera/vim-javascript-syntax
 VAMActivate github:junegunn/fzf
 VAMActivate github:majutsushi/tagbar
 VAMActivate github:leafgarland/typescript-vim
 VAMActivate github:mxw/vim-jsx
 VAMActivate github:MarcWeber/vim-addon-local-vimrc
 VAMActivate github:nathanaelkane/vim-indent-guides
"  VAMActivate github:pangloss/vim-javascript
 VAMActivate github:scrooloose/nerdtree
 VAMActivate github:tpope/vim-bundler
 VAMActivate github:tpope/vim-rhubarb
"  VAMActivate html5
"  VAMActivate molokai
 VAMActivate rails
"  VAMActivate Rubytest
"  VAMActivate rust
"  VAMActivate Syntastic
 VAMActivate Tabular
 VAMActivate tComment
 VAMActivate trailing-whitespace
 VAMActivate UltiSnips
 VAMActivate vim-airline
 VAMActivate github:vim-airline/vim-airline-themes
 VAMActivate vim-coffee-script
 VAMActivate vim-ruby
 VAMActivate vim-snippets
 " VAMActivate YouCompleteMe
 " VAMActivate github:sjl/gundo.vim

" Autocmd "
 autocmd VimEnter * nested call RestoreSession()
 autocmd VimLeave * call OnVimLeave()
"  autocmd BufLeave,CursorHold,CursorHoldI,FocusLost * silent! wa " autocmdto save

" Mappings "

 " Add keyboard shortcuts
 :map <C-Tab> gt
 :map <C-S-Tab> gT
 " ctags opens in new tab
 :map <NUL> :NERDTreeToggle<CR>
 :map <C-c> :.!pbcopy<cr>u
 :map <C-f> :NERDTreeFind<CR>
 :map <C-p> :FZF -m<cr>
 :map <C-e> :TagbarToggle<CR>
 :nnoremap <silent><Leader><C-]> <C-w><C-]><C-w>T
 :nnoremap ; :
 " windows navigation
 :nnoremap ∑ <C-w><C-w>
 :nnoremap ˙ <C-w>h
 :nnoremap ∆ <C-w>j
 :nnoremap ˚ <C-w>k
 :nnoremap ¬ <C-w>l

 " Set vars "
 set rtp+=~/.fzf
 set backspace=indent,eol,start
"  set tags=./tags,tags;$HOME
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
 set nosmarttab
 set expandtab
 set autoindent " always set autoindenting on
 set pastetoggle=<F2>
 set clipboard=unnamed
 set ignorecase " smartcase MUST BE used with ignorecase
 set smartcase

" Application Specific "
 "*** ctrlp ****
  let g:ctrlp_max_depth = 30
  let g:ctrlp_max_files = 0
  let g:ctrlp_follow_symlinks = 1
  let g:ctrlp_clear_cache_on_exit = 0
 "*** NERDTree ****
  let NERDTreeShowHidden=1
  let NERDTreeChDirMode=2
  let NERDTreeQuitOnOpen=1
  let NERDTreeMinimalUI=1
 "*** airline ****
  let g:airline#extensions#default#layout = [
    \ [ 'a', 'b', 'c' ],
    \ [ 'x', 'y', 'z', 'warning' ]
    \ ]
  let g:airline_left_sep = ''
  let g:airline_right_sep = ''
  let g:airline_section_b = ''
  let g:airline_section_c = '%f'
  let g:airline_section_x = airline#section#create(['tagbar'])
  let g:airline_section_y = '%p%%'
  let g:airline_section_z = ''
  let g:airline_skip_empty_sections = 1
  let g:airline#extensions#tabline#enabled = 1
  "" Just show the filename (no path) in the tab
  " let g:airline#extensions#tabline#fnamemod = ':t'
  let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
  let g:airline#extensions#tabline#fnametruncate = 10
  " let g:airline#extensions#tabline#left_sep = ''
  " let g:airline#extensions#tabline#left_alt_sep = ''
  " let g:airline#extensions#tabline#right_sep = ''
  " let g:airline#extensions#tabline#right_alt_sep = ''
  let g:airline#extensions#tabline#show_buffers = 0
  let g:airline#extensions#tabline#show_splits = 0
  let g:airline#extensions#tabline#show_tabs = 1
  let g:airline#extensions#tabline#show_tab_nr = 1
  let g:airline#extensions#tabline#show_tab_type = 0
  let g:airline#extensions#tabline#tab_nr_type = 1 "tab number type is tab number

  let g:neomake_ruby_enabled_makers = ['rubocop']
  let g:neomake_javascript_enabled_makers = ['eslint']
  let g:neomake_javascript_eslint_exe = system('PATH=$(npm bin):$PATH && which eslint | tr -d "\n"')
  let g_neomake_typescript_tslint_maker = {
  \ 'exe': 'tslint',
  \ 'args': ['-r', '/usr/local/lib/node_modules/tslint-jsdoc-rules/lib', '--experimentalDecorators']
  \ }
  let g:neomake_typescript_enabled_makers = ['tslint']

  let g:jsx_ext_required = 0

" Neovim ONLY
 " Windows navigation for terminal mode
 :tnoremap <Leader><Esc> <C-\><C-n>
 :tnoremap ∑ <C-\><C-n><C-w><C-w>
 :tnoremap ˙ <C-\><C-n><C-w>h
 :tnoremap ∆ <C-\><C-n><C-w>j

 :tnoremap ˚ <C-\><C-n><C-w>k
 :tnoremap ¬ <C-\><C-n><C-w>l

 autocmd BufWritePost * Neomake

 let g:python3_host_prog = '/Users/leolei/.pyenv/shims/python'
