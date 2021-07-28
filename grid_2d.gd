class_name Grid2D
extends Node2D

signal grid_setted(args)

export var width := 20
export var height := 20
export var cell_size := 64
export var origin := Vector2.ZERO

var default_value = false

var _grid := { } setget set_grid, get_grid


func _init(_default_value = false, _width := 5, _height := 5, _cell_size := 64, _origin := Vector2.ZERO):
	default_value = _default_value
	width = _width
	height = _height
	cell_size = _cell_size
	origin = _origin
	
	_generate_map()


func set_value(value, x: int, y: int):
	if is_valid(x, y):
		_grid[Vector2(x, y)] = value
		return value


func set_value_vec(value, vec := Vector2.ONE * 64):
	var cell = get_xy(vec)
	var x := int(cell.x)
	var y := int(cell.y)
	set_value(value, x, y)


# Make sure you validate the coordinates using coords_to_cell()
func get_value(x: int, y: int):
	if is_valid(x, y):
		return _grid[Vector2(x, y)]


func get_value_vec(vec: Vector2):
	var cell = get_xy(vec)
	var x := int(cell.x)
	var y := int(cell.y)
	return get_value(x, y)


func get_xy(vec: Vector2) -> Vector2:
	var x := Int.new()
	var y := Int.new()
	_get_xy(vec, x, y)
	return Vector2(x.i, y.i)


func cell_to_coords(cell: Vector2) -> Vector2:
	return cell * cell_size


func coords_to_cell(coords: Vector2) -> Vector2:
	var cell = coords / cell_size
	cell = get_xy(cell)
	return cell


# nice
func get_world_vec(x: int, y: int) -> Vector2:
	return (Vector2(x, y) * cell_size) + origin


func get_world_vec_mid(x: int, y: int) -> Vector2:
	return get_world_vec(x, y) + (Vector2.ONE * cell_size) * .5


func get_local_vec(x: int, y: int) -> Vector2:
	return Vector2(x, y) * cell_size


func get_local_vec_mid(x: int, y: int) -> Vector2:
	return get_local_vec(x, y)  + (Vector2.ONE * cell_size) * .5


func is_valid(x, y) -> bool:
	x = int(x)
	y = int(y)
	return x >= 0 and y >= 0 and x < width and y < height


func is_valid_vec(vec: Vector2) -> bool:
	return is_valid(vec.x, vec.y)


func get_random_cell() -> Vector2:
	var x := rand_range(0, width - 1)
	var y := rand_range(0, height - 1)
	
	var vec := Vector2(x, y)
	return coords_to_cell(vec)


func log_value_vec(vec: Vector2):
	var cell = get_xy(vec)
	var value = get_value_vec(vec)
	print(var2str(cell) + ": " + var2str(value))


func _get_xy(vec: Vector2, x: Int, y: Int):
	x.i = int(floor(vec.x))
	y.i = int(floor(vec.y))


func _generate_map():
	for y in range(height):
		for x in range(width):
			_grid[Vector2(x, y)] = default_value
	print(var2str(_grid))


func set_grid(g) -> void:
	emit_signal("grid_setted", g)


func get_grid():
	return _grid


class Int:
	var i: int
	
	func _init(value := 0) -> void:
		i = value

