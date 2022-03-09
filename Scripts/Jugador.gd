extends BaseCharacter

var velocidad:float = 75
var potenciaSalto:float = -150
var gravedad:float = 5
var hasJumped:bool = false
var isAttacking : bool = false
var isBeingDamaged : bool = false
var isDead : bool = false
var damagedJump = false
var keyInputs = {"Up":false, "Down":false,"Left":false, "Right":false, "Attack":false}
signal hasDead

#LEER README ANTES DE JUGAR

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
	
	if direccionHorizontal != 0 and not isBeingDamaged: 
		flipX(direccionHorizontal < 0)
		
	if((isAttacking or isDead)and is_on_floor()):
		posicion.x = 0
	elif(isBeingDamaged):
		var direccionDesplazado:int
#		Apaño para saber en direccion está mirando ya que no puede aprovechar la variable scale de transform
# 		por lo mismo que no puedo usar flip.
#		Como el collisionShape del ataque siempre esta por delante del personaje lo uso para saber en 
# 		que direccion mira en el momento que es dañado
		direccionDesplazado = -1 if $AttackNodes/AttackArea/CollisionShape2D.global_position.x - self.global_position.x > 0 else 1
		posicion.x = direccionDesplazado * velocidad / 1.5
		
		if(damagedJump):
			posicion.y = potenciaSalto /2
			damagedJump = !damagedJump
	else:
		posicion.x = direccionHorizontal * velocidad
		if(keyInputs["Up"] and is_on_floor() ):
			posicion.y = potenciaSalto 
	posicion.y += gravedad

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
	elif(isBeingDamaged):
		stateMachine.travel("Damaged")
	elif(isDead):
		stateMachine.travel("Die")
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

func hasttacked():
	isAttacking = false

func _on_AttackArea_body_entered(body):
	if(body is BaseCharacter):
		body.getDamage()

#Muy casero lo del yield, hacer que sea coherente con el attack y el die
#Intentar que la muerte del jugador se encargue el nivel
func getDamage():
	isBeingDamaged = true
	damagedJump = true
	yield(get_tree().create_timer(0.3), "timeout")
	isBeingDamaged = false
	emit_signal("has_been_damaged")
	
	life -=1
	isDead = life == 0
	if isDead:
		set_collision_layer(0)
		yield(get_tree().create_timer(0.7), "timeout")
		hasDied()

func hasDied():
	emit_signal("hasDead")
	queue_free()

func flipX(valor:bool):
	$PlayerSprite.flip_h = valor
	$AttackNodes/AttackSprite.flip_h = valor
	
	var direccion = -1 if valor else 1
	$AttackNodes/AttackArea/CollisionShape2D.position.x = direccion * 13
	$AttackNodes/AttackSprite.position.x = direccion * 13
	
