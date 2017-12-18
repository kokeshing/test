# test
def initialize_othello
	$board = Array.new(8).map{Array.new(8, 0)}
	$board[3][3] = $board[4][4] = 2
	$board[3][4] = $board[4][3] = 1
	return $board
end
