class Deck
  # attr_reader :cards

  def initialize
  end

  def init
    @cards = []
    suits = %w(♥ ♦ ♣ ♠)
    pics = %w(2 3 4 5 6 7 8 9 10 J Q K A)
    suits.each do |suit|
      pics.each do |pic|
        @cards << Card.new("#{pic}#{suit}", calc_points(pic))
      end
    end
    @cards.shuffle!
  end

  def deal_card
    fail 'Колода закончилась' if @cards.size == 0
    @cards.shift
  end

  protected

  def calc_points(pic)
    return 1 if pic == 'A'
    return 10 if 'J Q K'.include?(pic)
    pic.to_i
  end
end
