extends BaseCharacter

var isAttacking = false
var isDead = false
var velocidad:float = 30
var gravedad:float = 5
var playerIsInAtackRange = false
var direccionHorizontal = 1
var potenciaSalto:float = 75
var isBeingDamaged = false
var damagedJump = false

func _ready():
	life = 3
	loadAnimationStateMachine()
	$AttackNodes/AttackArea.monitoring = true
	
func _physics_process(delta):
	posicion.y += gravedad
	._physics_process(delta)

func movement():
	if isBeingDamaged:
		posicion.x = direccionHorizontal * -1 * velocidad
		
		if(damagedJump):
			posicion.y = potenciaSalto
			damagedJump = !damagedJump
	elif isAttacking or life == 0:
		posicion.x = 0
	else:
		turnRound()
		set_transform(Transform2D(Vector2(direccionHorizontal,0),Vector2(0,1),Vector2(position.x,position.y)))
		posicion.x = direccionHorizontal * velocidad
	posicion.y += gravedad
		
#Cuando va hacia a la izquierda no se porque detecta mal
func turnRound():
	if not $RayCast2D.is_colliding() and is_on_floor():
#		No entiendo el porque si hago direccionHorizonta *= -1 no se mantienen los cambios
		direccionHorizontal = -1 if direccionHorizontal == 1 else  -1

func animation():
	if isDead:
		stateMachine.travel("Die")
	elif isBeingDamaged:
		stateMachine.travel("Damaged")
	elif(isAttacking):
		stateMachine.travel("Attack")
	elif(posicion.x != 0 && is_on_floor()):
		stateMachine.travel("Run")
	elif(is_on_floor()):
		stateMachine.travel("Idle")

func attack():
	isAttacking = true

func hasAttacked():
	isAttacking = false

func _on_body_touch(body):
	if(body is BaseCharacter):
		body.getDamage()


func _on_AttackArea_body_entered(body):
	if(body.is_in_group("Player")):
		playerIsInAtackRange = true
		attack()
		yield(get_tree().create_timer(0.3), "timeout")
		if(playerIsInAtackRange):
			body.getDamage()
			
func _on_AttackArea_body_exited(body):
	if(body.is_in_group("Player")):
		playerIsInAtackRange = false

func getDamage():
	isBeingDamaged = true
	damagedJump = true
	yield(get_tree().create_timer(0.4), "timeout")
	isBeingDamaged = false
	life -=1
	isDead = life == 0
