# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

################################################################
# DEV config
################################################################
export ARTIFACTORY_DOCKER_URL=changeit
export ARTIFACTORY_CONTEXT_URL=changeit

export ARTIFACTORY_USERNAME=changeit
export ARTIFACTORY_PASSWORD=changeit
export SONAR_TOKEN=changeit

# Path to your oh-my-zsh installation.
export ZSH=/Users/oborovyk/.oh-my-zsh

export NVM_DIR="$HOME/.nvm"
  . "/usr/local/opt/nvm/nvm.sh"

export GOPATH=$HOME/development/golangtest
export GO111MODULE=on

export GRADLE_HOME=/usr/local/opt/gradle/libexec

export PATH=/Users/oborovyk/development/hyperledger/bin:$PATH

# You may need to manually set your language environment
export LANG=en_US.UTF-8

################################################################
# Powerlevel
################################################################

POWERLEVEL9K_INSTALLATION_PATH=$ANTIGEN_BUNDLES/bhilburn/powerlevel9k

POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_CUSTOM_WIFI_SIGNAL="zsh_wifi_signal"
POWERLEVEL9K_CUSTOM_WIFI_SIGNAL_BACKGROUND="white"
POWERLEVEL9K_CUSTOM_WIFI_SIGNAL_FOREGROUND="black"

zsh_wifi_signal(){
  #source on quality levels - http://www.wireless-nets.com/resources/tutorials/define_SNR_values.html
  #source on signal levels  - http://www.speedguide.net/faq/how-to-read-rssisignal-and-snrnoise-ratings-440
  local output=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I) 
  local signal=$(echo $output | grep 'agrCtlRSSI' | awk -F': ' '{print $2}')
  local speed=$(echo $output | grep 'lastTxRate' | awk -F': ' '{print $2}')
  local noise=$(echo $output | grep 'agrCtlNoise' | awk -F': ' '{print $2}')
  if [[ ! -z "${signal// }" ]] && [[ ! -z "${noise// }" ]] && local SNR=$(bc <<<"scale=2; $signal / $noise")
  local net=$(curl -D- -o /dev/null -s http://www.google.com | grep HTTP/1.1 | awk '{print $2}')
  local color='%F{yellow}'
  local symbol="\uf700"
  local mbs="Mbs"

  # Excellent Signal (5 bars)
  if [[ ! -z "${signal// }" ]] && [[ $SNR -gt .40 ]] ; 
    then color='%F{blue}' ; symbol="\uf1eb" ;
  fi
  # Good Signal (3-4 bars)
  if [[ ! -z "${signal// }" ]] && [[ ! $SNR -gt .40 ]] && [[ $SNR -gt .25 ]] ; 
    then color='%F{green}' ; symbol="\uf1eb" ;
  fi

  # Low Signal (2 bars)
  if [[ ! -z "${signal// }" ]] && [[ ! $SNR -gt .25 ]] && [[ $SNR -gt .15 ]] ; 
    then color='%F{yellow}' ; symbol="\uf1eb" ;
  fi

  # Very Low Signal (1 bar)
  if [[ ! -z "${signal// }" ]] && [[ ! $SNR -gt .15 ]] && [[ $SNR -gt .10 ]] ; 
    then color='%F{red}' ; symbol="\uf1eb" ;
  fi

  # No Signal - No Internet
  if [[ ! -z "${signal// }" ]] && [[ ! $SNR -gt .10 ]] ; 
    then color='%F{red}' ; symbol="\uf818";
  fi
  
  if [[ -z "${signal// }" ]] && [[ "$net" -ne 200 ]] ; 
    then color='%F{red}' ; symbol="\uf818" ; speed= '' ; mbs='' ;
  fi

  # Ethernet Connection (no wifi, hardline)
  if [[ -z "${signal// }" ]] && [[ "$net" -eq 200 ]] ; 
    then color='%F{blue}' ; symbol="\uf700" ; mbs='LAN' ;
  fi
  
  echo -n "%{$color%}$symbol $speed$mbs" 
}

