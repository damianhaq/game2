extends CharacterBody2D

const SPEED = 100

func _physics_process(delta: float) -> void:

	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_axis("left", "right")
	input_vector.y = Input.get_axis("up", "down")
	input_vector = input_vector.normalized()
	
	if input_vector:
		velocity = input_vector * SPEED
	else:
		velocity = input_vector
		
		
	# flip texture
	if input_vector.x < 0:
		$AnimatedSprite2D.flip_h = true
	if input_vector.x > 0:
		$AnimatedSprite2D.flip_h = false

	move_and_slide()
