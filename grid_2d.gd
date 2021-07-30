class_name Grid2D
extends Node2D

signal grid_setted(args)

export var width := 5
export var height := 5
export var cell_size := 64
export var origin := Vector2.ZERO


var _grid := { } setget _set_grid, _get_grid


func _init(_width := 5, _height := 5, _cell_size := 64,
		_origin := Vector2.ZERO):
	width = _width
	height = _height
	cell_size = _cell_size
	origin = _origin
	


func set_value(value, x: int, y: int):
	if is_valid(x, y):
		_grid[get_xy(Vector2(x, y))] = value
		return value


func set_value_vec(value, vec: Vector2):
	var cell = get_xy(vec)
	var x := int(cell.x)
	var y := int(cell.y)
	set_value(value, x, y)


# Make sure you validate the coordinates using coords_to_cell()
func get_value(x: int, y: int):
	var cell := get_xy(Vector2(x, y))
	if is_valid_vec(cell) and _grid.has(cell):
		return _grid[Vector2(x, y)]


func get_value_vec(vec: Vector2):
	var x := int(vec.x)
	var y := int(vec.y)
	return get_value(x, y)


func cell_to_coords(cell: Vector2) -> Vector2:
	return cell * cell_size


func coords_to_cell(coords: Vector2) -> Vector2:
	var cell = coords / cell_size
	cell = get_xy(cell)
	return cell


func get_world_pos(x: int, y: int) -> Vector2:
	return (Vector2(x, y) * cell_size) + origin


func get_world_pos_mid(x: int, y: int) -> Vector2:
	return get_world_pos(x, y) + (Vector2.ONE * cell_size) * .5


func get_local_pos(x: int, y: int) -> Vector2:
# nice
	return Vector2(x, y) * cell_size


func get_local_pos_mid(x: int, y: int) -> Vector2:
	return get_local_pos(x, y)  + (Vector2.ONE * cell_size) * .5


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


func log_value(x: int, y: int):
	var vec = Vector2(x, y)
	var cell = get_xy(vec)
	var value = get_value_vec(vec)
	if _grid.has(cell):
		var message := var2str(cell) + ": " + var2str(value)
		print(message)
		return message


func log_value_vec(vec: Vector2):
	var v := get_xy(vec)
	
	var x := int(v.x)
	var y := int(v.y)
	if _grid.has(Vector2(x, y)):
		return log_value(x, y)


func get_xy(vec: Vector2) -> Vector2:
	var v := vec
	v.x = int(floor(vec.x))
	v.y = int(floor(vec.y))
	return v


func _set_grid(g) -> void:
	emit_signal("grid_setted", g)


func _get_grid():
	return _grid


class Int:
	var i: int
	
	func _init(value := 0) -> void:
		i = value
