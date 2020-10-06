extends KinematicBody2D

var velocity = Vector2(0,0)
var can_collect = false

func _ready():
	$pickup.connect("body_entered", self, "_body_entered")

func _physics_process(delta):
	_apply_gravity(delta)
	move_and_slide(velocity, Vector2(0, -1))

func _apply_gravity(delta):
	if !is_on_floor():
		velocity.y += 9.8
	else:
		velocity = Vector2(0, 0)
		can_collect = true

func _body_entered(body):
	if body.is_in_group("player") && can_collect:
		body._add_money(1)
		queue_free()
