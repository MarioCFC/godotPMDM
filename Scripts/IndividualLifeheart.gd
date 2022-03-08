extends Node2D

class_name IndividualLifeHeart

var isLosedheart = false


func recoverheart():
	isLosedheart = false

func loseHeart():
	$AnimationPlayer.play("HeartLose")
	isLosedheart = true

func activateHeart():
	$AnimationPlayer.play("Idle")
