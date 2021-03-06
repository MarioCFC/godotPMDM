extends Node2D

#LEER README ANTES DE JUGAR
func _ready():
	$Jugador.global_position = $PosicionSpawn.global_position
	$AnimationPlayer.play("Entrada")

func playerEnterDeathZone(body):
		body.hasDied()


func _on_Jugador_has_been_damaged():
	$CanvasLayer/HUD.loseHearth()

func _on_Jugador_hasDead():
	$CanvasLayer/HUD.visible = false
	$CanvasLayer/GameOverScreen/AnimationPlayer.play("Titulo")

#Ya que las dos ventanas se estan superponiendo muevo la de la capa superior, en caso de que sea necesaria
#la vuelvo a colocar en su sitio
func _on_Enemigo_hasDied():
	if($NPCs/Enemigos.get_child_count() == 1):
		$CanvasLayer/HUD.visible = false
		$CanvasLayer/WinScreen.rect_position = Vector2(0,0)
		$CanvasLayer/WinScreen/AnimationPlayer.play("Titulo")
