#!/bin/bash

PACKAGES='libyaml-dev unzip g++ git cron vim'

notinstall_pkgs=""
install=false

for pkg in $PACKAGES; do
	status="$(dpkg-query -W --showformat='${db:Status-Status}' "$pkg" 2>&1)"
	if [ ! $? = 0 ] || [ ! "$status" = installed ]; then
		install=true
		notinstall_pkgs=$pkg" "$notinstall_pkgs
	else
		installed_pkgs=$pkg" "$installed_pkgs
	fi
done

if "$install"; then
	apt-get install -y $notinstall_pkgs && rm -rf /var/lib/apt/lists/*
else
	echo "### WARNING ${installed_pkgs} Package[s] already installed. ###"
fi
