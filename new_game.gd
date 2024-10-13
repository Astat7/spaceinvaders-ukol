extends Button

func new_game() -> void:
	%ScoreLabel.text = "0000"
	%Player.reset()
	%LifesLabel.text = "3"
	
	
	%Menu.get_node("ContinueButton").disabled = false
	%Menu.gameOn = true
	get_tree().paused = false
	%Menu.position = Vector2(50000, 50000)
	
	# reset bunkers
	%Bunkers.reset()
	
	# reset ufo
	%UFO.destroy(true)
	
	# reset aliens
	%Enemies.velocity = abs(%Enemies.velocity)
	%Enemies.position = Vector2(24, 32)
	for alien in %Enemies.get_children():
		alien.respawn()
	
	# clear explosion and projectiles
	%Laser.position = Vector2(-130, -50)
	for i in %Explosions.get_children():
		i.queue_free()
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.pressed.connect(new_game)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
