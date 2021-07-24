class_name Grid2D
extends Node2D

signal grid_setted(args)

export var width := 20
export var height := 20
export var cell_size := 64
export var origin := Vector2.ONE

var default_value = null

var _grid := { } setget set_grid, get_grid


func _ready() -> void:
	_change_default_value()
	for y in range(height):
		for x in range(width):
			_grid[Vector2(x, y)] = default_value
	
	set_value(10, 10, 10)

# Override this function
func _change_default_value():
	default_value = null


func set_value(value, x: int, y: int):
	if is_valid(x, y):
		_grid[Vector2(x, y)] = value
	else:
		_grid[Vector2(x, y)] = default_value


func set_value_pos(value, pos: Vector2):
	var x := Int.new()
	var y := Int.new()
	_get_xy(pos, x, y)
	set_value(value, x.i, y.i)


func get_value(x: int, y: int):
	if is_valid(x, y):
		return _grid[Vector2(x, y)]
	else:
		return default_value


func get_value_pos(pos: Vector2):
	var x := Int.new(int(pos.x))
	var y := Int.new(int(pos.y))
	_get_xy(pos, x, y)
	return get_value(x.i, y.i)


func set_grid(g) -> void:
	emit_signal("grid_setted", g)


func get_xy(pos: Vector2) -> Vector2:
	var x := Int.new()
	var y := Int.new()
	_get_xy(pos, x, y)
	return Vector2(x.i, y.i)


func cell_to_coords(cell: Vector2) -> Vector2:
	return cell * cell_size


func coords_to_cell(coords: Vector2) -> Vector2:
	return coords / cell_size


func get_grid():
	return _grid


func get_world_pos(x: int, y: int) -> Vector2:
	return (Vector2(x, y) * cell_size) + origin


func get_world_pos_mid(x: int, y: int) -> Vector2:
	return get_world_pos(x, y) + (Vector2.ONE * cell_size) * .5


func get_local_pos(x: int, y: int) -> Vector2:
	return get_world_pos(x, y)


func get_local_pos_mid(x: int, y: int) -> Vector2:
	return get_world_pos_mid(x, y)


func is_valid(x, y) -> bool:
	x = int(x)
	y = int(y)
	return x >= 0 and y >= 0 and x < width and y < height


func is_valid_pos(pos: Vector2) -> bool:
	return is_valid(pos.x, pos.y)


func _get_xy(pos: Vector2, x: Int, y: Int):
	x.i = int(floor(pos.x))
	y.i = int(floor(pos.y))


class Int:
	var i: int
	
	func _init(value := 0) -> void:
		i = value
