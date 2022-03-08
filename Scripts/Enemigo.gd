extends BaseCharacter

var isAttacking = false
var gravedad:float = 10

func _ready():
	life = 3
	loadAnimationStateMachine()
	
func _physics_process(delta):
	posicion.y += gravedad
	._physics_process(delta)

func movement():
	pass

func animation():
	if(isAttacking):
		stateMachine.travel("Attack")
	elif(posicion.x != 0 && is_on_floor()):
		stateMachine.travel("Run")
	elif(is_on_floor()):
		stateMachine.travel("Idle")

func attack():
	isAttacking = true

func hasattacked():
	isAttacking = false	
	

