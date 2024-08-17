extends RigidBody3D
@export var is_resizable: bool;

# Called when the node enters the scene tree for the first time.
func _ready():
	is_resizable = true;
