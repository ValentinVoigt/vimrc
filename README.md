# My neovim config

Use the following code to install:

```
curl -o ~/.config/nvim/init.lua --create-dirs https://raw.githubusercontent.com/ValentinVoigt/vimrc/master/init.lua
```

Use the following to install neovim from source:

```
sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen
git clone https://github.com/neovim/neovim
cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
```
