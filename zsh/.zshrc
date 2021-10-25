# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
case `uname` in
        Darwin)
          export ZSH="/Users/sraabe/.oh-my-zsh"
          # set C Compiler
          export CC=/opt/homebrew/opt/llvm/bin/clang
          export CXX=/opt/homebrew/opt/llvm/bin/clang++

          #set Compiler Flags
          export LDFLAGS="-L/opt/homebrew/opt/llvm/lib -Wl,-rpath,/opt/homebrew/opt/llvm/lib"
          export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
	;;
        Linux)
	  export ZSH="~/.oh-my-zsh"
	;;
esac

ZSH_THEME="robbyrussell"

# change directory without cd
setopt autocd

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
export PATH=/Users/sraabe/tools/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
