class NullFraternity < NullObject
  def persisted?
    false
  end

  def present?
    false
  end

  def respond_to_missing?(method_name, _include_private = false)
    Fraternity.new.respond_to? method_name
  end

  def policy_class
    NullFraternityPolicy
  end
end
