require 'savon/envelope'

module SavonEx
  # Public: Sets the request custom header Hash.
  attr_accessor :custom_header

  # Public: Build the request XML for this operation.
  def build
    Savon::Envelope.new(@operation, header, body, custom_header).to_s
  end
end

class Savon
  class Operation
    prepend SavonEx
  end
end
