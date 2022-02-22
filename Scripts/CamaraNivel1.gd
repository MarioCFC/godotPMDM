extends Camera2D

func _process(delta):
	self.position.x =  get_parent().get_node("Jugador").position.x
