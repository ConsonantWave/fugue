module PiecesHelper
  def note_height_ratio
    @note_height_ratio ||= 100.0 / @piece.division
  end
end
