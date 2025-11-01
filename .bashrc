[[ $- != *i* ]] && return

alias ls='ls --color=always'
alias grep='grep --color=always'
alias less='less -R'
alias cbonsai="cbonsai -c'&'"
#alias man='batman --nh'
alias mplayer='mplayer -msgcolor'
alias mv='mv -i'
alias rm='rm -I'
alias ggraph='git log --graph --oneline --all'

alias webcord='webcord --enable-features=UseOzonePlatform --ozone-platform=wayland'
alias c='calculator'
alias volume='wpctl get-volume @DEFAULT_AUDIO_SINK@'
alias objdump='objdump -Mintel'
alias etch='xorriso-dd-target -DO_WRITE -with_sudo -image_file' # etch [image_file] [device_name]
alias dwl='export XDG_CURRENT_DESKTOP=dwl && dwl'

alias update-osu='wget https://github.com/ppy/osu/releases/latest/download/osu.AppImage ; mv osu.AppImage /usr/local/bin/osu ; chmod a+x /usr/local/bin/osu'

alias fe='export FZF_DEFAULT_COMMAND="rg --files /bin /usr/local/bin" ; $(fzf) ; export FZF_DEFAULT_COMMAND="rg --files --hidden"' # find executable
alias ef='$EDITOR $(fzf)' # edit file
#alias ls='export FZF_DEFAULT_COMMAND="ls -F" ; $(fzf) ; export FZF_DEFAULT_COMMAND="rg --files --hidden"'

function fd() {
	export FZF_DEFAULT_COMMAND="tree -ifdFtr ${1}"
	cd $(fzfdir $(fzf))
	export FZF_DEFAULT_COMMAND="rg --files --hidden" # find dir
}

function f() {
	export FZF_DEFAULT_COMMAND="rg --files --hidden ${1}"
	fzf
	export FZF_DEFAULT_COMMAND='rg --files --hidden'
}

function parse_git_branch() {
	if [ -e ".git" ]; then
		echo '\[\e[32m\]$(git branch --show-current)\[\e[0m\]:'
	fi
}

PS1='\[\e[31m\]  \[\e[37m\] \t\[\e[34m\] \w\[\e[1;35m\]  \[\e[0m\] '
PS1="
  ᥥ ᥥ      ︵*︵
(◜o̴̶̷̤⩊o̴̶̷̤◝)   (＿ ＿)  UNA!!!
 ́(   ) ̀   ̀/◟o̴̶̷̤^o̴̶̷̤◞\\ ́
  ˇ ˇ       U U
 \t \[\e[35m\]\u@\h \[\e[34m\]\w \[\e[35m\]  \[\e[0m\]"
PS1="
    ∧,,∧
   ( . .)
   /   |   /￣￣￣/
乀(ˍ U U＿/＿＿＿/
\t \[\e[35m\]\u@\h $(parse_git_branch)\[\e[34m\]\w \[\e[35m\]  \[\e[0m\]"

function cd() {
	builtin cd "$@"
	export PS1="
    ∧,,∧
   ( . .)
   /   |   /￣￣￣/
乀(ˍ U U＿/＿＿＿/
\t \[\e[35m\]\u@\h $(parse_git_branch)\[\e[34m\]\w \[\e[35m\]  \[\e[0m\]"
}

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

	echo -en "\e]P5c4a7e7" #darkmageneta
	echo -en "\e]PDc4a7e7" #magenta

   	echo -en "\e]P64960af" #darkcyan
   	echo -en "\e]PE4960af" #cyan

   	echo -en "\e]P7aca7cc" #lightgrey
   	echo -en "\e]PFe0def4" #white

	clear #for background artifacting

	PS1='\[\e[31m\] <3\[\e[1;37m\] \t\[\e[34m\] \w\[\e[1;35m\] >\[\e[0m\] '
	PS1="\[\e[1m\]
   /\\/\\ 
  ( . .)   _______
  /   |   /      /
\\(ˍ U U__/______/
 \t \[\e[35m\]\u@\h \[\e[34m\]\w \[\e[35m\]>  \[\e[0m\]"

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
export FZF_DEFAULT_OPTS='--no-unicode --height=18 --algo=v2 --prompt=\ fzf\ \  --highlight-line --color=bw,fg:-1,hl:2:regular,pointer:4,prompt:2,current-fg:-1:regular:bold,current-bg:#44415a,current-hl:2:regular:bold'
export BAT_THEME='rosepinetwo'
export QT_QPA_PLATFORM=xcb
export MANPAGER="vim +MANPAGER --not-a-term -"
