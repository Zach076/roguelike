extends Node2D

const MobScene := preload("res://mob.tscn")

@export var spawn_interval: float = 2.0
@export var spawn_radius: float = 700.0

@onready var player: CharacterBody2D = $CharacterBody2D

var _timer: Timer

func _ready() -> void:
	_timer = Timer.new()
	_timer.wait_time = spawn_interval
	_timer.timeout.connect(_spawn_mob)
	add_child(_timer)
	_timer.start()
	_spawn_mob()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.physical_keycode == KEY_R:
		get_tree().reload_current_scene()

func _spawn_mob() -> void:
	var mob := MobScene.instantiate()
	var angle := randf() * TAU
	mob.global_position = player.global_position + Vector2.from_angle(angle) * spawn_radius
	add_child(mob)
