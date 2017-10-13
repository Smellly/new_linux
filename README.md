# new_linux
迁移到一个新的 Linux 的准备

### vim
```
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/plugin/Vundle.vim
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

