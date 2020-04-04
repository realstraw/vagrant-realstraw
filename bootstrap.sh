echo "Update everthing to the latest..."
pacman -Syu --noconfirm

echo "Install the necessary packages..."
pacman -S --noconfirm \
    base-devel \
    aws-cli \
    terraform \
    neovim \
    git \
    zsh \
    tmux

echo "Generating the script to configure vagrant user..."

cat > configure_me << SCRIPT
#!/usr/bin/env bash
echo "Apply upstream configurations..."
rm -rf upstream-src
mkdir -p upstream-src

echo "- Configuring tmux..."
git clone git@github.com:realstraw/dot-tmux.git upstream-src/dot-tmux
upstream-src/dot-tmux/bootstrap.sh
SCRIPT

chown vagrant:vagrant configure_me
chmod +x configure_me
