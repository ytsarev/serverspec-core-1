require 'serverspec'
require 'pathname'
require 'net/ssh'
require 'yaml'

include Serverspec::Helper::Ssh
include Serverspec::Helper::DetectOS
include Serverspec::Helper::Properties

profiles = YAML.load_file('profiles.yml')

RSpec.configure do |c|
  c.host  = ENV['TARGET_HOST']
  set_property profiles[c.host]
  options = Net::SSH::Config.for(c.host)
  user    = options[:user] || Etc.getlogin
  c.ssh   = Net::SSH.start(c.host, user, options)
  c.os    = backend.check_os
end
