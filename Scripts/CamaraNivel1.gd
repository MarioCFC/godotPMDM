extends Camera2D
var inicialCameraHorizontalPosition

func _process(delta):
	var newPositionCamera = get_parent().get_node("Jugador").position.x
	if(newPositionCamera <= 115):
		newPositionCamera = 115
	self.position.x = newPositionCamera
