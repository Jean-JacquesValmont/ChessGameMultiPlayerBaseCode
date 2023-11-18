extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if VariableGlobal.checkWhite == true:
		get_node("TextCheckmateWhite").set_text("Echec")
	elif VariableGlobal.checkWhite == false:
		get_node("TextCheckmateWhite").set_text("")
		
	if VariableGlobal.checkBlack == true:
		get_node("TextCheckmateBlack").set_text("Echec")
	elif VariableGlobal.checkBlack == false:
		get_node("TextCheckmateBlack").set_text("")
	
	if VariableGlobal.stalemate == true:
		get_node("TextCheckmateWhite").set_text("Pat")
		get_node("TextCheckmateBlack").set_text("Pat")
	
	if VariableGlobal.checkmateWhite == true and VariableGlobal.checkmate == true:
		get_node("TextCheckmateWhite").set_text("Echec et Mat")
	elif VariableGlobal.checkmateBlack == true and VariableGlobal.checkmate == true:
		get_node("TextCheckmateBlack").set_text("Echec et Mat")
