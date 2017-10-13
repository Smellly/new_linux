if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"
 endif
"传说中的去掉边框用下边这一句
set go=
"设置配色，这里选择的是desert，也有其他方案，在vim中输入:color 在敲tab键可以查看
color desert
"设置背景色，每种配色有两种方案，一个light、一个dark
set background=light
"打开语法高亮
syntax on
"显示行号
set number
"设置缩进有三个取值cindent(c风格)、smartindent(智能模式，其实不觉得有什么智能)、autoind
set cindent
set backspace=indent,eol,start
"用空格键替换制表符
:set expandtab
"制表符占4个空格
set tabstop=4
"默认缩进4个空格大小
set shiftwidth=4
"增量式搜索
set incsearch
"高亮搜索
set hlsearch
"有时中文会显示乱码，用一下几条命令解决
let &termencoding=&encoding
set fileencodings=utf-8,gbk
"很多插件都会要求的配置检测文件类型
:filetype on
:filetype plugin on
:filetype indent on
"下边这个很有用可以根据不同的文件类型执行不同的命令
"例如：如果是c/c++类型
:autocmd FileType c,cpp : set foldmethod=syntax
:autocmd FileType c,cpp :set number
:autocmd FileType c,cpp :set cindent
"例如：如果是python类型
:autocmd FileType python :set number
:autocmd FileType python : set foldmethod=syntax
:autocmd FileType python :set smartindent

" vundle 环境设置
filetype off
set rtp+=/data/users/jaycshen/.vim/bundle/Vundle.vim
" vundle 管理的插件列表必须位于 vundle#begin() 和 vundle#end() 之间
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
" Plugin 'Valloric/YouCompleteMe'
Plugin 'wakatime/vim-wakatime'
Plugin 'jiangmiao/auto-pairs'
Plugin 'Yggdroot/indentLine'
" 插件列表结束
call vundle#end()
filetype plugin indent on

map <F4> :call TitleDet()<CR>

function AddTitle()
  call append(0, "# -*- coding: utf-8 -*-")
  call append(1, "'''")
  call append(2, "\/\/ Author: Jay Shen.")
  call append(3, "\/\/ Last modify: ".strftime("%Y-%m-%d %H:%M:%S"."."))
  call append(4, "\/\/ File name: ".expand("%:t"))
  call append(5, "\/\/")
  call append(6, "\/\/ Description:")
  call append(7, "'''")
  "echohl WarningMsg | echo "Successful in adding file title." | echohl None
endfunction

function UpdateTitle()
  normal m'
  execute '/ *Last modify:/s@:.*$@\=strftime(": %Y-%m-%d %H:%M:%S")."."@'
  normal ''
  normal mk
  execute '/ *File name:/s@:.*$@\=": ".expand("%:t")@'
  execute "noh"
  normal 'k
  "echohl WarningMsg | echo "Successful in updating file title." | echohl None
endfunction

function TitleDet()
  let n = 1
  while n < 10
    let line = getline(n)
    if line =~'\/\/\sLast\_smodify:'
    ¦ call UpdateTitle()
    ¦ return
    endif
    let n = n + 1
  endwhile
  call AddTitle()
endfunction
