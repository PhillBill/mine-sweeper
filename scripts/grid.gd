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
	calculate_adjacent_mines();
	
	for i in all_pieces:
		print('[')
		for j in i:
			print(j.mines_adjacent);
		print(']')

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
			all_pieces[i][j] = piece;
			
func calculate_adjacent_mines():
	for i in width:
		for j in height:
			var piece = all_pieces[i][j];
			if !piece.is_mine:
				piece.set_adjacent_mines(
					calulcate_adjacent_mines_for_piece(width, height, i, j)
				);
	
func calulcate_adjacent_mines_for_piece(width, height, row, column):
	var count = 0;
	if column + 1 < height: 
		var top_piece = all_pieces[row][column + 1];
		if top_piece.is_mine:
			count += 1;
			
	if row + 1 < width && column + 1 < height:
		var top_right_piece = all_pieces[row + 1][column + 1];
		if top_right_piece.is_mine:
			count += 1;
			
	if row + 1 < width:
		var right_piece = all_pieces[row + 1][column];
		if right_piece.is_mine:
			count += 1;
			
	if row + 1 < width && column - 1 >= 0:
		var bottom_right = all_pieces[row + 1][column - 1];
		if bottom_right.is_mine:
			count += 1;
		
	return count;
					
func grid_to_pixel(column, row):
	return Vector2(
		x_start + offset * column,
		y_start + -offset * row
	);
