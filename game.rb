class Game
  def initialize
    @player = Player.new
    @player.ask_name
    @dealer = Player.new
    @deck = Deck.new
  end

  def init
    @can_do = { s: 'skip (s)', t: 'take card (t)', o: 'open cards (o)' }
    player.init
    dealer.init
    deck.init
  end

  def start
    init
    2.times do
      player.take_card(deck.deal_card)
      dealer.take_card(deck.deal_card)
    end
    player.bet
    dealer.bet
    loop do
      puts '--------------------'
      dealer.show
      player.show
      play
      player_check
      break unless play?
    end
  end

  protected

  COMMANDS = { s: :skip, t: :take_card, o: :open_card }
  attr_accessor :can_do, :player, :dealer, :deck

  def play
    can_do.values.each { |value| puts value }
    choice = gets.chomp.to_sym
    return unless can_do.include?(choice)
    can_do.delete(choice)
    # send COMMANDS[choice]
    method(COMMANDS[choice]).call
  end

  def play?
    can_do.size > 0 ? true : false
  end

  def play_end
    can_do.clear
  end

  def skip
    play_dealer
  end

  def take_card
    player.take_card(deck.deal_card)
    play_dealer
  end

  def open_card
    if player.dead_heat?(dealer.points)
      puts '------DEAD HEAT-----'
      player.dead_heat
      dealer.dead_heat
    elsif player.win?(dealer.points)
      puts '-------WIN----------'
      player.win
    else
      puts '-------LOSE---------'
      dealer.win
    end
    player.show_cards
    dealer.show_cards
    play_end
  end

  def play_dealer
    if dealer.cards_count == 3
      open_card
    elsif dealer.points < 18
      dealer.take_card(deck.deal_card)
    end
  end

  def player_check
    open_card if player.cards_count == 3
  end
end
