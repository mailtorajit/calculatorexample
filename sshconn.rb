require 'rubygems'
require 'net/ssh'
require 'net/scp'

#gem install net-ssh
#gem install net-scp

@hostname = "35.188.131.223"
@username = "rajsurabhi"
@cmd = "ls -al"
@password = "oddTulip@123"
begin
  puts ARGV[0]
  puts ARGV[1]
  file = "wget -O /home/rajsurabhi/Downloads/"+ARGV[0]+" "+ARGV[1]
  puts file
  system(file)
  Net::SCP.start("35.188.131.223", "rajsurabhi") do |scp|
    # upload a file to a remote server
    scp.upload! "/home/rajsurabhi/Downloads/"+ARGV[0], "/home/rajsurabhi"
  end
  ssh = Net::SSH.start(@hostname, @username,:host_key=>"ssh-rsa",:keys => [ "~/.ssh/rajutest.pub"], :forward_agent=>true)
  res = ssh.exec!(@cmd)
  ssh.exec!("sudo cp /home/rajsurabhi/calculator-unit-test-example-java-1.0-20171030.100532-2.jar /var/lib/tomcat8/webapps/")
  ssh.exec!("sudo service tomcat8 restart")
  ssh.close
  puts res
rescue Exception => e
  puts e.message
end

