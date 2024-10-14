extends StaticBody2D

static var enemyCount = 55
var score = 20

@onready var parent = self.get_parent()
var inGame = true
var offSet = self.position

func destroy() -> void:
	if inGame == true:
		inGame = false
		enemyCount -= 1
		
		%ScoreLabel.text = "%04d" % (int(%ScoreLabel.text)+score)
		
		var explosion = Sprite2D.new()
		explosion.texture = load("res://spaceinvaders-sprites/explosion.png")
		explosion.position = self.global_position/3 + Vector2(self.get_node("Sprite2D").texture.get_width()/2, self.get_node("Sprite2D").texture.get_height()/2)
		
		self.position = Vector2(400, 1000)
		%Explosions.add_child(explosion)
		await get_tree().create_timer(0.25, false).timeout
		if is_instance_valid(explosion):
			explosion.queue_free()
	
func respawn() -> void:
	if inGame == false:
		inGame = true
		enemyCount += 1
	self.position = offSet

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	# set score
	var number = int(self.name.erase(0, 5))
	if number <= 11:
		score = 30
	elif number > 33:
		score = 10


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if inGame == true:
		
		# shoot
		if randi_range(1, 65*enemyCount) == 1:
			
			var projectile = StaticBody2D.new()
			projectile.position = self.global_position/3 + Vector2(self.get_node("Sprite2D").texture.get_width()/2, self.get_node("Sprite2D").texture.get_height())
			projectile.set_collision_mask_value(3, true)
			projectile.set_collision_mask_value(3, true)
			
			# first shape
			var projRect = ColorRect.new()
			projRect.size = Vector2(1, 5)
			projectile.add_child(projRect)
			
			var projCollision = CollisionShape2D.new()
			var shape = RectangleShape2D.new()
			shape.size = Vector2(1, 5)
			projCollision.shape = shape
			projCollision.position = Vector2(0.5, 2.5)
			projectile.add_child(projCollision)
			
			# second shape
			projRect = ColorRect.new()
			projRect.size = Vector2(3, 1)
			projRect.position = Vector2(-1, 0)
			projectile.add_child(projRect)
			
			projCollision = CollisionShape2D.new()
			shape = RectangleShape2D.new()
			shape.size = Vector2(3, 1)
			projCollision.shape = shape
			projCollision.position = Vector2(0.5, 0.5)
			projectile.add_child(projCollision)
			
			# script
			projectile.set_script(load("res://projectile.gd"))
			projectile.enemySpawned = true
			projectile.speed = 20
			
			%Explosions.add_child(projectile)
		
		# move verticaly
		if self.global_position.x <= 24:
			parent.velocity = abs(parent.velocity)
			if parent.moved == false:
				parent.callCooldown()
				await get_tree().create_timer(clamp(0.25*(enemyCount-3), 0, 0.25), false).timeout
				parent.position.y += 4
		elif self.global_position.x >= 204*3:
			parent.velocity = -abs(parent.velocity)
			if parent.moved == false:
				parent.callCooldown()
				await get_tree().create_timer(clamp(0.25*(enemyCount-3), 0, 0.25), false).timeout
				parent.position.y += 4
				
		# win
		if self.global_position.y >= 166*3:
			%Menu.endGame()
