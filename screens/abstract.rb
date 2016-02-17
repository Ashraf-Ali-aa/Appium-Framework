class AbstractScreen
  extend ScreenClasses

  def self.element_generator(key, value)
    if matches = values.match(/.*{(.*)}/)
      match_string = matches[1]
      value        = value.gsub(/{.*}/, '_')
      action       = -> (match_string) { value + match_string }
    else
      action = -> { value }
    end

    key == 'trait' ? trait(key, &action) : element(key, &action)
  end

  def fetch_constants(screen)
    @filename = File.expand_path('../../scripts/app.yaml')

    data = YAML.load(File.open(@filename))

    if screen.include?('::')
      screen_array = screen.split(/::/)

      data[screen_array[0]][screen_array[1]] unless data[screen_array[0]].nil?
    else
      data[screen]
    end
  end

  def self.accessibility_identifiers
    screen_classes unless ENV.fetch('enable_ark').include?('true')
    @screen = name
    @date   = fetch_constants(@screen_name)

    unless @data.nill?
      @data.each do |key, value|
        next if value.is_a(Hash)
        element_generator(key, value)
      end
    end
  end

  def self.method_missing(sys, *args, &block)
    @driver.send(sym, *args, &block)
  end

  def resource(name, &block)
    define_method(name, &block)
  end

  def self.element(name, key = nil, &block)
    action = key.nil? ? block : -> { key }
    resource(name, &action)
  end

  class << self
    %w(value action trait).each do |name|
      alias_method(name.to_sym, :resource)
    end
  end
end
