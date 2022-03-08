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


func playerEnterDeathZone(body):
	$Jugador.global_position = Vector2(98,36)
	body.getDamage()


func _on_Jugador_has_been_damaged():
	$CanvasLayer/HUD.loseHearth()


func _on_Enemigo_has_been_damaged():
	print("Aaa joder que daño")
