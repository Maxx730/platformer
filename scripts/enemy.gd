extends KinematicBody2D

var sprite = null
var anim = null
var player = null
var collider = null
var gravity = 9.8
var velocity = Vector2(0, 0)

func _ready():
	sprite = get_node("sprite")
	anim = get_node("player")
	collider = get_node("collider")
	player = get_parent().get_node("player")

func _draw():
	draw_line(Vector2(0,0), -(global_position - player.global_position), Color(255, 255, 0), 1)
	
func _process(delta):
	update()
	var collisions = move_and_slide(velocity, Vector2(0, -1))
	
	#apply gravity
	_apply_gravity(delta)

func _apply_gravity(delta):
	if is_on_floor():
		velocity.y = 0
		#jumping = false
	else:
		velocity.y += gravity