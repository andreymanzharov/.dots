function hgca --wraps hg --description 'hgca=hg commit --amend'
	hg commit --amend $argv;
end
