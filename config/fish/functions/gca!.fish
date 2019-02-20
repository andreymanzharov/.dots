# Defined in - @ line 1
function gca! --description 'alias gca!=git commit -v -a --amend'
	git commit -v -a --amend $argv;
end
