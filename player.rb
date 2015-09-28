class Player
  BET = 10

  def initialize(name = 'Dealer')
    @name = name
    @money = 100
  end

  def init
    @cards = []
  end

  def ask_name
    print 'Your name: '
    @name = gets.chomp.to_s
  end

  def bet
    fail "#{@name}: закончились деньги" if @money - BET < 0
    @money -= BET
  end

  def dead_heat
    @money += BET
  end

  def win
    @money += BET * 2
  end

  def points
    points = 0
    @cards.each do |card|
      points += card.points
    end
    @cards.each do |card|
      points += 10 if card.points == 1 && (points + 10) <= 21
    end
    points
  end

  def cards_count
    @cards.size
  end

  def lose?
    points > 21
  end

  def blackjack?
    points == 21
  end

  def dead_heat?(points_another_player)
    points == points_another_player
  end

  def win?(points_another_player)
    return false if lose?
    points > points_another_player || blackjack?
  end

  def take_card(card)
    @cards << card
  end

  def show
    puts "#{@name}"
    puts "#{@money}$"
    unless @name == 'Dealer'
      puts "points: #{points}"
      @cards.each { |card| puts "#{card.pic} " }
    end
    puts '--------------------'
  end

  def show_cards
    puts "#{@name}"
    puts "#{@money}$"
    puts "points: #{points}"
    @cards.each { |card| puts "#{card.pic} " }
    puts '--------------------'
  end
end
