extends CharacterBody2D

const SPEED = 100
const HandYPosOffsetIdle = [0, 1, 1, 1]
const HandYPosOffsetRun = [0, -1, 0, 1]
var Hand1MarkerStartPos 
var Hand2MarkerStartPos 
var frame

func _ready() -> void:
	Hand1MarkerStartPos = $MarkerHand1.position
	Hand2MarkerStartPos = $MarkerHand2.position

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
		
	#change animation
	if input_vector.x != 0 or input_vector.y != 0:
		$AnimatedSprite2D.play("run")
	else:
		$AnimatedSprite2D.play("idle")
		
	# hand movement
	if frame != $AnimatedSprite2D.frame:
		#reset pos
		$MarkerHand1.position = Hand1MarkerStartPos
		$MarkerHand2.position = Hand2MarkerStartPos
		
		frame = $AnimatedSprite2D.frame
		
		if $AnimatedSprite2D.animation == "idle":
			$MarkerHand1.position.y += HandYPosOffsetIdle[frame]
			$MarkerHand2.position.y += HandYPosOffsetIdle[frame]
			
		if $AnimatedSprite2D.animation == "run":
			$MarkerHand1.position.y += HandYPosOffsetRun[frame] - 2
			$MarkerHand2.position.y += HandYPosOffsetRun[frame] - 2

	move_and_slide()
