require 'yaml'
require 'faker'

ENV['enable_ark'] = 'false'

require_relative '../screen/screen_classes'
require_relative '../screen/abstract'
require_relative '../screen/screen'

FILES = Dir[File.expand_path('../../', __FILE__) + 'screen/iOS/*.rb']

FILES.each { |file| require file }

no_wait if @driver

def x
  driver_quit
  exit
  sh 'killall node'
end

def reload
  FILES.each { |file| load file }
end

extend ScreenClasses
screen_classes
promote_methods_in_ark
