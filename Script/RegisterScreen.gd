extends Control

@onready var pathRegisterUsername = $Panel/UsernameText
@onready var pathRegisterEmail = $Panel/EmailText
@onready var pathRegisterPassword = $Panel/PasswordText
@onready var pathRegisterErrorText = $Panel/ErrorTextRegister

var email = ""
var password = ""
var username = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_register_button_button_down():
	username = pathRegisterUsername.text.strip_edges()
	email = pathRegisterEmail.text.strip_edges()
	password = pathRegisterPassword.text.strip_edges()
	
	var nakama_session = await Online.nakama_client.authenticate_email_async(email, password, username, true)
	
	if nakama_session.is_exception():
		
		var msg = nakama_session.get_exception().message
		pathRegisterErrorText.modulate = Color(1,0,0)
		print(msg)
		if msg == "Password must be at least 8 characters long.":
			pathRegisterErrorText.text = msg
		elif msg == "Username is required when email address is not supplied.":
			pathRegisterErrorText.text = msg
		elif msg == "User account not found.":
			pathRegisterErrorText.text = msg
		elif msg == "Invalid email address format.":
			pathRegisterErrorText.text = msg
		elif msg == "Invalid credentials.":
			pathRegisterErrorText.text = "The account already exists"
		
		Online.nakama_session = null
		
	else:
		Online.nakama_session = nakama_session
		pathRegisterUsername.text = ""
		pathRegisterEmail.text = ""
		pathRegisterPassword.text = ""
		pathRegisterErrorText.text = "Création du compte validé."
		pathRegisterErrorText.modulate = Color(0,1,0)


func _on_connection_screen_button_button_down():
	get_tree().change_scene_to_file("res://Scene/connectionScreen.tscn")
