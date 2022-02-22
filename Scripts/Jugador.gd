extends KinematicBody2D

var posicion = Vector2()
var velocidad = 150
var potenciaSalto = -210
var gravedad = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


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
		$AnimatedSprite.play("Run")
	elif(is_on_floor()):
		$AnimatedSprite.play("Idle")
	elif(!is_on_floor() && posicion.y < 0):
		$AnimatedSprite.play("Jump_Up")
	elif(!is_on_floor()):
		$AnimatedSprite.play("Jump_Down")
	if(posicion.x != 0):
		$AnimatedSprite.flip_h = posicion.x < 0


#Tambien afecta a los TileMaps con collisionShape por lo que hay
#que cambiar las máscaras de colision
func _on_Area2D_body_entered(body):
	self.global_position = Vector2(98,36)
