require 'rubygems'
require 'net/ssh'
require 'net/scp'

#gem install net-ssh
#gem install net-scp

@hostname = "35.194.172.75"
@username = "mailtorajuit"
@cmd = "ls -al"
@password = "oddTulip@123"
begin
  puts ARGV[0]
  puts ARGV[1]
  file = "wget -O #{ARGV[0]} #{ARGV[1]}"
  puts file
  system(file)
  Net::SCP.start(@hostname, "mailtorajuit") do |scp|
    # upload a file to a remote server
    scp.upload! ARGV[0], "/home/mailtorajuit"
  end
  ssh = Net::SSH.start(@hostname, "mailtorajuit", :host_key=>"ssh-rsa",:keys => [ "/home/rajkumar/.ssh/id_rsa.pub"], :forward_agent=>true)
  res = ssh.exec!(@cmd)
  ssh.exec!("sudo cp /home/mailtorajuit/"+ARGV[0]+" /var/lib/tomcat8/webapps/")
  ssh.exec!("sudo service tomcat8 restart")
  ssh.close
  puts res
  system("rm #{ARGV[0]}")
rescue Exception => e
  puts e.message
end

