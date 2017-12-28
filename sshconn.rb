require 'rubygems'
require 'net/ssh'
require 'net/scp'

#gem install net-ssh
#gem install net-scp

@hostname = "35.194.233.140"
@username = "mailtorajuit"
@cmd = "ls -al"
@password = "oddTulip@123"
begin
  puts ARGV[0]
  puts ARGV[1]
  file = "wget -O #{ARGV[0]} #{ARGV[1]}"
  puts file
  system(file)
  puts "FIle downloaded using wget"
  Net::SCP.start(@hostname, "mailtorajuit", :password => @password) do |scp|
    # upload a file to a remote server
    scp.upload! ARGV[0], "/home/mailtorajuit"
  end
  puts "File uploaded using scp"
  ssh = Net::SSH.start(@hostname, "mailtorajuit", :host_key=>"ssh-rsa",:keys => ["rajutest.pub"], :forward_agent=>true)
  res = ssh.exec!(@cmd)
  ssh.exec!("sudo service tomcat8 stop")
  ssh.exec!("sudo cp /home/mailtorajuit/"+ARGV[0]+" /var/lib/tomcat8/webapps/")
  ssh.exec!("sudo service tomcat8 start")
  ssh.close
  puts res
  system("rm #{ARGV[0]}")
rescue Exception => e
  puts e.message
  raise e.message
end

