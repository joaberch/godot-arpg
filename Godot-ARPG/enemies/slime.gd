extends CharacterBody2D

@export var speed = 20
@export var limit = 0.5
@export var endPoint: Marker2D
@onready var animations = $Sprite2D/AnimationPlayer

var startPosition
var endPosition
var animationstring

func _ready():
	startPosition = position
	endPosition = endPoint.global_position
	
func changeDirection():
	var tempEnd = endPosition
	endPosition = startPosition
	startPosition = tempEnd
	
func updateVelocity():
	var moveDirection = (endPosition - position)
	if moveDirection.length() < limit:
		changeDirection()
		
	velocity = moveDirection.normalized()*speed
	
func updateAnimation():
	if velocity.y > 0:
		animationstring = "walkdown"
	elif velocity.y < 0:
		animationstring = "walkup"
	if velocity.x > 0:
		animationstring = "walkright"
	elif velocity.x < 0:
		animationstring = "walkleft"
	
	animations.play(animationstring)
	
	if velocity.x == 0 && velocity.y == 0:
		animations.stop()

func _physics_process(delta):
	updateVelocity()
	move_and_slide()
	updateAnimation()
