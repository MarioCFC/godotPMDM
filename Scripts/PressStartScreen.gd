extends Control


func _input(event):
	if event is InputEventKey:
		get_tree().change_scene("res://Scenes/Nivel.tscn")
