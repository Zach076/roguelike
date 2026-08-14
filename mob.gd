extends CharacterBody2D

@export var speed: float = 100.0
@export var health: int = 10

@onready var player: CharacterBody2D = get_node("../CharacterBody2D")

func _physics_process(_delta: float) -> void:
	var direction := (player.global_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()
