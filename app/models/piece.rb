class Piece
  include Mongoid::Document

  field :title
  field :tempo, :type => Integer
  field :division, :type => Integer
  embeds_many :tracks
end
