extends CharacterBody2D

const CONTACT_DISTANCE := 20.0

@export var speed: float = 100.0
@export var health: int = 10

@onready var player: CharacterBody2D = get_node("../CharacterBody2D")

var touching_player := false

func _ready() -> void:
	add_to_group("mob")

func _physics_process(_delta: float) -> void:
	touching_player = _touching_player()
	var direction := (player.global_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()

func _touching_player() -> bool:
	return global_position.distance_to(player.global_position) <= CONTACT_DISTANCE
