class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def play
    until game_over
      take_turn
      system('clear')
    end
    game_over_message
    reset_game
  end

  def take_turn
    show_sequence
    require_sequence
    round_success_message
    @sequence_length += 1
  end

  def show_sequence
    puts "Current sequence:"
    add_random_color

    @seq.each do |color|
      puts color
      sleep(0.5)
      system('clear')
    end
  end

  def require_sequence
    puts "Enter your sequence one by one:"
    sequence = []
    @seq.each do |color|
      input = gets.chomp
      sequence << input
      break if input != color
    end
    @game_over = true unless sequence == @seq
  end

  def add_random_color
    @seq << COLORS.sample
  end

  def round_success_message
    @game_over ? puts("You suck") : puts("Not bad")
  end

  def game_over_message
    puts "You memorized #{@sequence_length - 2} colors."
  end

  def reset_game
    @sequence_length = 1
    @game_over = false
    @seq = []
    play
  end
end

if __FILE__ == $PROGRAM_NAME
  Simon.new.play
end
