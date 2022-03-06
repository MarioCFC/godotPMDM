extends KinematicBody2D

var posicion:Vector2 = Vector2()
var velocidad:float = 150
var potenciaSalto:float = -210
var gravedad:float = 10
var stateMachine : AnimationNodeStateMachinePlayback
var hasJumped:bool = false
var isAttacking : bool = false

func _ready():
	stateMachine = $AnimationTree.get("parameters/playback")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	input()
	animacion()
	posicion.y += gravedad
	
	posicion = move_and_slide(posicion,Vector2.UP)
	
func input():
	var  direccionHorizontal = (int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")))

	#Equivalente el flip ya que godot da problemas al hacerlo mediante la escala = -1 en los kinematic cambiando el scale en el transform, este es mediante matrices
	if direccionHorizontal != 0: 
		set_transform(Transform2D(Vector2(direccionHorizontal,0),Vector2(0,1),Vector2(position.x,position.y)))
#
	if(Input.is_action_just_pressed("ui_up") and is_on_floor() ):
		posicion.y = potenciaSalto 
	
	if(Input.is_action_just_pressed("ui_attack")):
		isAttacking = true
	if(isAttacking):
		posicion.x = direccionHorizontal * 50
	else:
		posicion.x = direccionHorizontal * velocidad

func animacion():
	if(isAttacking):
		stateMachine.travel("Attack")
	elif(posicion.x != 0 && is_on_floor()):
		stateMachine.travel("Run")
	elif(is_on_floor()):
		stateMachine.travel("Idle")
	elif(is_on_floor() and hasJumped):
		stateMachine.travel("Landig")
		hasJumped = false
	elif(!is_on_floor() && posicion.y < 0):
		stateMachine.travel("Jump_up")
		hasJumped = true
	elif(!is_on_floor()):
		stateMachine.travel("Jump_down")

func hasattacked():
	isAttacking = false

func playerEnterDeathZone(body):
	print("entro")
	self.position = Vector2(98,36)
