extends Node2D

var grid: Grid2D

func _ready():
	grid = Grid2D.new("Empty", 5, 5, 1, Vector2.ONE)
	randomize()
	var random := grid.get_random_cell()
	var dictionary := {
		"Entity": "Player1",
		"Level": randi() % 101,
		"Max Health": randf() * 666,
		"Is Burning": true,
	}
	grid.log_value_vec(random)
	grid.set_value_vec(dictionary, random)
	grid.log_value_vec(random)
