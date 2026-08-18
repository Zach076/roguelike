extends CharacterBody2D

const HEALTH_BAR_SIZE := Vector2(48.0, 6.0)
const HEALTH_BAR_OFFSET := Vector2(-24.0, -44.0)
const HEALTH_BAR_BACKGROUND_COLOR := Color(0.2, 0.2, 0.2, 0.8)
const HEALTH_BAR_FILL_COLOR := Color(0.8, 0.2, 0.2)

@export var speed: float = 150.0
@export var max_health: int = 100

var current_health: int
var damage_accumulator := 0.0
var health_bar_fill: ColorRect

func _ready() -> void:
	current_health = max_health
	_build_health_bar()

func _physics_process(delta: float) -> void:
	if current_health <= 0:
		get_tree().reload_current_scene()
		return

	_apply_contact_damage(delta)
	_update_health_bar()
	_move()

func _build_health_bar() -> void:
	var background := ColorRect.new()
	background.size = HEALTH_BAR_SIZE
	background.position = HEALTH_BAR_OFFSET
	background.color = HEALTH_BAR_BACKGROUND_COLOR
	add_child(background)

	health_bar_fill = ColorRect.new()
	health_bar_fill.size = HEALTH_BAR_SIZE
	health_bar_fill.position = HEALTH_BAR_OFFSET
	health_bar_fill.color = HEALTH_BAR_FILL_COLOR
	add_child(health_bar_fill)

func _update_health_bar() -> void:
	var health_ratio := float(current_health) / float(max_health)
	health_bar_fill.size.x = HEALTH_BAR_SIZE.x * health_ratio

func _apply_contact_damage(delta: float) -> void:
	var touching_mobs := _count_touching_mobs()
	damage_accumulator += touching_mobs * delta
	while damage_accumulator >= 1.0:
		current_health -= 1
		damage_accumulator -= 1.0

func _count_touching_mobs() -> int:
	var count := 0
	for mob in get_tree().get_nodes_in_group("mob"):
		if mob.touching_player:
			count += 1
	return count

func _move() -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction.normalized() * speed
	move_and_slide()
