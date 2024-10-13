extends Node2D

func reset():
	for bunker in self.get_children():
		for segment in bunker.get_children():
			if segment.global_position.x < 0:
				segment.position.x += 500

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
