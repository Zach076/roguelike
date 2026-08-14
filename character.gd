extends CharacterBody2D

@export var speed: float = 150.0
@export var health: int = 100

func _physics_process(_delta: float) -> void:
	var input := Vector2.ZERO
	input.x = Input.get_axis("move_left", "move_right")
	input.y = Input.get_axis("move_up", "move_down")
	velocity = input.normalized() * speed
	move_and_slide()
