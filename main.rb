require_relative 'card'
require_relative 'deck'
require_relative 'player'
require_relative 'game'

begin
  game = Game.new
  loop do
    game.start
    puts 'Next game?(y/n)'
    choice = gets.chomp
    break unless choice == 'y'
  end
rescue RuntimeError => e
  puts "#{e.message}"
end
