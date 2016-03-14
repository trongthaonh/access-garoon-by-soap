require 'nokogiri'
require 'savon/wsdl/document'

module SavonEx
  def import(location)
    @import_locations = []

    @logger.info("Resolving WSDL document #{location.inspect}.")

    import_document(location) do |document, location|
      @documents << document
      uri = URI.parse(location)
      new_schemas = []

      document.schemas.each do |schema|
        new_schema = schema
        new_imports = {}

        new_schema.imports.each do |namespace, schema_location|
          if schema_location and !absolute_url? schema_location
            if schema_location.start_with? "/"
              new_imports[namespace] = uri.scheme + "://" + uri.host + ":" + uri.port.to_s + schema_location
            else
              new_imports[namespace] = uri.merge(schema_location).to_s
            end
          end
        end

        new_schema.imports = new_imports
        new_schemas.push(new_schema)
      end

      @schemas.push(new_schemas)
    end

    # resolve xml schema imports
    uri = URI.parse(location)

    import_schemas do |schema_location|
      @logger.info("Resolving XML schema import #{schema_location.inspect}.")

      import_document(schema_location) do |document|
        @schemas.push(document.schemas)
      end
    end
  end

  private

  def import_document(location, &block)
    if @import_locations.include? location
      @logger.info("Skipping already imported location #{location.inspect}.")
      return
    end

    xml = @resolver.resolve(location)
    @import_locations << location

    document = Savon::WSDL::Document.new Nokogiri.XML(xml), @schemas
    block.call(document, location)

    # resolve wsdl imports
    uri = URI.parse(location)

    document.imports.each do |import_location|
      if !absolute_url? import_location
        if import_location.start_with? "/"
          import_location = uri.scheme + "://" + uri.host + ":" + uri.port.to_s + import_location
        else
          import_location = uri.merge(import_location).to_s
        end
      end

      @logger.info("Resolving WSDL import #{import_location.inspect}.")
      import_document(import_location, &block)
    end
  end
end

class Savon
  class Importer
    prepend SavonEx
  end
end
