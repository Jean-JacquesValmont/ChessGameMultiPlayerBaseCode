extends Control

@onready var readyButton := $Panel/ReadyButton
@onready var quitButton := $Panel/QuitButton
@onready var matchIDContainer := $Panel/MatchIDContainer
@onready var matchIDLabel := $Panel/MatchIDContainer/MatchIDText
@onready var playerName1 := $Panel/PlayersName/Player1
@onready var playerName2 := $Panel/PlayersName/Player2
@onready var playerStatus1 := $Panel/PlayersStatus/Player1
@onready var playerStatus2 := $Panel/PlayersStatus/Player2

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
	
	if players.size() > 0 or clear:
		playerName1.text = ""
		playerName2.text = "En attente d'un deuxième joueur"
		
		playerStatus1.text = ""
		playerStatus2.text = "No Connected"
		
	for peer_id in players:
		playerName1.text = players['username']
		playerStatus1.text = "Connected"

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

#OnlineMatch CallBack

func _on_OnlineMatch_player_joined(player) -> void:
	playerName2.text = player.username
	playerStatus2.text = "Connected"
#	add_player(player.peer_id, player.username)
