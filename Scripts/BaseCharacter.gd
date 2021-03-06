extends KinematicBody2D
class_name BaseCharacter

signal has_been_damaged
var posicion:Vector2 = Vector2()
var stateMachine : AnimationNodeStateMachinePlayback
var life : int = 0

func _physics_process(delta):
	movement()
	animation()
	posicion = move_and_slide(posicion,Vector2.UP)
	
func loadAnimationStateMachine():
	stateMachine = $AnimationTree.get("parameters/playback")

func movement():
	push_error("Desarrolla el motodo 'movement'")
	assert(false)

func animation():
	push_error("Desarrolla el motodo 'animation'")
	assert(false)
	

func getDamage():
	push_error("Desarrolla el motodo 'animation'")
	assert(false)
