#!/bin/bash
$HOME/go/bin/sesh connect $(
	$HOME/go/bin/sesh list -ct | fzf-tmux -p 55%,60% \
		--no-sort --border-label ' sesh ' --prompt '⚡  ' \
		--header '  ^a all ^t tmux ^g config ^x zoxide ^f find' \
		--bind 'tab:down,btab:up' \
		--bind 'ctrl-a:change-prompt(⚡  )+reload($HOME/go/bin/sesh list)' \
		--bind 'ctrl-t:change-prompt(🪟 )+reload($HOME/go/bin/sesh list -t)' \
		--bind 'ctrl-g:change-prompt(  )+reload(sesh list -c)' \
		--bind 'ctrl-x:change-prompt(📁  )+reload($HOME/go/bin/sesh list -z)' \
		--bind 'ctrl-f:change-prompt(🔎 )+reload(fd -H -d 2 -t d -E .Trash . ~)'
)
