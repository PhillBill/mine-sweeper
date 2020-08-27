extends Node2D

export (String) var color;
export (int) var mines_adjacent = 0;
export (bool) var is_mine = false;



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func set_adjacent_mines(number_of_mines):
	mines_adjacent = number_of_mines;
