extends Node2D

var gameOn = false

func endGame() -> void:
	self.gameOn = false
	get_tree().paused = true
	self.position = Vector2(0, 0)
	self.get_node("ContinueButton").disabled = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("menu_button"):
		if get_tree().paused == false:
			get_tree().paused = true
			self.position = Vector2(0, 0)
		elif gameOn == true:
			get_tree().paused = false
			self.position = Vector2(50000, 50000)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
