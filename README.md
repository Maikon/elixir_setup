This repository contains the setup and provisioning files required to develop and deploy Pharos.

## Required Tools

- Install [Vagrant](http://downloads.vagrantup.com/)
  - Install the Virtualisation Provider [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- Install [Terraform](https://www.terraform.io/intro/getting-started/install.html)
- Install [Ansible](http://docs.ansible.com/ansible/intro_installation.html)
  - For Ansible ensure you have python2 installed

## Clone the repository
```
git clone git@github.com:Maikon/elixir_setup.git
```

## Change directory into the root
```
cd elixir_setup
```

## Install the NodeJS and Postgres playbooks
```
ansible-galaxy install geerlingguy.nodejs
ansible-galaxy install ANXS.postgresql
```

## Enable SSH agent forwarding

- Start the agent from the command line:
```
eval $(ssh-agent)
```
- Add your ssh key used for Git (default location is `~/.ssh/id_rsa`):
```
ssh-add
```

## Provision the Vagrant box
```
vagrant up
```

## Enter the virtual machine
```
vagrant ssh
```


## Commonly used vagrant commands

```
  vagrant up        # starts vagrant
  vagrant provision # provisions vm (without restarting)
  vagrant ssh       # SSH into vagrant
  vagrant reload    # restarts vagrant
  vagrant halt      # stops vagrant
  vagrant status    # check to see if vm is running
 ```
