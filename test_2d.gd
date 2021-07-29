extends Node2D

onready var grid := $Grid2D

func _ready():
	add_child(grid)
	grid.set_owner(get_tree().get_edited_scene_root())
	grid = Grid2D.new("Empty", 5, 5, 1, Vector2.ONE, true)
	randomize()
	var random = grid.get_random_cell()
	var dictionary := {
		"Entity": "Player1",
		"Level": randi() % 101,
		"Max Health": randf() * 666,
		"Is Burning": true,
	}
	grid.log_value_vec(random)
	grid.set_value_vec(dictionary, random)
	grid.log_value_vec(random)
