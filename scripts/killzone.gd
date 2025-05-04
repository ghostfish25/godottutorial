extends Area2D

@onready var timer = $Timer


func _on_body_entered(body: Node):
	if body is CharacterBody2D:
		print("You died!")
		print("Body is of type:", body.get_class())

		var shape = body.get_node_or_null("CollisionShape2D")
		if shape:
			shape.queue_free()
			print("CollisionShape2D queued for deletion")

			# Check next frame to confirm it's removed
			call_deferred("_check_collision_removed", body)

		Engine.time_scale = 0.01
		print("Time scale after:", Engine.time_scale)

		timer.start()

func _on_timer_timeout():
	Engine.time_scale = 1.0
	print("Time scale after timeout:", Engine.time_scale)
	get_tree().reload_current_scene()

func _check_collision_removed(body: Node) -> void:
	await get_tree().process_frame  # wait 1st frame
	await get_tree().process_frame  # wait 2nd frame

	var still_exists = body.get_node_or_null("CollisionShape2D") != null
	print("CollisionShape2D still exists after 2 frames:", still_exists)
