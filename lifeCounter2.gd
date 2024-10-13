extends "res://lifeCounter.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	requiredLifes = 3
	%Player.lifeChanged.connect(toggleVisibility)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
