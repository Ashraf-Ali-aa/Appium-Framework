module ScreenClasses
  def screen_classes
    {
      navigation: Navigation
    }.each do |ivar, klass|
      define_method(ivar) do
        temp = instance_variable_get("@#{ivar}")
        return temp if temp
        clazz = klass.is_a?(String) ? klass.split('::').inject(Object) { |a, e| a.const_get e } : klass
        instance_variable_set("@#{ivar}", clazz.new)
      end
    end
  end

  def promote_methods_in_ark
    [AbstractScreen, Screen].each do |class_name|
      class_name.instance_methods(false).each do |methods|
        define_method methods { |*args, &block| class_name.new.send(methods, *args, &block) }
      end
    end
  end
end
