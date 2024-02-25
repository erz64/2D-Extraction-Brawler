extends CharacterBody2D
signal hit

@export var speed = 400
@onready var _animated_sprite = $AnimatedSprite2D
var screen_size
var showFront = true

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

func handleInput():
	var moveDirection = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = moveDirection*speed
	
func updateAnimation():
	if velocity.length() == 0:
		if showFront:
			_animated_sprite.play("idleFront")
		else:
			_animated_sprite.play("idleBack")
	else:
		if velocity.x < 0:
			showFront = true
			_animated_sprite.flip_h = true
			_animated_sprite.play("runHorizontal")
		if velocity.x > 0:
			showFront = true
			_animated_sprite.flip_h = false
			_animated_sprite.play("runHorizontal")
		if velocity.y < 0 and velocity.x == 0:
			showFront = false
			_animated_sprite.play("runUp")
		if velocity.y > 0 and velocity.x == 0:
			showFront = true
			_animated_sprite.play("runDown")

	
func _physics_process(_delta):
	handleInput()
	move_and_slide()
	updateAnimation()


"""func _on_body_entered(body):
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false"""
