extends Node2D

# grid variables
export (int) var width;
export (int) var height;
export (int) var x_start;
export (int) var y_start;
export (int) var offset;

var possible_pieces = [
	preload("res://Scenes/piece_mine.tscn"),
	preload("res://Scenes/piece_empty.tscn")
];

var all_pieces  = [];

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize();
	all_pieces = make_2d_array();
	spawn_pieces();
	#print(all_pieces);

func make_2d_array():
	var array = [];
	for i in width:
		array.append([]);
		for g in height:
			array[i].append(null);
	return array;
	
func spawn_pieces():
	for i in width:
		for j in height:
			var rand = floor(rand_range(0, possible_pieces.size()));
			var piece = possible_pieces[rand].instance();
			add_child(piece);
			piece.position = grid_to_pixel(i,j);
	
func grid_to_pixel(column, row):
	return Vector2(
		x_start + offset * column,
		y_start + -offset * row
	);
