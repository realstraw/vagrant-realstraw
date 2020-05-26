echo "Replace the mirrorlist..."
# To make sure use the most up to date versions
mirrorlist_file="/etc/pacman.d/mirrorlist"
if [ -f $mirrorlist_file ]; then
    mv $mirrorlist_file ${mirrorlist_file}.old
fi
cp /vagrant/root${mirrorlist_file} ${mirrorlist_file}

echo "Update everthing to the latest..."
pacman -Syu --noconfirm

echo "Install the necessary packages..."
pacman -S --noconfirm \
    base-devel \
    aws-cli \
    terraform packer \
    neovim \
    git \
    zsh \
    tmux \
    nodejs yarn npm \
    jdk8-openjdk \
    fzf fd

echo "Generating the script to configure vagrant user..."

cat > configure_me << SCRIPT
#!/usr/bin/env bash

echo "Apply upstream configurations..."
rm -rf upstream-src
mkdir -p upstream-src

echo "- Configuring tmux..."
git clone git@github.com:realstraw/dot-tmux.git upstream-src/dot-tmux
upstream-src/dot-tmux/bootstrap.sh

echo "- Configuring nvim..."
git clone git@github.com:realstraw/dot-nvim.git upstream-src/dot-nvim
upstream-src/dot-nvim/bootstrap.sh
SCRIPT

chown vagrant:vagrant configure_me
chmod +x configure_me
