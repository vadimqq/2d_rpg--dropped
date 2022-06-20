extends KinematicBody2D

var Motion = Vector2()

func _MotionRight():
	Motion.x += 1

func _MotionLeft():
	Motion.x -= 1

func _MotionDown():
	Motion.y += 1

func _MotionUp():
	Motion.y -= 1
