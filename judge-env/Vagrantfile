# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

require 'vagrant-aws'

Vagrant.configure(2) do |config|
    #    config.vm.box = "aws-dummy"
    config.vm.provider 'virtualbox' do |v, override|
        v.name = "dmoj-judge"
        v.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]

        config.vm.box = "gbarbieru/xenial"
        v.memory = 2048
        v.cpus = 1
    end
    config.vm.provider 'aws' do |aws, override|
        aws.access_key_id = ENV['AWS_KEY']
        aws.secret_access_key = ENV['AWS_SECRET']
        aws.keypair_name = ENV['AWS_KEYNAME']

        aws.ami = 'ami-060cde69'

        aws.region = 'eu-central-1'

        aws.instance_type = "t2.micro"
        aws.instance_ready_timeout = 300
        aws.security_groups = [ 'default', 'Ubuntu 16.04 LTS - Xenial (HVM)-20170411-AutogenByAWSMP-']

        # override.nfs.functional = false
        override.vm.synced_folder ".", "/vagrant", type: "rsync"

        override.vm.box = "aws-dummy"
        override.vm.box_url = "https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box"

        override.ssh.username = 'ubuntu'
        override.ssh.private_key_path = ENV['AWS_KEYPATH']
        aws.tags = {
          'Name': 'judge-vagrant'
        }
    end
    config.vm.provision :shell, path: "bootstrap.sh"
end
