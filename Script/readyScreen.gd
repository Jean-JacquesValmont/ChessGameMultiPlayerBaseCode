extends Control

@onready var readyButton := $Panel/ReadyButton
@onready var quitButton := $Panel/QuitButton
@onready var matchIDContainer := $Panel/MatchIDContainer
@onready var matchIDLabel := $Panel/MatchIDContainer/MatchIDText

var oneShowScreenInit = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var infoPlayer : Dictionary = OnlineMatch.player_test.to_dict()
#	print("OnlineMatch.player_test.to_dict(): ", OnlineMatch.player_test.to_dict())
#	print("OnlineMatch.player_test[username]: ", OnlineMatch.player_test["username"])
#	print("OnlineMatch_match_id: " , OnlineMatch._match_id)
	if oneShowScreenInit == false:
		_show_screen({"players": infoPlayer, "match_id": OnlineMatch._match_id, "clear": true})
		oneShowScreenInit = true
	
func _show_screen(info: Dictionary = {}) -> void:
	print("Enter _show_screen")
	print("info:", info)
	var players: Dictionary = info.get("players", {})
	var match_id: String = info.get("match_id", '')
	var clear: bool = info.get("clear", false)
	
	print("players: ", players)
	print("match_id: ", match_id)
	print("clear: ", clear)
	
#	if players.size() > 0 or clear:
#		clear_players()

#	for peer_id in players:
#		add_player(peer_id, players[peer_id]['username'])

	if match_id:
		matchIDContainer.visible = true
		matchIDLabel.text = match_id
		quitButton.visible = true
	else:
		matchIDContainer.visible = false
		quitButton.visible = false

	readyButton.grab_focus()

func _on_quit_button_button_down():
	OnlineMatch.leave()
	print("Online._nakama_socket:", Online._nakama_socket)
	get_tree().change_scene_to_file("res://Scene/menu.tscn")
