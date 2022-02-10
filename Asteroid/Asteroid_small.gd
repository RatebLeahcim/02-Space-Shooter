extends KinematicBody2D

var health = 1
var velocity = Vector2.ZERO
var smaller_speed = 10.0

onready var Asteroid_smaller = load("res://Asteroid/Asteroid_smaller.tscn")
var smaller_asteroids = [Vector2(0,-30),Vector2(30,30),Vector2(-30,30)]

var Effects
onready var Explosion = load("res://Effects/Explosion.tscn")


func _physics_process(_delta):
	position += velocity
	position.x = wrapf(position.x,0,Global.VP.x)
	position.y = wrapf(position.y,0,Global.VP.y)

func damage(d):
	health -= d
	if health <= 0:
		Global.update_score(100)
		collision_layer = 0
		var Asteroid_Container = get_node_or_null("/root/Game/Asteroid_Container")
		if Asteroid_Container != null:
			for s in smaller_asteroids:
				var asteroid_smaller = Asteroid_smaller.instance()
				var dir = randf()*2*PI
				var i = Vector2(0,randf()*smaller_speed).rotated(dir)
				Asteroid_Container.call_deferred("add_child", asteroid_smaller)
				asteroid_smaller.position = position + s.rotated(dir)
				asteroid_smaller.velocity = i
		queue_free()
