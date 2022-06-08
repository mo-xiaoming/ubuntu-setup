# browser downloads chrome

sudo snap install --classic code nvim \
	# curl # snap curl has some permission problem
sudo snap install yt-dlp htop aria2c \
	universal-ctags # for tagbar
sudo apt install -y g++ git python3-pip tmux mpv curl direnv openssh-server pkg-config \
	sysstat     # for tmux-cpu
	nodejs npm  # for coc.vim
	silversearcher-ag # for ctrlp
sudo pip3 install --user --upgrade conan ninja cmake

git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1

cat <<EOF>>~/.bashrc

eval $(direnv hook bash)

if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
  GIT_PROMPT_ONLY_IN_REPO=1

  # GIT_PROMPT_FETCH_REMOTE_STATUS=0   # uncomment to avoid fetching remote status
  # GIT_PROMPT_IGNORE_SUBMODULES=1 # uncomment to avoid searching for changed files in submodules
  # GIT_PROMPT_WITH_VIRTUAL_ENV=0 # uncomment to avoid setting virtual environment infos for node/python/conda environments

  GIT_PROMPT_SHOW_UPSTREAM=1 # uncomment to show upstream tracking branch
  GIT_PROMPT_SHOW_UNTRACKED_FILES=normal # can be no, normal or all; determines counting of untracked files

  # GIT_PROMPT_SHOW_CHANGED_FILES_COUNT=0 # uncomment to avoid printing the number of changed files

  # GIT_PROMPT_STATUS_COMMAND=gitstatus_pre-1.7.10.sh # uncomment to support Git older than 1.7.10

  # GIT_PROMPT_START=...    # uncomment for custom prompt start sequence
  # GIT_PROMPT_END=...      # uncomment for custom prompt end sequence

  # as last entry source the gitprompt script
  # GIT_PROMPT_THEME=Custom # use custom theme specified in file GIT_PROMPT_THEME_FILE (default ~/.git-prompt-colors.sh)
  # GIT_PROMPT_THEME_FILE=~/.git-prompt-colors.sh
  # GIT_PROMPT_THEME=Solarized # use theme optimized for solarized color scheme
  source $HOME/.bash-git-prompt/gitprompt.sh
fi
EOF

cat <<EOF>>~/.profile
alias yt-dlp-list="yt-dlp -o '%(playlist_index)03d-%(title)s-%(id)s.%(ext)s'"
alias vi="nvim"
alias vim="nvim"
alias vimdiff="nvim -d"
alias view="nvim -R"

export GPG_TTY=$(tty)
EOF

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
