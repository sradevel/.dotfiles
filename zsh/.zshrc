# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/go/bin

case `uname` in
        Darwin)
           export ZSH="/Users/sraabe/.oh-my-zsh"
#          # set C Compiler
#          export CC=/opt/homebrew/opt/llvm/bin/clang
#          export CXX=/opt/homebrew/opt/llvm/bin/clang++

          #set Compiler Flags
#          export LDFLAGS="-L/opt/homebrew/opt/llvm/lib -Wl,-rpath,/opt/homebrew/opt/llvm/lib"
#          export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
          export PATH=$PATH:/Users/sraabe/tools/bin:/opt/homebrew/bin:/opt/homebrew/sbin:$HOME/go/bin
	;;
        Linux)
	        export ZSH=$HOME/.oh-my-zsh
          export PATH=$PATH:$HOME/go/bin
	;;
esac

ZSH_THEME="robbyrussell"
#ZSH_THEME="powerlevel10k/powerlevel10k"

# change directory without cd
setopt autocd
# dont ask for confirmation on rm *
setopt rmstarsilent

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh


# my aliases
source ~/.aliases

export EDITOR=nvim
export VISUAL=nvim

eval "$(starship init zsh)"
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
