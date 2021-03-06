extends KinematicBody2D

var speed = 85
var jump_power = 250
var jumping = false
var gravity = 10
var sprite = null
var anim = null
var velocity = Vector2(0,0)
var emotes = null
var actions = null
var dust = null
var fps = null
var attack_anim = null
var attack_sprite = null
var attack_collider = null
var messagepanel = null
var messagebox = null
var moneycount = null

#visible values
var money = 0

func _ready():
	sprite = get_node("sprite")
	anim = get_node("player")
	messagepanel = get_node("ui/box")
	messagebox = get_node("ui/box/message")
	moneycount = get_node("ui/status/money/frame/count")
	emotes =  get_node("emotes")
	actions = get_node("input_actions")
	dust = get_node("dust")
	fps = get_node("ui/status/stats/FPS")
	attack_anim = get_node("attack/attack_player")
	attack_sprite = get_node("attack")
	attack_collider = get_node("attack_collision")
	attack_anim.connect("animation_finished", self, "_attack_finished")

	
	_add_money(0)

func _input(event):		
	if event is InputEventMouseButton:
		print('mouse button event occuring')



func _physics_process(delta):
	fps.text = "FPS :: " + String(Engine.get_frames_per_second())
	var collisions = move_and_slide(velocity, Vector2(0, -1))
	#check what the player has collided with
	_apply_gravity(delta)
	
	if Input.is_action_pressed("ui_right"):
		anim.play("sword_run")
		velocity.x = speed
		sprite.flip_h = false
		var emotSprite = emotes.get_node("sprite")
		emotSprite.flip_h = true
		emotSprite.position.x = 8
		dust.emitting = true
		dust.position.x = -7
		attack_sprite.flip_h = false
		attack_collider.position = Vector2(18.7, -1.2)
	elif Input.is_action_pressed("ui_left"):
		anim.play("sword_run")
		velocity.x = -speed
		sprite.flip_h = true
		var emotSprite = emotes.get_node("sprite")
		emotSprite.flip_h = false
		emotSprite.position.x = -8
		dust.emitting = true
		dust.position.x = 7
		attack_sprite.flip_h = true
		attack_collider.position = Vector2(-18.2, -1.2)
	else:
		velocity.x = 0
		dust.emitting = false
		anim.play("sword_idle")
		
	if Input.is_action_just_pressed("ui_select") && !jumping:
		velocity.y = -jump_power
		jumping = true
		dust.emitting = false
	elif jumping:
		anim.play("jump")
		dust.emitting = false
	
	if velocity.y > 0 && jumping:
		anim.play("falling")
		
	if Input.is_action_just_pressed("attack"):
		attack_collider.visible = true
		sprite.visible = false
		attack_sprite.visible = true
		attack_anim.play()

func _apply_gravity(delta):
	if is_on_floor():
		velocity.y = 0
		jumping = false
	else:
		velocity.y += gravity

func _add_money(value):
	money += value
	var moneyString = ""
	for i  in range(6 - String(money).length()):
		moneyString += "0"
	moneycount.text = moneyString + String(money)

func _toggle_emote():
	emotes.visible = !emotes.visible

func _attack_finished(animation):
	attack_collider.visible = false
	sprite.visible = true
	attack_sprite.visible = false