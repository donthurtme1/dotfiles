[[ $- != *i* ]] && return

alias ls='ls -t --color=auto' # Ignore order based on last used and automatic colouring
alias grep='grep --color=auto'
alias man='batman --nh'
alias r='ranger'

alias webcord='webcord --enable-features=UseOzonePlatform --ozone-platform=wayland'
alias c='calculator'
alias volume='wpctl get-volume @DEFAULT_AUDIO_SINK@'
alias dump='objdump -Mintel -Ds'
alias objdump='objdump -Mintel'
alias etch='xorriso-dd-target -DO_WRITE -with_sudo -image_file' # etch [image_file] [device_name]

alias re='cd ~ && clear && fetch'
alias fd='export FZF_DEFAULT_COMMAND=tree\ -ifd ; cd $(fzfdir $(fzf)) ; export FZF_DEFAULT_COMMAND=rg\ --files\ --hidden' # find dir
#alias fd='export FZF_DEFAULT_COMMAND=rg\ --hidden\ --files-with-matches\ \"\(\\w/\)+" ; cd $(fzfdir $(fzf)) ; export FZF_DEFAULT_COMMAND=rg\ --files\ --hidden' # find dir
alias fe='export FZF_DEFAULT_COMMAND=rg\ --files\ /bin ; $(fzf) ; export FZF_DEFAULT_COMMAND=rg\ --files\ --hidden' # find executable
alias ef='$EDITOR $(fzf)' # edit file

PS1='\[\e[31m\]  \[\e[1;37m\] \t\[\e[0;34m\] \w\[\e[1;35m\]  \[\e[0m\] '

if [ "$TERM" = "linux" ]; then
	if [ "${tty}" = "/dev/tty1" ]; then
		exec dwl &
	fi

	echo -en "\e]P01e1a32" #black
	echo -en "\e]P856526e" #darkgrey

	echo -en "\e]P1eb6f9a" #darkred
	echo -en "\e]P9eb6f92" #red

   	echo -en "\e]P23e8fb0" #darkgreen
   	echo -en "\e]PA3e8fb0" #green

   	echo -en "\e]P3f6c177" #darkyellow
   	echo -en "\e]PBf6c177" #yellow

	echo -en "\e]P49ccfd8" #darkblue
	echo -en "\e]PC9ccfd8" #blue

	echo -en "\e]P5c4a7e7" #darkmagen4ta
	echo -en "\e]PDc4a7e7" #magenta

   	echo -en "\e]P64960af" #darkcyan
   	echo -en "\e]PE4960af" #cyan

   	echo -en "\e]P7aca7cc" #lightgrey
   	echo -en "\e]PFe0def4" #white

	clear #for background artifacting

	PS1='\[\e[31m\] -\[\e[1;37m\] \t\[\e[34m\] \w\[\e[1;35m\] >\[\e[0m\] '

	export LESS_TERMCAP_mb=$'\e[1;31m'
	export LESS_TERMCAP_me=$'\e[0m'
	export LESS_TERMCAP_us=$'\e[1;32m'
	export LESS_TERMCAP_ue=$'\e[0m'
	export LESS_TERMCAP_so=$'\e[0;30;41m'
	export LESS_TERMCAP_se=$'\e[0m'
fi

export EDITOR='vim'
export WLR_RENDERER='vulkan'
export FZF_DEFAULT_COMMAND='rg --files --hidden'
export FZF_DEFAULT_OPTS='--no-unicode --height=18 --algo=v1 --prompt=\ fzf\ \  --highlight-line --color=bw,fg:-1,hl:2:regular,pointer:4,prompt:2,current-fg:-1:regular:bold,current-bg:#44415a,current-hl:2:regular:bold'
export BAT_THEME='Catppuccin Mocha'

fetch
