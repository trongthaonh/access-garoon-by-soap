class Object
  def ensure_array
    self.is_a?(Array) ? self : [self]
  end
end
