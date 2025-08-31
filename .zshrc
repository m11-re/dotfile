# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnosterzak"

plugins=(
    git
    archlinux
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh



# Check archlinux plugin commands here
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/archlinux

# Display Pokemon-colorscripts
# Project page: https://gitlab.com/phoneybadger/pokemon-colorscripts#on-other-distros-and-macos
# pokemon-colorscripts --no-title -s -r #without fastfetch
#pokemon-colorscripts --no-title -s -r | fastfetch -c $HOME/.config/fastfetch/config-pokemon.jsonc --logo-type file-raw --logo-height 10 --logo-width 5 --logo -

# fastfetch. Will be disabled if above colorscript was chosen to install
fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc

# Set-up icons for files/folders in terminal
alias ls='eza -a --icons'
alias ll='eza -al --icons'
alias lt='eza -a --tree --level=1 --icons'
alias cd='z'
alias ni='nvim'
alias nig='neovide'

[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh

# Set-up FZF key bindings (CTRL R for fuzzy history finder)
source <(fzf --zsh)
source /usr/share/nvm/init-nvm.sh


eval "$(starship init zsh)"
eval "$(zoxide init zsh)"



HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# kvm
export LIBVIRT_DEFAULT_URI="qemu:///system"
#export PATH=/home/mhh/.local/bin:$PATH
export LD_LIBRARY_PATH=/home/mhh/Desktop/binaryninja/plugins:$LD_LIBRARY_PATH

# chromium 工具
export PATH=~/Public/depot_tools/:$PATH

# ndk
export ANDROID_NDK_ROOT=~/Android/android-ndk-r25c
export PATH=$ANDROID_NDK_ROOT:$PATH
