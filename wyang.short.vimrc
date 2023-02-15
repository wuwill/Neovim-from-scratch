set tabstop=4
set shiftwidth=4
set expandtab

" tab switch buffers
nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>

" =============== Shortcut mappings ===============
" {{{
" nnoremap ; :
" nnoremap q; q:
" nnoremap @; @:
" nnoremap '; ':
" nnoremap sl ;
" nnoremap sh ,
" nnoremap ' "
" nnoremap " '

" Quickly get out of insert mode without your fingers having to leave the
" inoremap kj <C-o>
" inoremap jj <Esc>
 " inoremap <C-J> <Esc>
" inoremap jk <c-n>
" inoremap jl <ESC>la
inoremap \fd <C-R>=expand("%:p")<CR>
inoremap \fn <C-R>=expand("%:t")<CR>
inoremap \ff <C-R>=expand("%:p:h")<CR>

" nnoremap <leader>/ /\v
" vnoremap <leader>/ /\v
"
" " get information
" nnoremap <silent> sdt :set ft?<CR>
" nnoremap <silent> sds :pwd<CR>
" nnoremap <silent> sdy :let @*=expand("%")<CR>
" nnoremap <silent> sdY :let @*=expand("%:p")<CR>
" nnoremap <silent> sdm :lcd %:h<CR>:pwd<CR>
" }}}

" ================ Folds ============================
" {{{
set foldnestmax=3       "deepest fold is 3 levels
set foldenable                  " enable folding
set foldcolumn=0                " add a fold column
set foldmethod=marker           " detect triple-{ style fold markers
set foldlevelstart=99           " start out with everything folded
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
                                " which commands trigger auto-unfold
function! MyFoldText()
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - 4
    return line . ' ?' . repeat(" ",fillcharcount) . foldedlinecount . ' '
endfunction
set foldtext=MyFoldText()

nnoremap zm zMzz
nnoremap <Space><Space> za
vnoremap <Space><Space> za
nnoremap za zA

nnoremap <silent> <leader>zj :call NextClosedFold('j')<cr>
nnoremap <silent> <leader>zk :call NextClosedFold('k')<cr>
function! NextClosedFold(dir)
    let cmd = 'norm!z' . a:dir
    let view = winsaveview()
    let [l0, l, open] = [0, view.lnum, 1]
    while l != l0 && open
        exe cmd
        let [l0, l] = [l, line('.')]
        let open = foldclosed(l) < 0
    endwhile
    if open
        call winrestview(view)
    endif
endfunction

nnoremap <silent> zh [z
nnoremap <silent> zl ]z
nmap <F6> /}<CR>zf%<ESC>:nohlsearch<CR>
" }}}

" =============== moving ===============
"{{{
" Don't move on *
" nnoremap * *<c-o>
"
" " Center when jumping around
" nnoremap g; g;zz
" nnoremap g, g,zz
" nnoremap <c-o> <c-o>zz
" nnoremap <c-i> <c-i>zz

" Easier to type, and I never use the default behavior.
noremap gh ^
" noremap gl $
vnoremap gh ^
" vnoremap gl g_
" vnoremap gs "ay:new<CR>"ap:w! ~/GDrive/local/shared_cp.txt<CR>:bde<CR>
" nnoremap gs :. w! ~/GDrive/local/shared_cp.txt<CR>
" command! SS read ~/GDrive/local/shared_cp.txt
" inoremap <c-a> <home>
" inoremap <c-e> <end>
" cnoremap <c-a> <home>
" cnoremap <c-e> <end>
" cnoremap <C-p> <Up>
" cnoremap <C-n> <Down>

" Speed up scrolling of the viewport slightly
" nnoremap <C-e>e 8<C-e>
" nnoremap <C-y>y 8<C-y>
"
" " Remap j and k to act as expected when used on long, wrapped, lines
" nnoremap j gj
" nnoremap k gk
" noremap gj j
" noremap gk k
"
" map [[ ?{<CR>w99[{
" map ][ /}<CR>b99]}
" map ]] j0[[%/{<CR>
" map [] k$][%?}<CR>
"}}}

" =============== editing ====================
" {{{
" make p in Visual mode replace the selected text with the yank register
" vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" Use ,d (or ,dd or ,dj or 20,dd) to delete a line without adding it to the
" yanked stack (also, in visual mode)
" nnoremap <silent> <leader>d "*d
" vnoremap <silent> <leader>d "*d

" Quick yanking to the end of the line
nnoremap Y y$

" Yank/paste to the OS clipboard with ,y and ,p
" noremap <leader>y "*y
" noremap <leader>p :set paste<CR>"*p<CR>:set nopaste<CR>
" noremap <leader>P :set paste<CR>"*P<CR>:set nopaste<CR>
" vnoremap <leader>y "*ygv
" set clipboard+=unnamed
"
" " Reselect text that was just pasted with ,v
" nnoremap <leader>v V`]
"
" " move to the next position when doing spell check
" nnoremap ]s ]sz=
" nnoremap [s [sz=
"
" " Complete whole filenames/lines with a quicker shortcut key in insert mode
" inoremap <C-f> <C-x><C-f>
" inoremap <C-l> <C-x><C-l>
"
" Select entire buffer
nnoremap vaa ggvGg_
nnoremap Vaa ggVG
nnoremap val 0v$
nnoremap val ^vg_

" Quick alignment of text
" nnoremap <leader>al :left<CR>
" nnoremap <leader>ar :right<CR>
" nnoremap <leader>ac :center<CR>

