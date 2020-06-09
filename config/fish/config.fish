# Disable greeting message
set fish_greeting ""

# Change colors
set fish_color_command orange
set fish_color_param blue
set fish_color_autosuggestion yellow light
set fish_color_cwd red
set fish_color_valid_path blue

# Set prompt.
set fish_color_regular blue
set fish_color_root red

function fish_error
	set error_code $status
	if [ $error_code -gt 0 ];
		set fish_color_status red
		set_color $fish_color_status --bold
		printf [$error_code]
		printf ' '
	end
end

function fish_prompt
	fish_error
	set_color $fish_color_regular
	printf '%s' (prompt_pwd)
	if [ "$USER" = "root" ];
		set_color $fish_color_root --bold
			printf " # "
		else
			set_color normal --bold
			printf " \$ "
	end
	set_color $fish_color_normal
end


# Load aliases
if [ -f $HOME/.config/fish/aliases.fish ]
	. $HOME/.config/fish/aliases.fish
end

# Load local aliases
if [ -f $HOME/.config/fish/localaliases.fish ]
	. $HOME/.config/fish/localaliases.fish
end

# Paths
set PATH $PATH $HOME/bin /usr/sbin/ /sbin /usr/local/sbin
set -x PATH "$HOME/.pyenv/bin" $PATH
bax source "$HOME/.config/fish/protected.env"
export EDITOR "nvim"


function __fish_describe_command; end
