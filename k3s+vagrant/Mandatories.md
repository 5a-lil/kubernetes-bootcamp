# Creating two VMs with Vagrant

### Vagrantfile:
- [ ] latest stable version of the distrib of our choice
- [ ] advised to use minimum resources (per machine i imagine) 1 CPU and 512 or 1024 RAM
- [ ] machine names = login of someone
    - [ ] Server: hostname + "S"
    - [ ] ServerWorker: hostname + "SW"
- [ ] be able connect with SSH to the machines without pswd
- [ ] modern practices for the Vagrantfile
- [ ] install K3s on both machines
    - [ ] Server: K3s installed in controller mode
    - [ ] ServerWorker: K3s installed in agent mode
- [ ] install and use kubectl

### Example of Vagrantfile
```Vagrantfile
Vagrant.configure(2) do |config|
    [...]
    config.vm.box = REDACTED
    config.vm.box_url = REDACTED

    config.vm.define "wilS" do |control|
            control.vm.hostname = "wilS"
            control.vm.network REDACTED, ip: "192.168.56.110"
            control.vm.provider REDACTED do |v|
                v.customize ["modifyvm", :id, "--name", "wilS"]
                [...]
        end
        config.vm.provision :shell, :inline => SHELL
            [...]
        SHELL
            control.vm.provision "shell", path: REDACTED
    end
    config.vm.define "wilSW" do |control|
            control.vm.hostname = "wilSW"
            control.vm.network REDACTED, ip: "192.168.56.111"
            control.vm.provider REDACTED do |v|
                v.customize ["modifyvm", :id, "--name", "wilSW"]
                [...]
            end
            config.vm.provision "shell", inline: <<-SHELL
                [..]
            SHELL
            control.vm.provision "shell", path: REDACTED
    end
end
```


**Example tests in the subject**