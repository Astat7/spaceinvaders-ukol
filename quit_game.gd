extends Button


func quit() -> void:
	get_tree().quit()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.pressed.connect(quit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
