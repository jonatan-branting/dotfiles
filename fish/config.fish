# Disable greeting message
set fish_greeting ""

#status --is-interactive; and source (pyenv init -|psub)

# Add directories to PATH
set PATH $PATH $HOME/bin /usr/sbin/ /sbin /usr/local/sbin

# Change colors
set fish_color_command orange
set fish_color_param blue
set fish_color_autosuggestion yellow light
set fish_color_cwd red
set fish_color_valid_path blue

# Set prompt.
set fish_color_regular blue # Is grey with cs.
set fish_color_root red

function fish_error
	set error_code $status
	if [ $error_code -gt 0 ];
		set fish_color_status red
		set_color $fish_color_status --bold
		printf [$error_code]
	end
end

function fish_prompt
	fish_error # If last command returned an error, print it.
	set_color $fish_color_regular # Only necessary because the bold from fish_error won't go away otherwise...
	printf '%s' (prompt_pwd)
	if [ "$USER" = "root" ];
		# User is root. Make it show!
		set_color $fish_color_root --bold
			printf " # "
		else
		# User is a boring non-root user.
			set_color normal --bold
			printf " \$ "
	end
	set_color $fish_color_normal
end

#Pyenv
set -x PATH "/home/nonah/.pyenv/bin" $PATH
set -x BROWSER "google-chrome-stable"
status --is-interactive; and . (pyenv init -|psub)
status --is-interactive; and . (pyenv virtualenv-init -|psub)


# Load aliases
if [ -f $HOME/.config/fish/aliases.fish ]
	. $HOME/.config/fish/aliases.fish
end

# Load local aliases
if [ -f $HOME/.config/fish/localaliases.fish ]
	. $HOME/.config/fish/localaliases.fish
end

# Fix ugly ls colors
#set -Ux LS_COLORS "rs=0:di=01;34:ln=01;36:mh=00:pi=01;33:so=01;35:do=01;35:bd=01;33;:cd=01;33;:or=01;31;01:su=01;41:sg=01;43:ca=01;41:tw=01;34:ow=01;34:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:"
#/home/nonah/scripts/gruvbox_256palette.sh
status --is-interactive; and source (pyenv init -|psub)

# opam configuration
source /home/nonah/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