POWERLEVEL9K_CONTEXT_TEMPLATE="%F{"yellow"}%n%F{"yellow"}@%F{"yellow"}%m"
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND='black'
POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND='black'


POWERLEVEL9K_BATTERY_CHARGING='green'
POWERLEVEL9K_BATTERY_CHARGING_BACKGROUND='white'
POWERLEVEL9K_BATTERY_CHARGING_ICON='white'

POWERLEVEL9K_BATTERY_CHARGED='blue'
POWERLEVEL9K_BATTERY_CHARGED_BACKGROUND='white'

POWERLEVEL9K_BATTERY_DISCONNECTED='$DEFAULT_COLOR'
POWERLEVEL9K_BATTERY_DISCONNECTED_BACKGROUND='white'

POWERLEVEL9K_BATTERY_LOW_THRESHOLD='15'
POWERLEVEL9K_BATTERY_LOW_COLOR='red'
POWERLEVEL9K_BATTERY_LOW_FOREGROUND='red'
POWERLEVEL9K_BATTERY_LOW_BACKGROUND='white'

POWERLEVEL9K_BATTERY_VERBOSE=false
POWERLEVEL9K_PROMPT_ON_NEWLINE=false

POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='yellow'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='yellow'
POWERLEVEL9K_VCS_UNTRACKED_ICON='?'



POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context battery custom_wifi_signal_joined time_joined  dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time background_jobs)

POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3

POWERLEVEL9K_TIME_FORMAT="%D{%H:%M}"
POWERLEVEL9K_TIME_BACKGROUND='white'
POWERLEVEL9K_TIME_ICON=''
# POWERLEVEL9K_HOME_ICON=''
# POWERLEVEL9K_HOME_SUB_ICON=''
# POWERLEVEL9K_FOLDER_ICON=''
POWERLEVEL9K_STATUS_VERBOSE=true
POWERLEVEL9K_STATUS_CROSS=true


################################################################
# History
################################################################

export HISTFILE=~/.zsh_history
export HISTSIZE=20000
export SAVEHIST=$HISTSIZE

setopt APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS


################################################################
# Antigen
################################################################

source /usr/local/share/antigen/antigen.zsh
    
# Load the oh-my-zsh's library
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle jsontools
antigen bundle command-not-found
antigen bundle golang
antigen bundle npm
antigen bundle pip
antigen bundle wd
antigen bundle docker
antigen bundle docker-compose
antigen bundle kubectl
# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle greymd/docker-zsh-completion
# Fish-like auto suggestions
antigen bundle zsh-users/zsh-autosuggestions
# Extra zsh completions
antigen bundle zsh-users/zsh-completions
# Powerlevel9k theme
antigen theme bhilburn/powerlevel9k powerlevel9k


# THEME=dpoggi
# antigen list | grep $THEME; if [ $? -ne 0 ]; then antigen theme $THEME; fi

# Tell antigen that you're done
antigen apply


################################################################
# Custom configuration
################################################################
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval $(thefuck --alias)

bytesToHuman() {
    b=${1:-0}; d=''; s=0; S=(Bytes {K,M,G,T,E,P,Y,Z}iB)
    while ((b > 1024)); do
        d="$(printf ".%02d" $((b % 1024 * 100 / 1024)))"
        b=$((b / 1024))
        (( s++ ))
    done
    echo "$b$d ${S[$s]} "
}

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.


################################################################
# Key Bindings
################################################################

# Common CTRL bindings.
bindkey "^a" beginning-of-line
bindkey "^e" end-of-line
bindkey "^f" forward-word
bindkey "^b" backward-word
bindkey "^k" backward-kill-line
bindkey "^d" delete-char
bindkey "^y" accept-and-hold
bindkey "^w" backward-kill-word

################################################################
# SDKMAN + JENV
################################################################
eval "$(jenv init -)"
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/oborovyk/.sdkman"
[[ -s "/Users/oborovyk/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/oborovyk/.sdkman/bin/sdkman-init.sh"
