extends Area3D

@onready var test_vessel: Node3D = $".."

var occupants = []


func disconnect_signals():
	disconnect("body_entered", _on_body_entered)
	disconnect("body_exited", _on_body_exited)

	
func reconnect_signals():
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)
	

func _on_body_entered(body: Node3D) -> void:
	print('player entering area')
	if body not in occupants:
		disconnect_signals()
		body.reparent(test_vessel, true)
		occupants.append(body)
		reconnect_signals()
		print('player entered area')
		


func _on_body_exited(body: Node3D) -> 	void:
	print('player exiting area')
	if body in occupants:
		disconnect_signals()
		occupants.erase(body)
		body.reparent(get_tree().current_scene, true)
		reconnect_signals()
		print('player exited area')
