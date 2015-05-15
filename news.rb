
require 'erb'
require 'webrick'
require 'yaml'

ROOT = File.dirname(__FILE__)

server = WEBrick::HTTPServer.new(:Port => 8000, :DocumentRoot => "#{ROOT}/public")


server.mount_proc '/' do |req, res|
  @data = YAML.load_file('data.yml')
  template = ERB.new(File.read("#{ROOT}/index.html.erb"))
  res.body = template.result
end

trap 'INT' do
  server.shutdown
end

server.start