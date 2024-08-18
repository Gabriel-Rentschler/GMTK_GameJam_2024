extends RayCast3D

var obj
var collider
var key = KEY_E
@onready var point = %"Hold"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_colliding():
		collider = get_collider()
		
	if Input.is_action_just_pressed("carry") && obj != null:
		var direction : Vector3 = obj.global_transform.origin.direction_to(point.global_transform.origin)
		obj.apply_central_impulse(-global_transform.basis.z * 60)
		obj = null
		collider = null
	elif obj == null && collider != null && (!collider.get_groups().find("grab") && collider.is_class("RigidBody3D")) && Input.is_action_just_pressed("carry"):
		obj = collider
		
	if obj:
		var direction : Vector3 = obj.global_transform.origin.direction_to(point.global_transform.origin)
		var force : float = obj.global_transform.origin.distance_to(point.global_transform.origin);
		if (force > 0.6):
			force = 0.6
		obj.linear_velocity = obj.linear_velocity * 0.95
		obj.apply_central_impulse(direction * force)
