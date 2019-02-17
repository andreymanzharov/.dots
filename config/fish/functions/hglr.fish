function hglr --wraps hg --description 'hglr=hg pull --rebase'
	hg pull --rebase $argv;
end
