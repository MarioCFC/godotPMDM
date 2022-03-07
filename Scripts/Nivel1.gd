extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Jugador.global_position = $PosicionSpawn.global_position
	$AnimationPlayer.play("Entrada")


#func _process(delta):
#	pass
