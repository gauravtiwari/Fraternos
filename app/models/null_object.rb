class NullObject
  def method_missing(method, *_args, &_block)
    super unless respond_to_missing?(method)
    nil
  end

  def respond_to_missing?(method, _include_private = false)
    super
  end
end
