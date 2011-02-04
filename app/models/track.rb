class Track
  include Mongoid::Document

  field :title
  embedded_in :piece, :inverse_of => :tracks
  embeds_many :notes
end
