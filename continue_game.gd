extends Button

func continue_game() -> void:
	if self.get_parent().gameOn == true:
		get_tree().paused = false
		%Menu.position = Vector2(50000, 50000)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.pressed.connect(continue_game)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
