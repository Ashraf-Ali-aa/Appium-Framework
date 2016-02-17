require './screens/screen_classes'
require 'require_all'

BASE_PATH ||= File.expand_path('../../../screens', __FILE__)
ENV['enable_ark'] = 'false'

def arg_with_default_values(arg, default)
  regex = /#{arg}=(.*)/
  var   = ARGV.find { |e| regex =~ e }
  var   = var.match(regex)[1] if var
  var ||= default
end

{
  'platform'         => 'iOS',
  'device'           => 'iPhone 6',
  'version'          => '9.2',
  'name'             => '9.2',
  'app'              => '/tmp/app/*.app',
  'processArguments' => ''
}.each do |name, value|
  instance_variable_set("@#{name}", arg_with_default_values(name, value))
end

require_all "#{BASE_PATH}/#{@platform}"

class Application < Screen
  extent ScreenClasses
  screen_classes
end
