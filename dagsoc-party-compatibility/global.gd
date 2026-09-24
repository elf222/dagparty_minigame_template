extends Node

const PLAYER_COLOURS = [
	Color("F27C6F"),
	Color("28AAD4"),
	Color("F8FF57"),
	Color("523FB0")
]

var player_faces : Array[FaceData]= [FaceData.new(), FaceData.new(), FaceData.new(), FaceData.new()]
var player_positions = [0,0,0,0]

var player_turn = 0 #eg: 0 means it's player 1's turn
var round = 1

func next_turn():
	var pos = rankings.find(player_turn)
	print("pos is %s" % str(pos))
	if pos >= 3 or pos < 0:
		return false
	player_turn = rankings[pos+1]
	return true	

var rankings = [0,1,2,3] #Must be set using set_rankings when a minigame ends.


func set_rankings(ranks : Array[int]):
	rankings = []
	if len(ranks) != 4: return
	var seen = []
	for i in ranks:
		if i in seen or i < 0 or i > 3: return
		seen.append(i)
	rankings = ranks
