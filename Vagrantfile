Vagrant.configure("2") do |config|

  config.vm.define "kali" do |kali|
    kali.vm.box = "kalilinux/rolling"
    kali.vm.hostname = "kali"
    kali.vm.network "private_network", type: "dhcp"
    kali.vm.synced_folder "./podman/webapps", "/home/vagrant/webapps"
    kali.vm.provision "ansible" do |ansible|
      ansible.playbook = "ansible/playbooks/kali.yml"
    end
  end

  config.vm.define "metasploitable2" do |msf2|
    msf2.vm.box = "rapid7/metasploitable2"
    msf2.vm.hostname = "msf2"
    msf2.vm.network "private_network", type: "dhcp"
    msf2.vm.provision "ansible" do |ansible|
      ansible.playbook = "ansible/playbooks/metasploitable2.yml"
    end
  end

  config.vm.define "metasploitable3-linux" do |msf3l|
    msf3l.vm.box = "generic/ubuntu2004"
    msf3l.vm.hostname = "msf3linux"
    msf3l.vm.network "private_network", type: "dhcp"
    msf3l.vm.provision "ansible" do |ansible|
      ansible.playbook = "ansible/playbooks/metasploitable3.yml"
    end
  end

  config.vm.define "metasploitable3-windows" do |msf3w|
    msf3w.vm.box = "gusztavvargadr/windows-10"
    msf3w.vm.hostname = "msf3win"
    msf3w.vm.network "private_network", type: "dhcp"
    msf3w.vm.communicator = "winrm"
    msf3w.vm.provision "ansible" do |ansible|
      ansible.playbook = "ansible/playbooks/metasploitable3-windows.yml"
    end
  end

  config.vm.define "winserver" do |win|
    win.vm.box = "gusztavvargadr/windows-server"
    win.vm.hostname = "winserver"
    win.vm.network "private_network", type: "dhcp"
    win.vm.communicator = "winrm"
    win.vm.provision "ansible" do |ansible|
      ansible.playbook = "ansible/playbooks/winserver.yml"
    end
  end

end
