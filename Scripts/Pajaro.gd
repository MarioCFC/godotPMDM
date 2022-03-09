extends Node2D
export var posicionSpawn :Vector2
func _ready():
	global_position  = posicionSpawn
	$Animaciones.play("Idle")


func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		$MovimientoFinal.play("PlayerNear")
