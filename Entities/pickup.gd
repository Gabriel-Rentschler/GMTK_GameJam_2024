extends RayCast3D

var obj: RigidBody3D
var anim: AnimationPlayer
var collider: RigidBody3D
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
		anim = obj.get_node("AnimationPlayer")
		anim.pause()
		obj.apply_central_impulse(-global_transform.basis.z * 60)
		obj = null
		collider = null
	elif obj == null && collider != null && (!collider.get_groups().find("grab") && collider.is_class("RigidBody3D")) && Input.is_action_just_pressed("carry"):
		obj = collider
		anim = obj.get_node("AnimationPlayer")
		anim.play("floating")
	if obj:
		obj.position = point.global_position
		obj.linear_velocity = obj.linear_velocity * 0.8
