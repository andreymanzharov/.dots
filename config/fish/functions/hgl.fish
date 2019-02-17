function hgl --wraps hg --description 'hgl=hg pull -u'
	hg pull -u $argv;
end
