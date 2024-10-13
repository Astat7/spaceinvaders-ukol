extends CharacterBody2D

var lifes = 3

var veloc = Vector2(0, 0)
signal lifeChanged

func destroy() -> void:
	var explosion = Sprite2D.new()
	explosion.texture = load("res://spaceinvaders-sprites/explosion_plr.png")
	explosion.position = self.global_position/3 + Vector2(self.get_node("Sprite2D").texture.get_width()/2, self.get_node("Sprite2D").texture.get_height()/2)
	
	if lifes > 1:
		self.position.x = 105
	else:
		self.position.y = -1500
		%Menu.endGame()
	
	lifes -= 1
	lifeChanged.emit()
	%LifesLabel.text = str(lifes)
	
	%Explosions.add_child(explosion)
	await get_tree().create_timer(0.25, false).timeout
	if is_instance_valid(explosion):
		explosion.queue_free()


func reset() -> void:
	lifes = 3
	lifeChanged.emit()
	self.position = Vector2(105, 216)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		if %Laser.position.y <= -4:
			%Laser.position = self.position + Vector2(6, -4)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	veloc.x = 0
	
	
	if Input.is_action_pressed("move_right"):
		veloc.x += 1
	if Input.is_action_pressed("move_left"):
		veloc.x -= 1
	
	# move
	self.position.x = clamp(self.position.x+veloc.x, 7, 204)
