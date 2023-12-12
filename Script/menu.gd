extends Control

@onready var joinMatchID := $MultiPlayer/IDMatchText

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Online.nakama_session.username: ", Online.nakama_session.username)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#Fonction pour le mode local
func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scene/gameScreen.tscn")
	VariableGlobal.gameLaunch = true

func _on_editor_mod_pressed():
	get_tree().change_scene_to_file("res://Scene/editorMod.tscn")
	VariableGlobalOption.modeEditor = true

func _on_check_button_pressed():
	if get_node("Round").button_pressed ==  false:
		VariableGlobalOption.roundOfThree = false
	elif get_node("Round").button_pressed ==  true:
		VariableGlobalOption.roundOfThree = true

func _on_start_color_pressed():
	if get_node("StartColor").button_pressed == false:
		VariableGlobal.startWhite = true
	elif get_node("StartColor").button_pressed ==  true:
		VariableGlobal.startWhite = false

#Fonction pour le mode multijoueur

func _on_match_button_pressed(mode) -> void:
	# Connect socket to realtime Nakama API if not connected.
	if not Online.is_nakama_socket_connected():
		await Online.connect_nakama_socket()
		print("Online._nakama_socket:", Online._nakama_socket)

	# Call internal method to do actual work.
	match mode:
		OnlineMatch.MatchMode.CREATE:
			print("Create_matchmaking")
			_create_match()
		OnlineMatch.MatchMode.JOIN:
			print("Join_matchmaking")
			_join_match()

func _on_create_button_button_down():
	_on_match_button_pressed(OnlineMatch.MatchMode.CREATE)

func _on_join_button_button_down():
	_on_match_button_pressed(OnlineMatch.MatchMode.JOIN)

func _create_match() -> void:
	print("Enter in _create_match")
	OnlineMatch.create_match(Online.nakama_socket)
	get_tree().change_scene_to_file("res://Scene/readyScreen.tscn")

func _join_match() -> void:
	print("Enter in _join_match")
	var match_id = joinMatchID.text.strip_edges()
	if match_id == '':
		print("match id empty")
		return
	if not match_id.ends_with('.'):
		match_id += '.'

	OnlineMatch.join_match(Online.nakama_socket, match_id)
	get_tree().change_scene_to_file("res://Scene/readyScreen.tscn")

func _on_quit_button_down():
	Online.nakama_session = null
	print("Online.nakama_session: ", Online.nakama_session)
	get_tree().change_scene_to_file("res://Scene/connectionScreen.tscn")
