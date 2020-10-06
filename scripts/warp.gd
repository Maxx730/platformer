extends Area2D

export (String) var warpPath
var canEnter = false

func _ready():
	connect('body_entered', self, '_body_entered')
	connect('body_exited', self, '_body_exited')
	
func _body_entered(body):
	if body.is_in_group('player'):
		#we want to tell the player to press w if they would like to go through the warp
		if body.actions:
			body.actions.visible = true
			canEnter = true

func _body_exited(body):
	if body.is_in_group('player'):
		if body.actions:
			body.actions.visible = false
			canEnter = false

func _process(delta):
	if Input.is_action_just_pressed("ui_up") && canEnter:
		get_tree().change_scene(warpPath)
