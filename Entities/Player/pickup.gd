extends RayCast3D

var obj: RigidBody3D
var anim: AnimationPlayer
var collider: RigidBody3D
@onready var point = %"Hold"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("carry") && obj != null:
		_drop_object()
	elif obj == null && Input.is_action_just_pressed("carry"):
		if is_colliding():
			collider = get_collider()
			if collider.mass < 5 && (!collider.get_groups().find("grab") && collider.is_class("RigidBody3D")):
				obj = collider
				anim = obj.get_node("AnimationPlayer")
				#anim.play("floating")
	if obj:

		#obj.global_position = point.global_position
		#obj.linear_velocity = obj.linear_velocity * 0.8
		
		var direction : Vector3 = obj.global_transform.origin.direction_to(point.global_transform.origin)
		var force : float = obj.global_transform.origin.distance_to(point.global_transform.origin);
		if (force > 0.6):
			force = 0.6
		obj.linear_velocity = obj.linear_velocity * 0.95
		obj.apply_central_impulse(direction * force)
		#obj.rotation -= obj.rotation
		#obj.lock_rotation = true
		obj.set_collision_layer_value(1, false)
		
		#Fix for being able to expand object while player holds it
		if obj.mass > 5:
			_drop_object()

		
		
func _drop_object():
	var direction : Vector3 = obj.global_transform.origin.direction_to(point.global_transform.origin)
	anim = obj.get_node("AnimationPlayer")
	anim.pause()
	#obj.lock_rotation = false
	obj.set_collision_layer_value(1, true)
	obj.apply_central_impulse(-global_transform.basis.z * 60)
	obj = null
	collider = null
