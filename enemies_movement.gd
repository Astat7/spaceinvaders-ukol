extends Node2D

var velocity = 4
var moved = true
var reskinned = false

func callCooldown():
	moved = true
	await get_tree().create_timer(1.0).timeout
	moved = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var aliens = self.get_children()
	
	while true:
		await get_tree().create_timer(clamp(0.1*self.get_child(0).enemyCount, 0.1, 0.5), false).timeout
		self.position.x += velocity
		moved = false
		
		# alien texture
		# which animation state
		var variant = "B"
		if reskinned == true:
			variant = "A"
			reskinned = false
		else:
			reskinned = true
		
		# which alien type
		for alien in aliens:
			var type = "1"
			var number = int(alien.name.erase(0, 5))
			if number <= 11:
				type = "3"
			elif number > 33:
				type = "2"
				
			alien.get_node("Sprite2D").texture = load("res://spaceinvaders-sprites/alien"+type+"_"+variant+".png")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
