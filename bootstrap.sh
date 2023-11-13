#!/usr/bin/env bash

set -euo pipefail

install_system_packages() {
  sudo snap install --classic nvim \
    # curl # snap curl has some permission problem
  sudo snap install yt-dlp htop aria2c
  sudo apt install -y g++ git python3-pip tmux mpv curl direnv openssh-server pkg-config cmake-format valgrind \
    sysstat     \ # for tmux-cpu
    nodejs npm  \ # for coc.vim
    silversearcher-ag  \ # for ctrlp
    cmake jinja
}

install_misc_sym_links() {
  # tmux
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  mkdir -p ~/tmux
  ln -s $PWD/_tmux.conf ~/tmux/tmux.conf

  # yt-dlp
  mkdir -p ~/yt-dlp
  ln -s $PWD/_yt-dlp.conf ~/yt-dlp/config
}

install_bash_env() {
  # .profile
  cat <<EOF>>~/.profile

  alias yt-dlp-list="yt-dlp -o '%(playlist_index)03d-%(title)s-%(id)s.%(ext)s'"
  alias vi="nvim"
  alias vim="nvim"
  alias vimdiff="nvim -d"
  alias view="nvim -R"
EOF
}

install_rust_env() {
  #curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  cargo install cargo-watch \
    cargo-modules   \ # show overview of a crate's modules
    cargo-nextest   \
    cargo-audit     \ # create security vulnerabilities report
    cargo-tarpaulin \ # code coverage
    cargo-expand    \ # macro expansion
}


install_nvim() {
  mkdir -p ~/nvim/syntax
  ln -s $PWD/vim-files/hobbes.vim ~/nvim/syntax/hobbes.vim
  ln -s $PWD/vim-files/init.vim ~/nvim/init.vim

  nvim +PlugInstall +qall
  nvim +'CocInstall coc-spell-checker'
  nvim +'CocInstall coc-explorer'
  nvim +'CocInstall coc-clangd'
  nvim +'CocInstall coc-rust-analyzer'
  nvim a.cpp +'CocCommand clangd.install'
}

install_system_packages
install_misc_sym_links
install_bash_env
install_rust_env
install_nvim
