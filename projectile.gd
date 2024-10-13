extends StaticBody2D

var speed = -20
var enemySpawned = false

const green = Color(66/255., 1, 132/255.)
const red = Color(1, 24/255., 0)
const white = Color(1, 1, 1)

func destroy() -> void:
	if enemySpawned == false:
		self.position = Vector2(-130, -50)
	else:
		queue_free()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	while true:
		await get_tree().create_timer(0.0625, false).timeout
		var target = self.move_and_collide(Vector2(0, speed))
		if target:
			if target.get_collider().get_parent().get_parent().name == "Bunkers":
				target.get_collider().position.x -= 500
			else: 
				target.get_collider().destroy()
			destroy()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# color change
	#if self.get_child(0):
	if self.position.y >= 172:
		self.get_child(0).color = green
	elif self.position.y <= 25:
		self.get_child(0).color = red
	else:
		self.get_child(0).color = white
			
	if enemySpawned == true:
		if self.position.y >= 300:
			queue_free()
		elif self.position.y >= 172:
			self.get_child(2).color = green
		else:
			self.get_child(2).color = white
