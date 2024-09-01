extends RigidBody3D

#IMPORTS
var bounce = load("res://bounce_mechanic.gd").new()

#Scaling mechanic
@export var is_scaling: bool
@export var grow_shrink: int
@export var player_throw_force: int
@export var object_throw_force: int
@onready var mesh = $Mesh
@onready var collision = $Collision
@onready var bottom = $Bottom
var rayList = []
var max_size = 3
var min_size = 0.5
var normal_size = 1
var obj_touched
var size
var last_size
enum {LARGE, NORMAL, SMALL}

# Called when the node enters the scene tree for the first time.
func _ready():
	#is_scaling = false
	size = NORMAL
	last_size = NORMAL
	rayList.append($Bottom)
	rayList.append($Top)
	rayList.append($Front)
	rayList.append($Back)
	rayList.append($Left)
	rayList.append($Right)

func _physics_process(delta):
	
	#Throw object up when bottom object is scaling
	bounce.bounce(rayList, self, false)
		
	if is_scaling:
		#set mass while growing/shrinking to avoid being drag over
		self.mass = 100
		#Grow from NORMAL to LARGE
		if (grow_shrink == 0 && last_size == NORMAL && self.scale.y < max_size):
			self.global_scale(Vector3(1.1,1.1,1.1))
			size = LARGE
			
		#Shrink from LARGE to NORMAL
		elif (grow_shrink == 1 && last_size == LARGE && self.scale.y > normal_size):
			self.global_scale(Vector3(0.9,0.9,0.9))
			size = NORMAL
		else:
			is_scaling = false
			last_size = size
	
	if size == NORMAL:
		self.mass = 1
	elif size == LARGE:
		self.mass = 70
