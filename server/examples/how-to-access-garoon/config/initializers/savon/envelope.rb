module SavonEx
  def initialize(operation, header, body, custom_header = nil)
    super(operation, header, body)
    @custom_header = custom_header
  end

  def build_header
    require 'xmlsimple'
    return XmlSimple.xml_out(@custom_header, RootName: nil, NoAttr: true) if !@custom_header.nil?
    super
  end

  def build_rpc_wrapper(body)
    name = @operation.name
    tag = name
    '<%{tag}>%{body}</%{tag}>' % { tag: tag, body: body }
  end
 end

class Savon
  class Envelope
    prepend SavonEx
  end
end
