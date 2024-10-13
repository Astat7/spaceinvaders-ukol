extends StaticBody2D

var inGame = false
var score = 300

func destroy(naturally=false):
	inGame = false
	if naturally == false:
		%ScoreLabel.text = "%04d" % (int(%ScoreLabel.text)+score)
	
	# explosion
	var explosion = Sprite2D.new()
	explosion.texture = load("res://spaceinvaders-sprites/explosion_ufo.png")
	explosion.position = self.global_position/3 + Vector2(8, 3.5)
	
	self.position.x = -32
	%Explosions.add_child(explosion)
	await get_tree().create_timer(0.25, false).timeout
	if is_instance_valid(explosion):
		explosion.queue_free()

func spawn():
	inGame = true
	while self.position.x < 240:
		if inGame == false:
			break
		await get_tree().create_timer(0.125).timeout
		self.position.x += 3
	destroy(true)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# spawn ufo at random time
	if inGame == false:
		if randi_range(1, 1200) == 1:
			spawn()
