extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_login_button_button_down():
	pass # Replace with function body.

func _on_register_screen_button_button_down():
	get_tree().change_scene_to_file("res://Scene/registerScreen.tscn")
