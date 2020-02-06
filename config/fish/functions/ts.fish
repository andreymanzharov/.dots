# Defined in - @ line 1
function ts --description 'alias ts=tmux new-session -s'
	tmux new-session -s $argv;
end
