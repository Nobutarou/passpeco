#!/bin/zsh

# Maybe I should use PASSWORD_STORE_DIR.
# Since I am not familier with \/'"{}()$, I cannot remove "$HOME/.password-store" smartly.
# I ask you to re-write by yourself.

SELECT=${$(find $HOME/.password-store -name "*.gpg" | sed 's/^\/home\/blabla\/.password-store\///' |peco --prompt="Entry> "):r}

if [ -z $SELECT ];
then exit;
fi

ACT=$(echo "show
edit
rm
" | peco --prompt="Act> ")

if [ -z $ACT ];
then exit;
fi

# Your preference.
export EDITOR=vim

# show once to pass pinentry. For this, don't disable pinentry caching.
pass show $SELECT 

case $ACT in
  show)
    # I want smarter way. I want to get line number instead of the text itself. 
    # Otherwise I cannot use "pass show -c".
    #pass show $SELECT | peco --prompt "Copy> " | xclip -r
    pass show $SELECT | peco --prompt "Copy> " 
    ;;
  edit)
    pass edit $SELECT
    ;;
  rm)
    pass rm $SELECT
    ;;
esac


