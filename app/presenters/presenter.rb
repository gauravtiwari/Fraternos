class Presenter
  def initialize(helpers)
    @helpers = helpers
  end

  def render
    raise NotImplementedError
  end

  def method_missing(method, *args, &block)
    respond_to_missing?(method) ? @helpers.send(method, *args, &block) : super
  end

  def respond_to_missing?(method, _include_private = false)
    @helpers.methods.include?(method)
  end
end
