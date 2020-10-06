extends Area2D


export var message = 'Default Sign Message'

func _ready():
	connect("body_entered", self, "_body_entered")
	connect("body_exited", self, "_body_exited")
	

func _body_entered(body):
	if body.is_in_group("player"):
		if body.messagebox:
			body.messagepanel.visible = true
			body.messagebox.text = message

func _body_exited(body):
	if body.is_in_group("player"):
		if body.messagebox:
			body.messagepanel.visible = false
			body.messagebox.text = ''
