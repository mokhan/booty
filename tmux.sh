tmux new-session -d -s bootycall
tmux new-window -t bootycall:2 -n 'server' 'rake run'
tmux new-window -t bootycall:3 -n 'vim' 'vi'
tmux attach -t bootycall
