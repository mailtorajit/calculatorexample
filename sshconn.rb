require 'rubygems'
require 'net/ssh'
#gem install net-ssh
@hostname = "35.188.131.223"
@username = "rajsurabhi"
@cmd = "ls -al"

 begin
    #ssh = Net::SSH.start(@hostname, @username)
	puts "=========================="
	ssh = Net::SSH.start(@hostname, @username,:host_key => "ssh-rsa",:keys => ["rajutest.pub"], :forward_agent => true)
	puts "=========================="
    res = ssh.exec!(@cmd)
    ssh.close
    puts res
  rescue Exception => e
  	puts e.message
  end