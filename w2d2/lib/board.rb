require_relative 'player'
require 'byebug'

class Board
  attr_accessor :cups, :player1, :player2

  def initialize(name1, name2)
    @player1 = name1
    @player2 = name2
    @cups = Array.new(14)
    place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    @cups.each_with_index do |el, idx|
      if idx == 6 || idx == 13
        @cups[idx] = []
      else
        @cups[idx] = [:stone, :stone, :stone, :stone] unless idx == 6 || idx == 13
      end
    end
  end

  def valid_move?(start_pos)
    raise "Invalid starting cup" unless start_pos >= 0 && start_pos < 14 && !@cups[start_pos].empty?
  end

  def make_move(start_pos, current_player_name)
    stones = @cups[start_pos].length
    @cups[start_pos] = []
    idx = 0
    stones.times do
      idx += 1
      pos = (start_pos + idx) % 14
      if (current_player_name == @player1 ? pos == 13 : pos == 6)
        idx += 1
        pos = (start_pos + idx) % 14
      end
      @cups[pos] += [:stone]
    end
    render
    end_idx = ((start_pos + idx) % 14)
    next_turn(end_idx)
  end

  def next_turn(ending_cup_idx)
    return :switch if @cups[ending_cup_idx].count == 1 && ending_cup_idx != 13 && ending_cup_idx != 6
    return :prompt if ending_cup_idx == 13 || ending_cup_idx == 6
    ending_cup_idx
    # helper method to determine what #make_move returns
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    @cups[0..5].all? {|el| el.empty?} || @cups[7..12].all? {|el| el.empty?}
  end

  def winner
    return :draw if @cups[6].length == @cups[13].length
    @cups[6].length > @cups[13].length ? @player1 : @player2
  end
end
