module ObjectEx
  def ensure_array
    self.is_a?(Array) ? self : [self]
  end
end

class Object
  include ObjectEx
end
