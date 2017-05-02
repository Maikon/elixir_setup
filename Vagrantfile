# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANT_VERSION = 2

Vagrant.configure(VAGRANT_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.ssh.forward_agent = true

  config.vm.synced_folder ".", "/vagrant"

  config.vm.network :forwarded_port, host: 4040, guest: 4040
  for i in 9100..9155
    config.vm.network :forwarded_port, guest: i, host: i
  end

  config.vm.network :forwarded_port, guest: 4369, host: 4369

  config.vm.provider :virtualbox do |v|
    v.memory = 2048
    v.linked_clone = true
  end

  app_name = "elixir-conf-eu"

  config.vm.define "#{app_name}" do |app|
    app.vm.hostname = "#{app_name}-dev"
    app.vm.network :private_network, ip: "192.168.60.4"
    app.vm.provision "ansible" do |ansible|
      ansible.playbook = "playbooks/dev.yml"
      ansible.extra_vars = {
        host: "all"
      }
    end
  end
end
