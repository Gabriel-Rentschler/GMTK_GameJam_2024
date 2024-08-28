extends CollisionShape3D

func _on_body_entered(body: Node3D) -> void:
	if !body.get_groups().find("player"):
		get_tree().reload_current_scene();


func _on_hazard_zone_body_entered(body: Node3D) -> void:
	if !body.get_groups().find("player"):
		get_tree().reload_current_scene();
