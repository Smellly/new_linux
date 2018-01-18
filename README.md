# new_linux
迁移到一个新的 Linux 的准备

### vim8
卸载旧版 vim
```
dpkg -l | grep vim
# ii  vim-common                         2:7.4.1689-3ubuntu1.2             amd64        Vi IMproved - Common files
# ii  vim-tiny                           2:7.4.1689-3ubuntu1.2             amd64        Vi IMproved - enhanced vi editor - compact version
sudo apt remove --purge  vim-common vim-tiny
```
安装依赖项
```
sudo apt install gcc make libncurses5-dev git python-dev python3-dev build-essential cmake clang
```
下载 vim 源码
```
git clone --depth=1 https://github.com/vim/vim.git ~/vim8git
```
编译安装
```
cd ~/vim8git/
./configure --with-features=huge --enable-multibyte --enable-cscope --enable-pythoninterp=yes --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu --enable-python3interp=yes --with-python3-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu
make
sudo make install
```
检查。（+为支持，-为不支持）
```
vim --version | grep python
+cryptv          +linebreak       +python/dyn      +vreplace
+cscope          +lispindent      +python3/dyn     +wildignore
```
安装 Caffe prototxt 高亮插件  
```
cd ~/.vim/bundle
git clone git://github.com/chiphogg/vim-prototxt.git
```
下载YouCompleteMe
```
git clone --recursive https://github.com/Valloric/YouCompleteMe.git ~/.vim/bundle/YouCompleteMe
# 如果出现异常，进入 ~/.vim/bundle/YouCompleteMe 目录，重复下面的命令知道下载完整。
# git submodule update --init --recursive
```
编译
```
cd ~/.vim/bundle/YouCompleteMe
# 使用系统clang
# ./install.py --clang-completer --system-libclang
# 会自动下载clang
./install.py --clang-completer
```
下载vundle
```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```
记得修改 ```set rtp+=/home/yourname/.vim/bundle/Vundle.vim```路径

### zsh
```
sudo apt-get install zsh
```

### oh my zsh
via curl
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```
via wget
```
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
```

### tmux
```
sudo apt-get install tmux
```

### wakatime
记录码字的用时
Installing for zsh[](https://wakatime.com/terminal#install-zsh)
```
sudo pip install wakatime
```
```cd ~/.oh-my-zsh/custom/plugins && git clone https://github.com/wbinglee/zsh-wakatime.git```
 or however you manage your zsh plugins.

Edit your .zshrc file and add zsh-wakatime to oh-my-zsh plugins.

Make sure your [API key](https://wakatime.com/settings/api-key) is in your [~/.wakatime.cfg](https://github.com/wakatime/wakatime#configuring) file.

