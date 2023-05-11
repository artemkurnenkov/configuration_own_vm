# Config own virtual machine
  
Vagrant.configure("2") do |config|
  
    config.vm.boot_timeout = 3000
    config.vm.define "server" do |server|
        server.vm.box = "ubuntu/focal64"
        server.vm.hostname = "server"
        server.vm.network "forwarded_port", id: "ssh", host: 2222, guest: 22
        server.vm.network "private_network", ip: "192.168.100.1"
        server.vm.synced_folder "./ansible_config", "/home/vagrant/ansible_config"
        server.vm.synced_folder "./work_dir", "/home/vagrant/work_dir"
        
        server.vm.provision "shell" do |s|
            ssh_pub_key = File.readlines("#{Dir.home}/.ssh/id_rsa.pub").first.strip
            s.inline = <<-SHELL
            echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
            echo #{ssh_pub_key} >> /root/.ssh/authorized_keys
            sed -i -e 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/g' \
            -e 's/#PermitEmptyPasswords no/PermitEmptyPasswords no/g' /etc/ssh/sshd_config
            service ssh restart
            SHELL
        end

        config.vm.provider "vm_config" do |vm_config|
            vm_config.name = "server"
            vm_config.memory = "2048"
            vm_config.cpus = 2
        end
    end
end
