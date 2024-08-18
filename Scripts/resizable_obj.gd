extends RigidBody3D

#Scaling mechanic
@export var is_scaling: bool;
@onready var mesh = $Mesh
@onready var collision = $Collision
@onready var bottom = $Bottom
var rayList = []
var max_size = 3
var min_size = 0.5
var obj_touched
var size
enum {LARGE, NORMAL, SMALL}


# Called when the node enters the scene tree for the first time.
func _ready():
	is_scaling = false
	rayList.append($Bottom)
	rayList.append($Top)
	rayList.append($Front)
	rayList.append($Back)
	rayList.append($Left)
	rayList.append($Right)

func _physics_process(delta):
	
	#Throw object up when bottom object is scaling
	for ray in rayList:
		if ray.is_colliding():
			var obj = ray.get_collider()
			if obj is RigidBody3D and obj.get_groups().find("resizable"):
				if obj.is_scaling:
					apply_central_impulse(Vector3(0,1,0) * 2.0)
	
	if (is_scaling and self.scale.y < max_size):
		#mesh.scale_object_local(Vector3(2,2,2))
		self.mass += 10
		self.scale_object_local(Vector3(1.2,1.2,1.2))
	else:
		is_scaling = false
