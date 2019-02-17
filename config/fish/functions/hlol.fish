function hlol --wraps hg --description 'hlol=hg log -G -b . --tempalte $HG_LOG_TEMPLATE'
	hg log -G -b . --template $HG_LOG_TEMPLATE $argv
end
