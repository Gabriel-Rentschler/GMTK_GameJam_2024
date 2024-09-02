extends RigidBody3D

#IMPORTS
var bounce = load("res://bounce_mechanic.gd").new()
@onready var anim = $AnimationPlayer

@export var is_scaling: bool
@export var grow_shrink: int
@export var cooldown_time: int
@export var player_throw_force: int
@export var object_throw_force: int
var cooldown: bool
var timelapsed: float
var rayList = []

func _ready():
	#is_scaling = false
	cooldown = false
	rayList.append($Bottom)
	rayList.append($Top)
	rayList.append($Front)
	rayList.append($Back)
	rayList.append($Left)
	rayList.append($Right)

func _physics_process(delta):
	#cooldown timelapse
	if cooldown:
		timelapsed += delta
	if timelapsed > cooldown_time:
		cooldown = false
		timelapsed = 0
	
	#Throw object up when bottom object is scaling
	bounce.bounce(rayList, self, false)
	
	#Check if any object collides with it and is not in cooldown to throw it
	for ray in rayList:
		if ray.is_colliding():
			var obj = ray.get_collider()
			if obj is RigidBody3D and !cooldown:
				is_scaling = true
	
	#play scaling animation
	if is_scaling:
		anim.play("bounce")

#puts a cooldown and resets scaling when animation stops
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	is_scaling = false
	cooldown = true
