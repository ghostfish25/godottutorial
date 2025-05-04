extends Area2D




func _on_body_entered(body):
	print("plus one coin!")
	queue_free()
