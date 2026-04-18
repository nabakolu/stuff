install:
	mkdir -p /usr/local/bin/
	mkdir -p /usr/local/share/applications/
	mkdir -p /etc/X11/xorg.conf.d/
	mkdir -p /etc/pam.d/
	mkdir -p /etc/conf.d/
	cp usr/local/bin/* /usr/local/bin/
	cp usr/local/share/applications/* /usr/local/share/applications/
	cp etc/issue /etc/issue
	cp etc/X11/xorg.conf.d/* /etc/X11/xorg.conf.d/
	cp etc/pam.d/* /etc/pam.d/
	cp etc/conf.d/* /etc/conf.d/
