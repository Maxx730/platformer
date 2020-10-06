extends Area2D

var anim = null
var opened = false
onready var coin = preload("res://scenes/collectables/coin.tscn")
var rng = RandomNumberGenerator.new()

func _ready():
	anim = get_node("sprite")
	connect("body_entered", self, "_body_entered")
	rng.randomize()

func _body_entered(body):
	if body.is_in_group("player") && !opened:
		anim.play()
		opened = true
		for i in range(10):
			#spawn a coin
			var newcoin = coin.instance()
			newcoin.velocity = Vector2(rng.randi_range(-100, 100), rng.randi_range(-200, -100))
			add_child(newcoin)
			newcoin.global_position = Vector2(global_position.x, global_position.y)
