extends Node2D

const CIRCLE_RADIUS: float = 42.0

var _player_number :int = 0
var _player_colour :Color = Color.WHITE


func setup(new_player_number: int, new_player_colour: Color) -> void:
	_player_number = new_player_number
	_player_colour = new_player_colour
	queue_redraw()


func _draw() -> void:
	draw_circle(Vector2.ZERO, CIRCLE_RADIUS, _player_colour)
	draw_arc(Vector2.ZERO, CIRCLE_RADIUS, 0.0, TAU, 48, Color.WHITE, 3.0, true)
	
	var player_text :String = "P%d" % _player_number
	var font :Font = ThemeDB.fallback_font
	var font_size :int = 25
	var text_size :Vector2 = font.get_string_size(player_text, HORIZONTAL_ALIGNMENT_LEFT, -1.0, font_size)
	var text_position :Vector2 = Vector2(-text_size.x * 0.5, text_size.y * 0.35)
	
	draw_string(font, text_position, player_text, HORIZONTAL_ALIGNMENT_LEFT, -1.0, font_size, Color.BLACK)
