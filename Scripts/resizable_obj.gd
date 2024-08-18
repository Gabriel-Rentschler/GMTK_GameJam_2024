extends RigidBody3D

#Scaling mechanic
@export var is_expanding: bool;
@onready var mesh = $Mesh
@onready var collision = $Collision
@onready var bottom = $Bottom
var max_size = 4
var obj_touched


# Called when the node enters the scene tree for the first time.
func _ready():
	is_expanding = false

func _physics_process(delta):
	
	#Throw object up when bottom object is scaling
	if bottom.is_colliding():
		var obj = bottom.get_collider()
		if obj is RigidBody3D and !obj.get_groups().find("resizable"):
			if obj.is_expanding:
				apply_central_impulse(Vector3(0,1,0) * 2.0)
	
	if (is_expanding and self.scale.y < max_size):
		#mesh.scale_object_local(Vector3(2,2,2))
		self.scale_object_local(Vector3(1.2,1.2,1.2))
	else:
		is_expanding = false
