extends Node2D

const PLAYER_SCENE :PackedScene = preload("res://player.tscn")

@onready var slot_markers :Array[Marker2D] = [
	$PlayerSlots/Slot1,
	$PlayerSlots/Slot2,
	$PlayerSlots/Slot3,
	$PlayerSlots/Slot4,
]
@onready var round_timer :Timer = $RoundTimer/Timer
@onready var timer_label :Label = $RoundTimer/Label

const PLAYER_COUNT :int = 4
const TIME_LIMIT_SECONDS :float = 10.0

const SLOT_ACTIONS :Array[String] = ["left", "up", "right", "down"]

var players :Array[Player] = []
var rankings :Array[int] = []


func _ready() -> void:
	_create_players()
	round_timer.wait_time = TIME_LIMIT_SECONDS
	round_timer.timeout.connect(_on_round_timer_timeout)
	round_timer.start()

func _process(_delta :float) -> void:
	if round_timer.is_stopped():
		return
	timer_label.text = "Time: %.1f" % round_timer.time_left
	_check_player_input()


func _create_player(player_index :int) ->void:
	var player :Player = PLAYER_SCENE.instantiate() as Player
	var player_colour :Color = Global.PLAYER_COLOURS[player_index]
	
	rankings.append(player_index)
	
	player.setup(player_index + 1, player_colour)
	player.position = slot_markers[player_index].position
	players.append(player)
	
	add_child(player)
	
func _create_players() -> void:
	for player_index: int in range(PLAYER_COUNT):
		_create_player(player_index)

func _move_player(player: Player, destination: Vector2) -> void:
	var movement_tween :Tween = create_tween()
	movement_tween.set_trans(Tween.TRANS_QUAD)
	movement_tween.set_ease(Tween.EASE_OUT)
	movement_tween.tween_property(player, "position", destination, 0.15)

func _swap_players(player_index: int, target_player_index: int) -> void:
	if player_index == target_player_index:
		return
		
	var player_slot :int = rankings.find(player_index)
	var target_player_slot :int = rankings.find(target_player_index)
	
	rankings[player_slot] = target_player_index
	rankings[target_player_slot] = player_index
	_move_player(players[player_index], slot_markers[target_player_slot].position)
	_move_player(players[target_player_index], slot_markers[player_slot].position)

func _check_player_input() -> void:
	for player_index: int in range(PLAYER_COUNT):
		for target_player_index: int in range(PLAYER_COUNT):
			var action_name :String = "p%d_%s" % [player_index + 1, SLOT_ACTIONS[target_player_index]]
			if Input.is_action_just_pressed(action_name):
				_swap_players(player_index, target_player_index)
				
func _on_round_timer_timeout() -> void:
	timer_label.text = "Time's up!"
	Global.set_rankings(rankings)
