extends Area2D

export (String) var contents = null

func _ready():
	connect("body_entered", self, "_body_entered")
	connect("body_exited", self, "_body_exited")
	
func _body_entered(body):
	if body.is_in_group("player"):
		body._toggle_emote()
		
func _body_exited(body):
	if body.is_in_group("player"):
		body._toggle_emote()
