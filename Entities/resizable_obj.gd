extends RigidBody3D
@export var is_expanding: bool;
@onready var mesh = $Mesh
@onready var collision = $Collision
var max_size = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	is_expanding = false
	pass

func _physics_process(delta):
	
	if (is_expanding and self.scale.y < max_size):
		#mesh.scale_object_local(Vector3(2,2,2))
		self.scale_object_local(Vector3(1.5,1.5,1.5))
