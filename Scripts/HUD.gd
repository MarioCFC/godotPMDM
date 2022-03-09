extends Control

var actualHeart : IndividualLifeHeart
onready var hearthLife = preload("res://Scenes/IndividualLifeHearth.tscn")
func _ready():
	activateNextheart()


func loseHearth():
	actualHeart.loseHeart()
	#Apaño rapido el yield deberia de hacerse de tal manera que espera a que el animation player de 
	#arriba ejecute la senal "animation_finished". Para evitarlo se crea un temporizado que dura lo mismo que la animacion
	yield(get_tree().create_timer(0.5), "timeout")
	activateNextheart()
	
func genearateLifeHearts():
	pass

func activateNextheart():
#	Tecnicamente es un for que recorre la lista desde el ultimo al primero
	for i in range(get_child_count()-1, -1, -1):
		var heart = get_child(i) as IndividualLifeHeart
		if(!heart.isLosedheart):
			actualHeart = heart
			actualHeart.activateHeart()
			break
