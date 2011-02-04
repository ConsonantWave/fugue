class Note
  include Mongoid::Document

  field :pitch, :type => Integer
  field :start, :type => Integer
  field :length, :type => Integer
  embedded_in :track, :inverse_of => :notes
end
