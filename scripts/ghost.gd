extends Area2D

export (float) var floatAmount = 5
export (float) var floatSpeed;
export (float) var moveSpeed = 5
export (float) var huntDistance = 100

var floatingUp = false
var startPos
var player = null
var hunting = false

func _ready():
	startPos = position.y
	player = get_tree().get_nodes_in_group("player")[0]
	
func _draw():
	if hunting:
		draw_line(Vector2(0,0), -(global_position - player.global_position), Color(255, 0, 0), 1)

func _process(delta):
			
	#determine if the ghost should start moving towards the player or not
	if player && position.distance_to(player.position) > huntDistance:
		position += _determine_move_dir(player) * delta
		hunting = true
	else:
		hunting = false
		#idle animation 
		if floatingUp:
			global_position.y -= floatAmount * delta
			if global_position.y <= startPos - floatAmount:
				floatingUp = false
		else:
			global_position.y += floatAmount * delta
			if global_position.y >= startPos + floatAmount:
				floatingUp = true
	update()
	

func _determine_move_dir(player):
	var moveDir = Vector2(0, 0)
	if player.position.x > position.x:
		moveDir.x += moveSpeed
	else:
		moveDir.x -= moveSpeed
	
	if player.position.y > position.y:
		moveDir.y += moveSpeed / 3
	else:
		moveDir.y -= moveSpeed / 3

	
	return moveDir
