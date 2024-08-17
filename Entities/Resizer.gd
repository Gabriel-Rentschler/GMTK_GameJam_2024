extends MeshInstance3D

var obj
var obj_mesh
var obj_shape
var max_size = 2
@onready var raycast = %GunRay

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#raycast
	if Input.is_action_just_pressed("fire") and raycast.is_colliding():
		obj = raycast.get_collider()
		if (!get_tree().get_nodes_in_group("resizable").find(obj)):
			obj.is_expanding = true
			print(obj)
