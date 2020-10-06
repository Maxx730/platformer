extends Area2D

export (float) var scaleSize
export (float) var scaleSpeed

var light = null
var scalingUp = true

func _ready():
	light = get_node("light")

func _process(delta):
	if light.scale.x < scaleSize && scalingUp:
		light.scale.x += .1 * delta * scaleSpeed
		light.scale.y += .1 * delta * scaleSpeed
		
		if light.scale.x >= scaleSize:
			scalingUp = false
	elif light.scale.x > 1 && !scalingUp:
		light.scale.x -= .1 * delta * scaleSpeed
		light.scale.y -= .1 * delta * scaleSpeed
		
		if light.scale.x <= 1:
			scalingUp = true
