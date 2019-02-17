function hlola --wraps hg --description 'hlola=hg log -G --tempalte $HG_LOG_TEMPLATE'
	hg log -G --template $HG_LOG_TEMPLATE $argv
end
