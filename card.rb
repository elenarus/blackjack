class Card
  attr_reader :points, :pic

  def initialize(pic, points)
    @pic = pic
    @points = points
  end

  protected

  attr_writer :points, :suit
end
