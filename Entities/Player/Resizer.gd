extends MeshInstance3D

var obj
var obj_mesh
var obj_shape
var max_size = 2
@onready var raycast = %GunRay

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#raycast
	if Input.is_action_just_pressed("left_mouse") && raycast.is_colliding():
		obj = raycast.get_collider()
		if (obj.get_groups().find("resizable") && obj.is_scaling == false):
			obj.is_scaling = true
			obj.grow_shrink = 0 #GROW
			
	elif Input.is_action_just_pressed("right_mouse") && raycast.is_colliding():
		obj = raycast.get_collider()
		if (obj.get_groups().find("resizable") && obj.is_scaling == false):
			obj.is_scaling = true
			obj.grow_shrink = 1 #SHRINK
