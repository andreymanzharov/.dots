# Defined in - @ line 1
function gds --description 'alias gds=git diff --staged'
	git diff --staged $argv;
end
