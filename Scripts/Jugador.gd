extends KinematicBody2D

var posicion:Vector2 = Vector2()
var velocidad:float = 150
var potenciaSalto:float = -210
var gravedad:float = 10
var maquinaEstados
var haSaltado:bool
# Called when the node enters the scene tree for the first time.
func _ready():
	maquinaEstados = $AnimationTree.get("parameters/playback")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	input(delta)
	animacion()
	
	posicion.y += gravedad
	posicion = move_and_slide(posicion,Vector2.UP)
	
func input(delta):
	var  direccionHorizontal = (int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")))
	
	if(Input.is_action_just_pressed("ui_up") && is_on_floor()):
		posicion.y = potenciaSalto 
	
	posicion.x = direccionHorizontal * velocidad

func animacion():
	if(posicion.x != 0 && is_on_floor()):
		maquinaEstados.travel("Run")
	elif(is_on_floor()):
		maquinaEstados.travel("Idle")
	elif(is_on_floor() and haSaltado):
		maquinaEstados.travel("Landig")
		haSaltado = false
	elif(!is_on_floor() && posicion.y < 0):
		maquinaEstados.travel("Jump_up")
		haSaltado = true
	elif(!is_on_floor()):
		maquinaEstados.travel("Jump_down")
	if(posicion.x != 0):
		$PlayerSprite.flip_h = posicion.x < 0


#Tambien afecta a los TileMaps con collisionShape por lo que hay
#que cambiar las máscaras de colision
func _on_Area2D_body_entered(body):
	self.global_position = Vector2(98,36)
