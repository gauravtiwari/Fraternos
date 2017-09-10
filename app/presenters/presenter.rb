class Presenter
  def initialize(helpers)
    @helpers = helpers
  end

  def render
    raise NotImplementedError
  end

  def method_missing(name, *args, &block)
    super unless @helpers.methods.include? name
    @helpers.send(name, *args, &block)
  end

  def respond_to_missing?(name, _include_private = false)
    @helpers.methods.include?(name)
  end
end
