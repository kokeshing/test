# coding: utf-8
require 'pp'
def initialize_othello
	$board = Array.new(8).map{Array.new(8, 0)}
	$board[3][3] = $board[4][4] = 2
	$board[3][4] = $board[4][3] = 1
	return $board
end

def move_othello(p, i, j)
	if p == 1
		my = 1
		en = 2
	elsif p == 2
		my = 2
		en = 1
	else 
		return $board
	end
	$board[i][j] = my
	temp = searchrow(en, my, i, j)
	temp[0].times {|n| $board[i+n+1][j] = my}
	temp[1].times {|n| $board[i-n-1][j] = my}
	temp = searchline(en, my, i, j)
	temp[0].times {|n| $board[i][j+n+1] = my}
	temp[1].times {|n| $board[i][j-n-1] = my}
	temp = searchslant(en, my, i,j)
	temp[0].times {|n| $board[i+n+1][j+n+1] = my}
	temp[1].times {|n| $board[i+n+1][j-n-1] = my}
	temp[2].times {|n| $board[i-n-1][j-n-1] = my}
	temp[3].times {|n| $board[i-n-1][j+n+1] = my}
	return $board
end



def searchrow(col, e, i, j)
	c = [0,0]
	y = i
	x = j
	while $board[y+1][x] == col and $board[y+1][x] != 0
		y += 1
		c[0] += 1
	end
	if $board[y+1][x] != e
		c[0] = 0
	end
	y = i
	while $board[y-1][x] == col and $board[y-1][x] != 0
		y -= 1
		c[1] += 1
	end
	if $board[y-1][x] != e
		c[1] = 0
	end
	return c
end

def searchline(col, e, i, j)
	c = [0,0]
	y = i
	x = j
	while $board[y][x+1] == col and $board[y][x+1] != 0
		x += 1
		c[0] += 1
	end
	if $board[y][x+1] != e
		c[0] = 0
	end
	x = j
	while $board[y][x-1] == col and $board[y][x-1] != 0
		x -= 1
		c[1] += 1
	end
	if $board[y][x-1] != e
		c[1] = 0
	end
	return c
end

def searchslant(col, e, i, j)
	c = [0, 0, 0, 0]
	y = i
	x = j
	while $board[y+1][x+1] == col and $board[y+1][x+1] != 0
		x += 1
		y += 1
		c[0] += 1
	end
	if $board[y+1][x+1] != e
		c[0] = 0
	end
	y = i
	x = j
	while $board[y+1][x-1] == col and $board[y+1][x-1] != 0
		x -= 1
		y += 1
		c[1] += 1
	end
	if $board[y+1][x-1] != e
		c[1] = 0
	end
	y = i
	x = j
	while $board[y-1][x-1] == col and $board[y-1][x-1] != 0
		x -= 1
		y -= 1
		c[2] += 1
	end
	if $board[y-1][x-1] != e
		c[2] = 0
	end
	y = i
	x = j
	while $board[y-1][x+1] == col and $board[y-1][x+1] != 0
		x += 1
		y -= 1
		c[3] += 1
	end
	if $board[y-1][x+1] != e
		c[3] = 0
	end
	return c
end