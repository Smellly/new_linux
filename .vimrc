set encoding=utf-8
set termencoding=utf-8
" PEP8 要支持PEP8风格的缩进，请在.vimrc文件中添加下面的代码：
" 这些设置将让Vim中的Tab键就相当于4个标准的空格符，确保每行代码长度不超过80个字符，
" 并且会以unix格式储存文件，避免在推送到Github或分享给其他用户时出现文件转换问题。
au BufNewFile,BufRead *.py
\ set tabstop=4 |
\ set softtabstop=4 |
\ set shiftwidth=4 |
\ set textwidth=79 |
\ set expandtab |
\ set autoindent |
\ set fileformat=unix 

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

" for Plugin 'hdima/python-syntax'
let g:syntastic_python_checkers=['python3.7']
" for Plugin 'tmhedberg/SimpylFold'
let g:SimpylFold_docstring_preview=1
let python_highlight_all=1

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
:autocmd FileType python :set foldmethod=indent
:autocmd FileType python :set smartindent
autocmd BufNewFile *.py :call <SID>InsertPyFormat()

" vundle 环境设置
filetype off
set rtp+=/Users/jaycshen/.vim/bundle/Vundle.vim
" vundle 管理的插件列表必须位于 vundle#begin() 和 vundle#end() 之间
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'wakatime/vim-wakatime'
Plugin 'jiangmiao/auto-pairs'
Plugin 'Yggdroot/indentLine'
" Plugin 'chiphogg/vim-prototxt'
Plugin 'jnurmine/Zenburn'
Plugin 'powerline/powerline'
Plugin 'nvie/vim-flake8'
" syntastic not support py3
" Plugin 'scrooloose/syntastic'
Plugin 'hdima/python-syntax'
Plugin 'tmhedberg/SimpylFold'
"" 插件列表结束
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

function! <SID>GetYear()
	return strftime("%Y")
endfunction
function! <SID>GetFileName()
	let fname = expand("%")
	return fname
endfunction
function! <SID>GetDate()
	"windows
	let date = system("date /T")
	if (v:shell_error!=0)
		"linux
		let date = system("date +\"%Y/%m/%d %H:%M:%S\" ")
	endif

	if (date[strlen(date)-1]=="\n")
		let date = strpart(date, 0, strlen(date)-1)
	endif
	return date
endfunction
function! <SID>GetPyDocFileHeader(leading_blank)
    let doc = "#!/usr/bin/env python\n"
    let doc = doc. a:leading_blank."# -*- coding: utf-8 -*-\n"
    let doc = doc. a:leading_blank."########################################################################\n"
    let doc = doc. a:leading_blank."# \n"
    let doc = doc. a:leading_blank."# Copyright (c) ".<SID>GetYear()." Jaycshen. All Rights Reserved\n"
    let doc = doc. a:leading_blank."# \n"
    let doc = doc. a:leading_blank."########################################################################\n"
    let doc = doc. a:leading_blank." \n"
    let doc = doc. a:leading_blank."\"\"\"\n"
    let doc = doc. a:leading_blank."File: ".<SID>GetFileName()."\n"
    let doc = doc. a:leading_blank."Author: schenxmu@gmail.com\n"
    let doc = doc. a:leading_blank."Date: ".<SID>GetDate()."\n"
    let doc = doc. a:leading_blank."\"\"\"\n"
    " let doc = doc. a:leading_blank."import sys, os\nsys.path.append(os.path.dirname(os.getcwd()))\n"
    let doc = doc. a:leading_blank." \n"
    let doc = doc. a:leading_blank."if __name__ == \"__main__\":\n"
    let doc = doc. a:leading_blank."    pass\n"
    " let doc = doc. a:leading_blank."    import inspect, sys\n"
    " let doc = doc. a:leading_blank."    current_module = sys.modules[__name__]\n"
    " let doc = doc. a:leading_blank."    funnamelst = [item[0] for item in inspect.getmembers(current_module, inspect.isfunction)]\n"
    " let doc = doc. a:leading_blank."    if len(sys.argv) > 1:\n"
    " let doc = doc. a:leading_blank."        index = 1\n"
    " let doc = doc. a:leading_blank."        while index < len(sys.argv):\n"
    " let doc = doc. a:leading_blank."            if '--' in sys.argv[index]:\n"
    " let doc = doc. a:leading_blank."   	            index += 2\n"
    " let doc = doc. a:leading_blank."            else:\n"
    " let doc = doc. a:leading_blank."                break\n"
    " let doc = doc. a:leading_blank."        func = getattr(sys.modules[__name__], sys.argv[index])\n"
    " let doc = doc. a:leading_blank."        func(*sys.argv[index+1:])\n"
    " let doc = doc. a:leading_blank."    else:\n"
    " let doc = doc. a:leading_blank."        print >> sys.stderr, '\t'.join((__file__, \"/\".join(funnamelst), \"args\"))\n"
    return doc
endfunction
function! <SID>GetDoxFH(type)
	let l:synopsisLine=line(".")+1
    let l:synopsisCol=col(".")

	let cur_line = line(".")
    let first_line = getline(cur_line)
	let leading_blank = matchstr(first_line, '\(\s*\)')
	if (a:type == 4)
		let doc = <SID>GetPyDocFileHeader(leading_blank)
	endif
	if (strlen(doc)>0)
		let idx =1
		let li = <SID>GetNthItemFromList(doc, idx, "\n")
		while (strlen(li)>0)
			call append( cur_line-1, li.expand("<CR>"))
			let idx = idx + 1
			let cur_line = cur_line + 1
			let li = <SID>GetNthItemFromList(doc, idx, "\n")
		endwhile
	endif
    exec l:synopsisCol
    exec "normal " . l:synopsisCol . "|"
    startinsert!
endfunction
function! <SID>InsertPyFormat()
  call <SID>GetDoxFH(4)
  call cursor(16, 1)
endfunction
" Function : GetNthItemFromList (PRIVATE)
" Purpose  : Support reading items from a comma seperated list
"            Used to iterate all the extensions in an extension spec
"            Used to iterate all path prefixes
" Args     : list -- the list (extension spec, file paths) to iterate
"            n -- the extension to get
" Returns  : the nth item (extension, path) from the list (extension
"            spec), or "" for failure
" Author   : Michael Sharpe <feline@irendi.com>
" History  : Renamed from GetNthExtensionFromSpec to GetNthItemFromList
"            to reflect a more generic use of this function. -- Bindu
function! <SID>GetNthItemFromList(list, n, sep)
   let itemStart = 0
   let itemEnd = -1
   let pos = 0
   let item = ""
   let i = 0
   while (i != a:n)
      let itemStart = itemEnd + 1
      let itemEnd = match(a:list, a:sep, itemStart)
      let i = i + 1
      if (itemEnd == -1)
         if (i == a:n)
            let itemEnd = strlen(a:list)
         endif
         break
      endif
   endwhile
   if (itemEnd != -1)
      let item = strpart(a:list, itemStart, itemEnd - itemStart)
   endif
   return item
endfunction
