# coding: utf-8
require 'pp'
def initialize_othello
	$board = Array.new(8).map{Array.new(8, 0)} # 8x8の2次元配列を生成 中身はすべて0
	$board[3][3] = $board[4][4] = 2 # 初期配置の白石を置く
	$board[3][4] = $board[4][3] = 1	# 初期配置の黒石を置く
	return $board
end

def move_othello(p, i, j)
	if p == 1 # pの値で場合分け。 myが自分の石 enが敵の石
		my = 1
		en = 2
	elsif p == 2
		my = 2
		en = 1
	else 
		return $board
	end
	$board[i][j] = my # 指定された場所に自分の色の石を置く
	temp = searchrow(en, my, i, j) # 列についてしらべる
	temp[0].times {|n| $board[i+n+1][j] = my} # y軸+方向の石を置く
	temp[1].times {|n| $board[i-n-1][j] = my}
	temp = searchline(en, my, i, j) # 行についてしらべる
	temp[0].times {|n| $board[i][j+n+1] = my}
	temp[1].times {|n| $board[i][j-n-1] = my}
	temp = searchslant(en, my, i,j) # ななめについてしらべる
	temp[0].times {|n| $board[i+n+1][j+n+1] = my}
	temp[1].times {|n| $board[i+n+1][j-n-1] = my}
	temp[2].times {|n| $board[i-n-1][j-n-1] = my}
	temp[3].times {|n| $board[i-n-1][j+n+1] = my}
	return $board
end



def searchrow(col, e, i, j) # 同じ列の石で上と下にいくつ自分の石と挟まれた敵の石があるかしらべて [上にある挟まれている敵の石の数, 下にある挟まれている敵の石の数]の形で返す
	c = [0,0] # カウント用配列の初期化
	y = i # iとjの値は保持して何度も利用する
	x = j
	while $board[y+1][x] == col and $board[y+1][x] != 0 # y+1つまり置いた自分の石の上に敵の色の石があるならc[0]を1増やす
		y += 1
		c[0] += 1
	end
	if $board[y+1][x] != e # 自分の石の上に敵の色の石があっても、自分の石の色と挟まれているとは限らないので、敵の石の上に自分の石があるかしらべる ないならc[0]を0に
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