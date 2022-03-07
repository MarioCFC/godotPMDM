extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var actualHearth = self.get_children()[get_child_count() - 1] as IndividualLifeHearth
	actualHearth.get_node("AnimationPlayer").play("Idle")
