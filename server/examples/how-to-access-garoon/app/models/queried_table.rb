class QueriedTable
  include Mongoid::Document
  field :table_name
  field :last_queried_time
end
