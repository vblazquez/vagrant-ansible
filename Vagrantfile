# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version ">= 1.8.1"

required_plugins = %w( vagrant-vbguest vagrant-hosts vagrant-vbox-snapshot)
required_plugins.each do |plugin|
    exec "vagrant plugin install #{plugin}; vagrant #{ARGV.join(" ")}" unless Vagrant.has_plugin? plugin || ARGV[0] == 'plugin'
end

## Install ansible
system('scripts/install_local_ansible.sh')

## Read vm's and configurations from JSON file
nodes_config = (JSON.parse(File.read("nodes.json")))['nodes']

Vagrant.configure("2") do |config|
    ## For each VM in nodes
    nodes_config.each do |node|
        node_name   = node[0] ## Node's name
        node_values = node[1] ## Node's configuration

        ## VM Setup
        config.vm.define node_name do |node_config|
            ## If box haven't been defined, set ubuntu as a default
            node_config.vm.box = node_values['box'] ? node_values['box'] : 'ubuntu/wily64'
            if node_values['box_url']
                node_config.vm.box_url = node_values['box_url']
            end

            ## Do not show box's later available version
            node_config.vm.box_check_update = false
            ## Set max boot timeout
            node_config.vm.boot_timeout = 300

            node_config.vm.hostname = node_name
            node_config.vm.network "private_network", ip: node_values['ip']

            ## Sync /etc/hosts
            node_config.vm.provision :hosts, :sync_hosts => true

            ## Sync local directory to all VMs
            node_config.vm.synced_folder ".", "/vagrant", id: "vagrant-root", disabled: false
            ## Sync ~/projects folder to my VMs
            node_config.vm.synced_folder "~/projects", "/srv/www"

            ## Config Provider
            memory = node_values['memory'] ? node_values['memory'] : 256;
            node_config.vm.provider :virtualbox do |vb|
                vb.customize [
                    'modifyvm', :id,
                    '--name', node_name,
                    '--memory', memory.to_s
                ]
            end

            ## Guest Additions
            node_config.vbguest.auto_update = true

            ## Install my recently created VM's with ansible
            #node_config.vm.provision "ansible" do |ansible|
                #ansible.inventory_path = "ansible/inventory/hosts"
                #ansible.limit = node_name
                #ansible.playbook = "ansible/playbooks/main_playbook.yml"
                ## Make ansible verbose
                #ansible.verbose = "vvv"
            #end
        end
    end
end
