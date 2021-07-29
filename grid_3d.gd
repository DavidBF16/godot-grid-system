class_name Grid3D
extends Spatial

signal grid_setted(args)

export var width := 5
export var height := 5
export var depth := 5
export var cell_size := 1
export var origin := Vector3.ZERO

var default_value = false

var _grid := { } setget _set_grid, _get_grid


func _init(_default_value = false, _width := 5, _height := 5,
		_depth := 5, _cell_size := 1,
		_origin := Vector3.ZERO):
	default_value = _default_value
	width = _width
	height = _height
	depth = _depth
	cell_size = _cell_size
	origin = _origin
	
	_generate_map()


func set_value(value, x: int, y: int, z: int):
	var cell := get_xyz(Vector3(x, y, z))
	if is_valid_vec(cell):
		_grid[Vector3(x, y, z)] = value
		return value
	else:
		return null


func set_value_vec(value, vec := Vector3.ONE * 64):
	vec = get_xyz(vec)
	var x := int(vec.x)
	var y := int(vec.y)
	var z := int(vec.z)
	return set_value(value, x, y, z)


func get_value(x: int, y: int, z: int):
	var cell := get_xyz(Vector3(x, y, z))
	if is_valid_vec(cell):
		return _grid[Vector3(x, y, z)]


func get_value_vec(vec: Vector3):
	vec = get_xyz(vec)
	var x := int(vec.x)
	var y := int(vec.y)
	var z := int(vec.z)
	return get_value(x, y, z)


func cell_to_coords(cell: Vector3) -> Vector3:
	return cell * cell_size


func coords_to_cell(coords: Vector3) -> Vector3:
	var cell_raw = coords / cell_size
	var cell = get_xyz(cell_raw)
	return cell


# nice
func get_world_pos(x: int, y: int, z: int) -> Vector3:
	return (Vector3(x, y, z) * cell_size) + origin


func get_world_pos_mid(x: int, y: int, z: int) -> Vector3:
	return get_world_pos(x, y, z) + (Vector3.ONE * cell_size) * .5


func get_local_pos(x: int, y: int, z: int) -> Vector3:
	return Vector3(x, y, z) * cell_size


func get_local_pos_mid(x: int, y: int, z: int) -> Vector3:
	return get_local_pos(x, y, z)  + (Vector3.ONE * cell_size) * .5


func is_valid(x, y, z) -> bool:
	x = int(x)
	y = int(y)
	z = int(z)
	return x >= 0 and y >= 0 and z >= 0 and x < width and y < height and z < depth


func is_valid_vec(vec: Vector3) -> bool:
	return is_valid(vec.x, vec.y, vec.z)


func get_random_cell() -> Vector3:
	randomize()
	var x := rand_range(0, width - 1)
	var y := rand_range(0, height - 1)
	var z := rand_range(0, depth - 1)
	
	var vec := Vector3(x, y, z)
	return coords_to_cell(vec)


func log_value(x: int, y: int, z: int) -> String:
	var vec = Vector3(x, y, z)
	var cell = get_xyz(vec)
	var value = get_value_vec(vec)
	var message := var2str(cell) + ": " + var2str(value)
	print(message)
	return message


func log_value_vec(vec: Vector3) -> String:
	var v := get_xyz(vec)
	
	var x := int(v.x)
	var y := int(v.y)
	var z := int(v.z)
	return log_value(x, y, z)


func get_xyz(vec: Vector3) -> Vector3:
	var v := vec
	v.x = int(floor(vec.x))
	v.y = int(floor(vec.y))
	v.z = int(floor(vec.z))
	return v


func _generate_map():
	for z in range(depth):
		for y in range(height):
			for x in range(width):
				_grid[Vector3(x, y, z)] = default_value


func _set_grid(g) -> void:
	emit_signal("grid_setted", g)


func _get_grid():
	return _grid


class Int:
	var i: int
	
	func _init(value := 0) -> void:
		i = value

