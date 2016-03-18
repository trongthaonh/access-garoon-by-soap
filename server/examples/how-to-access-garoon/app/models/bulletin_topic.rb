class BulletinTopic
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  def subset
    {
      id: self[:@id],
      subject: self[:@subject],
      creator: {
        name: self[:creator][:@name],
        date: self[:creator][:@date]
      }
    }
  end
end
