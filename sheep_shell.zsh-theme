# Sheep Shell Theme

PROMPT_EMOJI="🐑"

PROMPT='
$(vi_mode)$(short_pwd) $(fast_git_prompt_info) $(fast_hg_prompt_info)
$(date_prompt_start) $PROMPT_EMOJI  '

export CLICOLOR=1
export COLORFGBG
export LSCOLORS="GxFxCxDxBxegedabagaced"
export LS_COLORS='di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:'
export GREP_COLOR='1;33'

export MODE_INDICATOR="%{$fg[cyan]%}[NORMAL] %{$reset_color%}"
export RPS1

function vi_mode() {
  if {echo $fpath | grep -q "plugins/vi-mode"}; then
    echo "$(vi_mode_prompt_info)"
  fi
}

function date_prompt_start()
{
  echo "`date +%H:%M` `hostname -s` $USER"
}

function _short_pwd()
{
  echo `pwd` | sed -e "s|^$HOME|~|" -e 's-\([^/]\)[^/]*/-\1/-g'
}

function short_pwd()
{
  echo "%{$fg[blue]%}$(_short_pwd)%{$reset_color%}"
}

export ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}"
export ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"

export ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✗%{$reset_color%}"
export ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✔%{$reset_color%}"
export ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}✚ "
export ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%}⚑ "
export ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}✖ "
export ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%}▴ "
export ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[cyan]%}§ "
export ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[grey]%}◒ "

function fast_git_prompt_info()
{
  if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    local branch=`git symbolic-ref --short HEAD`

    if git diff-index --no-ext-diff --quiet HEAD > /dev/null 2>&1; then
      echo "[%{$fg[green]%}$branch$ZSH_THEME_GIT_PROMPT_CLEAN]"
    else
      echo "[%{$fg[red]%}$branch$ZSH_THEME_GIT_PROMPT_DIRTY]"
    fi
  fi
}

function fast_hg_prompt_info()
{
  if [ $(in_hg) ]; then
    local branch=$(hg_get_branch_name)

    hg_dirty_choose "[%{$fg[red]%}$branch$ZSH_THEME_GIT_PROMPT_DIRTY]" "[%{$fg[green]%}$branch$ZSH_THEME_GIT_PROMPT_CLEAN]"
  fi
}
