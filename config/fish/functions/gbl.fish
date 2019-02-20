# Defined in - @ line 1
function gbl --description 'alias gbl=git blame -b -w'
	git blame -b -w $argv;
end
