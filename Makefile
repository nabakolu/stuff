install:
	mkdir -p /usr/local/bin/
	mkdir -p /usr/local/share/applications/
	mkdir -p /usr/local/share/bash-completion/completions/
	cp usr/local/bin/* /usr/local/bin/
	cp usr/local/share/applications/* /usr/local/share/applications/
	cp usr/local/share/bash-completion/completions/* /usr/local/share/bash-completion/completions/
	cp etc/issue /etc/issue
