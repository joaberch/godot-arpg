extends CharacterBody2D

@export var speed: int = 70
@onready var animations = $Sprite2D/AnimationPlayer


func handleInput():
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = moveDirection*speed
	
func updateAnimation():
	if velocity.length() == 0:
		if animations.is_playing():
			animations.stop()
	else: 
		var direction = "down"
		if velocity.x < 0: direction = "left"
		elif velocity.x > 0: direction = "right"
		elif velocity.y < 0: direction = "up"
		
		animations.play("walk" + direction)
	

	
func _physics_process(delta):
	handleInput()
	move_and_slide()
	updateAnimation()


func _on_hurtbox_area_entered(area): #when an area is entering a player hitbox
	if area.name == "hitbox":
		print("hurt")
