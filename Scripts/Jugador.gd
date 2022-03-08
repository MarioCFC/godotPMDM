extends BaseCharacter

var velocidad:float = 100
var potenciaSalto:float = -150
var gravedad:float = 5
var hasJumped:bool = false
var isAttacking : bool = false
var keyInputs = {"Up":false, "Down":false,"Left":false, "Right":false, "Attack":false}

#Al saltar hacia la izquierda y atacar no se produce esta ultima accion pero si saltamos a la derecha
#si que sucede 
func _ready():
	life = 3
	stateMachine = $AnimationTree.get("parameters/playback")
	$AttackNodes/AttackArea.monitoring = false


func _physics_process(delta):
	inputs()
	#Llamada al metodo super
	._physics_process(delta)
	
func movement():
#	Movimiento horizontal
	var  direccionHorizontal = (int(keyInputs["Right"]) - int(keyInputs["Left"]))
	
	#Equivalente el flip ya que godot da problemas al hacerlo mediante la escala = -1 en los kinematic cambiando el scale en el transform, este es mediante matrices
	if direccionHorizontal != 0: 
		set_transform(Transform2D(Vector2(direccionHorizontal,0),Vector2(0,1),Vector2(position.x,position.y)))
	
	if(isAttacking and is_on_floor()):
		posicion.x = 0
	else:
		posicion.x = direccionHorizontal * velocidad
		
#	Movimiento vertical	
	posicion.y += gravedad
	
	if(keyInputs["Up"] and is_on_floor() ):
		posicion.y = potenciaSalto 

func inputs():
	keyInputs["Up"] = Input.is_action_just_pressed("ui_up")
	keyInputs["Down"] = Input.is_action_just_pressed("ui_down")
	keyInputs["Left"] = Input.is_action_pressed("ui_left")
	keyInputs["Right"] = Input.is_action_pressed("ui_right")
	keyInputs["Attack"] = Input.is_action_just_pressed("ui_attack")
	if(keyInputs["Attack"]):
		isAttacking = true
	
	
func animation():
	if(isAttacking and is_on_floor()):
		stateMachine.travel("GeneralAttack")
	elif(isAttacking):
		stateMachine.travel("AirAttack")
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


func _on_AttackArea_body_entered(body):
	if(body is BaseCharacter):
		body.getDamage()