" Split line (sister to [J]oin lines)
" The normal use of S is covered by cc, so don't worry about shadowing it.
" nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" Use Q for formatting the current paragraph (or visual selection)
" vnoremap Q gq
" nnoremap Q gqap
" " format the entire file
" nnoremap <leader>fef ggVG=
"
" " upper/lower word
" nnoremap <leader>u mQviwU`Q
" nnoremap <leader>l mQviwu`Q
"
" " upper/lower first char of word
" nnoremap <leader>U mQgewvU`Q
" nnoremap <leader>L mQgewvu`Q
"
" " Map command-[ and command-] to indenting or outdenting
" " while keeping the original selection in visual mode
" vnoremap <C+D-]> >gv
" vnoremap <C+D-[> <gv
"
" nnoremap <C+D-]> >>
" nnoremap <C+D-[> <<
"
" onoremap <C+D-]> >>
" onoremap <C+D-[> <<
"
" inoremap <C+D-]> <Esc>>>i
" inoremap <C+D-[> <Esc><<i
"
" " Insert the current directory into a command-line path
" cnoremap <C+D-P> <C-R>=expand("%:p:h") . "/"<CR>

" }}}

" =============== Filetype specific handling  ===============
" {{{
" only do this part when compiled with support for autocommands
if has("autocmd")
    au BufNewFile,BufRead *.hr set filetype=r
    au BufNewFile,BufRead *.r set filetype=r
    au BufNewFile,BufRead *.R set filetype=r
endif
" }}}

" =============== Next and Last ===============
" {{{
" Motion for "next/last object". For example, "din(" would go to the next "()"
" pair and delete its contents.


" }}}


" new config based on 'practicle vim {{{
" nnoremap & :&&<CR>
" xnoremap & :&&<CR>
" " "  }}}
" "
" "  visual start {{{
" xnoremap * :<C-u>call<SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
" xnoremap # :<C-u>call<SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>
" function! s:VSetSearch()
"     let temp = @s
"     norm! gv"sy
"     let @/ ='\V'. substitute(escape(@s,'/\'),'\n','\\n','g')
"     let @s = temp
" endfunction
" "  }}}


"{{{
" hi Normal guibg=NONE ctermbg=NONE
" highlight Comment cterm=italic gui=italic
" set rnu
set termguicolors
colorscheme onenord
" set background=light
let iterm_profile = $ITERM_PROFILE
" if iterm_profile == "Dark"
"     set background=dark
" else
"     set background=light
" endif

" highlight Comment cterm=italic gui=italic
" if has("statusline") && !&cp
"   set laststatus=2  " always show the status bar
"
"   " Start the status line
"   set statusline=%F%m\ %r
"   set statusline+=%=[%l/%L]-%p%%
"   set statusline+=\ C%v\
"   set statusline+=B%n
"   "set statusline+=%{&fo}
" endif
" set termencoding=utf-8
" set encoding=utf-8
" set lazyredraw                  " don't update the display while executing macros
" set laststatus=2                " tell VIM to always put a status line in, even
"                                 "    if there is only one window
set cmdheight=1                 " use a status bar that is 2 rows high
set showcmd                     " show (partial) command in the last line of the screen
set nomodeline                  " disable mode lines (security measure)
" set cursorline                  " underline the current line, for quick orientation
" set ttyfast
"
" set synmaxcol=800 " Don't try to highlight lines longer than 800 characters.
" au FocusLost * :silent! wall " Save when losing focus
" au VimResized * :wincmd = " Resize splits when the window is resized
" }}}
"
" Test plugin configs
" vnoremap ss <Plug>(ripple_send_selection)
" nnoremap ss <Plug>(ripple_send_line)
"
" function! Remove_leading_whitespaces(code)
"     " Check if the first line is indented
"     let leading_spaces = matchstr(a:code, '^\s\+')
"
"     if leading_spaces == ""
"         return a:code
"     endif
"
"     " Calculate indentation
"     let indentation = strlen(leading_spaces)
"
"     " Remove further indentations
"     return substitute(a:code, '\(^\|\r\zs\)\s\{'.indentation.'}', "", "g")
" endfunction
"
" " Add filter to REPL configuration
" let g:ripple_repls = {}
" let g:ripple_repls["python"] = {
"     \ "command": "python",
"     \ "pre": "",
"     \ "post": "",
"     \ "addcr": 1,
"     \ "filter": 0,
"     \ }
" let g:ripple_repls["python"]["filter"] = function('Remove_leading_whitespaces')
" let g:ripple_repls["r"] = {
"     \ "command": "R --vanilla",
"     \ "pre": "",
"     \ "post": "",
"     \ "addcr": 1,
"     \ "filter": 0,
"     \ }
" let g:ripple_repls["sh"] = {
"     \ "command": "zsh",
"     \ "pre": "",
"     \ "post": "",
"     \ "addcr": 1,
"     \ "filter": 0,
"     \ }

" Automatically switch light/dark background + theme
" function! SetAppearance(...)
"   try
"     let s:mode = systemlist("defaults read -g AppleInterfaceStyle")[0]
"     let s:new_bg = ""
"     let s:new_theme = ""
"     if s:mode ==? "Dark"
"       let s:new_bg = "dark"
"       " let s:new_theme = "base16-unikitty-dark"
"     else
"       let s:new_bg = "light"
"       " let s:new_theme = "base16-unikitty-light"
"     endif
"     if &background !=? s:new_bg
"       let &background = s:new_bg
"       " execute 'colorscheme '.s:new_theme
"     endif
"   catch
"     " Ignore errors
"   endtry
" endfunction
" call SetAppearance()
" call timer_start(2000, "SetAppearance", {"repeat": -1})

if strftime("%H") > 9 && strftime("%H") < 16
  set background=light
else
  set background=dark
endif
