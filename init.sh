# browser downloads chrome

sudo snap install --classic cmake code nvim \
	# curl # snap curl has some permission problem
sudo snap install yt-dlp htop aria2c \
	universal-ctags # for tagbar
sudo apt install -y g++ git python3-pip tmux mpv curl direnv openssh-server pkg-config \
	sysstat     # for tmux-cpu
	nodejs npm  # for coc.vim
	silversearcher-ag # for ctrlp
sudo pip3 install --user --upgrade conan ninja

echo "eval \"$(direnv hook bash)\"" >> ~/.bashrc

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install cargo-watch \
  cargo-modules   \ # show overview of a crate's modules
  cargo-nextest   \
  cargo-audit     \ # create security vulnerabilities report
  cargo-tarpaulin \ # code coverage
  cargo-expand    \ # macro expansion


cp -r /mnt/hgfs/Z/software/_ssh/_ssh ~/.ssh
sudo chmod 600 ~/.ssh/id_rsa*

gpg --import /mnt/hgfs/Z/software/github_gpg.key

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

CFGDIR=~/repo/ubuntu-setup

mkdir -p $XDG_CONFIG_HOME/git
ln -s $CFGDIR/_gitconfig $XDG_CONFIG_HOME/git/config
ln -s $CFGDIR/_gitignore $XDG_CONFIG_HOME/git/ignore

mkdir -p $XDG_CONFIG_HOME/tmux
ln -s $CFGDIR/_tmux.conf $XDG_CONFIG_HOME/tmux/tmux.conf

mkdir -p $XDG_CONFIG_HOME/yt-dlp
ln -s $CFGDIR/_yt-dlp.conf $XDG_CONFIG_HOME/yt-dlp/config

mkdir -p $XDG_CONFIG_HOME/nvim/syntax
ln -s $CFGDIR/vim-files/hobbes.vim $XDG_CONFIG_HOME/nvim/syntax/hobbes.vim
ln -s $CFGDIR/vim-files/init.vim $XDG_CONFIG_HOME/nvim/init.vim

ln -s $CFGDIR/code_settings.json $XDG_CONFIG_HOME/Code/User/settings.json

nvim +PlugInstall +qall
nvim +'CocInstall coc-spell-checker'
nvim +'CocInstall coc-explorer'
nvim +'CocInstall coc-clangd'
nvim +'CocInstall coc-rust-analyzer'
nvim a.cpp +'CocCommand clangd.install'
