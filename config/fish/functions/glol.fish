# Defined in - @ line 1
function glol --description alias\ glol=git\ log\ --graph\ --pretty=\'\%Cred\%h\%Creset\ -\%C\(auto\)\%d\%Creset\ \%s\ \%Cgreen\(\%cr\)\ \%C\(bold\ blue\)\<\%an\>\%Creset\'
	git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' $argv;
end
