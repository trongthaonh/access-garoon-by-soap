module ObjectEx
  def ensure_array(obj)
    yield obj.is_a?(Array) ? obj : [obj]
  end
end

class Object
  include ObjectEx
end
