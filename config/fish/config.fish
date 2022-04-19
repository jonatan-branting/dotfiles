# Disable greeting message
set fish_greeting ""

function _git_branch_name
  echo (git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
  echo (git status -s --ignore-submodules=dirty ^/dev/null)
end

function _rb_prompt
  echo (rbenv version | awk '{print $1}')
end

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
	set -g __fish_git_prompt_showupstream auto
	set_color $fish_color_regular
	printf '%s' (prompt_pwd)
	set_color grey -i
	printf '%s' (fish_git_prompt)
	set_color $fish_color_normal
	printf ' $ '
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
set PATH $PATH $HOME/bin /usr/sbin/ /sbin /usr/local/sbin $HOME/.local/bin
set -x PATH "$HOME/.cargo/bin" $PATH
set -x PATH "$HOME/.pyenv/bin" $PATH
replay source "$HOME/.config/fish/protected.env"

set EDITOR "nvr"
set FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git --exclude tags'
set FZF_DEFAULT_OPTS '--margin=1,1 --preview-window="right:50%:noborder" --bind=ctrl-j:preview-down --bind=ctrl-k:preview-up'
set VISUAL 'nvr'

source $HOME/.hostconfig

status is-login; and pyenv init --path | source
set -gx EDITOR nvim

if set -q NVIM_LISTEN_ADDRESS
	alias nvim "nvr"
	alias vim "nvr"
	export MANPAGER="nvr +Man! -"
	export EDITOR="nvr"
else
	alias nvim "nvim"
	alias vim "nvim"
	export EDITOR="nvim"
	export MANPAGER="nvim +Man! -"
end

export VISUAL="$EDITOR"
export GIT_EDITOR="$EDITOR"
export GIT_PAGER="$EDITOR"

pyenv init - | source

function __fish_describe_command; end
