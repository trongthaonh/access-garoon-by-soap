class QueriedTable
  include Mongoid::Document

  field :table_name
  field :end_time

  after_initialize :after_initialize

  attr_reader :start_time

  def after_initialize
    @start_time = self.end_time
    @start_time ||= Time.gm(1970, 1, 2, 0, 0, 0)
    @start_time += 1
    self.end_time = Time.now
  end
end
