extends Camera2D
var newPositionCamera = 115
func _process(delta):
	if get_parent().get_node_or_null("Jugador") != null:
		newPositionCamera =  get_parent().get_node("Jugador").position.x
	
	if(newPositionCamera <= 115):
		newPositionCamera = 115
	self.position.x = newPositionCamera
