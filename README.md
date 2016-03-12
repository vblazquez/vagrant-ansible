What is this?
=============
A vagrant template for multiple VM and provisioned through ansible

Template for using vagrant with one or multiple machines over VirtualBox and provisioned through ansible.

This template has been configured to synchronize all hosts through your VMs defined in a JSON file and with the possibility of taking snapshots

Getting it running
------------------

* git clone
* vagrant up

Vagrant Tricks
--------------

Take backup of your provisioned machines
```
$ vagrant snapshot node01.example.com node01
```

List of taken backups

```
$ vagrant snapshot list node01.example.com
```

Take back an snapshot

```
$ vagrant snapshot back 
```

