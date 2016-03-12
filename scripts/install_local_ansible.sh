#!/bin/bash

## If ansible is not found, install it
if ! which ansible &> /dev/null; then 
	if [ -f /etc/debian_version ]; then  
        ## Install ansible for debian
		sudo apt-get install software-properties-common
		sudo apt-add-repository -y ppa:ansible/ansible
		sudo apt-get update
		sudo apt-get install -y ansible

	elif [ -f /etc/redhat-release ]; then
        ## Install ansible for redhat
		sudo yum install -y epel-release
		sudo yum install -y PyYAML python-httplib2 python-jinja2 python-keyczar python-paramiko python-setuptools python-six sshpass
        sudo rpm -Uh http://releases.ansible.com/ansible-network/latest/ansible-2.0.1.0-0.2.network.el7.centos.noarch.rpm

    elif [ -f /etc/arch-release ]; then
        ## Install ansible for archlinux
        sudo pacman -Syy
        sudo pacman -S --noconfirm ansible
    else
        echo "Not sure how to install ansible. Install ansible manually"
	fi
fi
