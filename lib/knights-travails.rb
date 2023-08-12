class Knight
  attr_reader :position, :parent

  MOVES = [[1, 2], [-1, -2], [-1, 2], [1, -2], [2, 1], [-2, -1], [-2, 1], [2, -1]]
  BOARD_POSITIONS = (0..7).to_a.repeated_permutation(2).to_a

  def initialize(position, parent = nil)
    @position = position
    @parent = parent
    @@path = []
    @@path << position
  end

  def children
    MOVES.map { |move| [@position[0] + move[0], @position[1] + move[1]] }
         .keep_if { |position| BOARD_POSITIONS.include?(position) }
         .reject { |position| @@path.include?(position) }
         .map { |position| Knight.new(position, self) }
  end
end

class Board
  def initialize(start, destination)
    @shortest_path = []
    knight_moves(start, destination)
  end

  def knight_moves(start, destination)
    queue = []
    current = Knight.new(start)
    until current.position == destination
      current.children.each { |child| queue << child }
      current = queue.shift
    end

    get_parent(current)
    puts "\n> knight_moves([#{start.join(', ')}], [#{destination.join(', ')}])\n"
    puts "You made it in #{@shortest_path.size} moves! Here's your path: "
    @shortest_path.each { |position| p position }
  end

  def get_parent(node)
    get_parent(node.parent) unless node.parent.nil?
    @shortest_path << node.position
  end
end

game = Board.new([0, 0], [1, 2])
game = Board.new([0, 0], [3, 3])
game = Board.new([3, 3], [0, 0])
