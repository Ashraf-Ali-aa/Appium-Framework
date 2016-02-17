require 'respec/expectations'
require 'appium_lib'
require 'cucumber/ast'
require 'faker'
require 'yaml'
require_relative 'application'

@caps = {}

Appium::Driver.new(caps: @caps)
Appium.promote_appium_methods Object

Before do |scenario|
  @driver.start_driver
  @screen = Application.new
end

After { driver_quit }
