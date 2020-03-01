extends RigidBody2D

onready var Game = get_node("/root/Game")
onready var Starting = get_node("/root/Game/Starting")
onready var TweenNode = get_node("Tween")
onready var timer = get_node("Timer")
onready var tiles = get_node("/root/Game/Tiles")
onready var paddle = get_node("/root/Game/Paddle")
onready var camera = get_node("/root/Game/Camera")
onready var colorRect = get_node("ColorRect")

func _ready():
	contact_monitor = true
	set_max_contacts_reported(4)
	colorRect.color = Color((randi()%3),(randi()%3),(randi()%3))

func _physics_process(delta):
	# Check for collisions
	var bodies = get_colliding_bodies()
	if bodies.size()>0:
		TweenNode.interpolate_property(self, "scale", self.get_scale(), 
		Vector2(2.0, 2.0), .15, Tween.TRANS_BACK, Tween.EASE_OUT)
		TweenNode.start()
		timer.start()
		var oldcolor = colorRect.color
		while(colorRect.color == oldcolor):
			colorRect.color = Color((randi()%3),(randi()%3),(randi()%3))
		paddle.changeColor()
		camera.shake()
	for body in bodies:
		
		if body.is_in_group("Tiles"):
			Game.change_score(body.points)
			body.queue_free()
	
	if position.y > get_viewport().size.y:
		Game.change_lives(-1)
		Starting.startCountdown(3)
		queue_free()

func _on_Timer_timeout():
		TweenNode.interpolate_property(self, "scale", self.get_scale(), 
		Vector2(1.0, 1.0), .25, Tween.TRANS_BACK, Tween.EASE_OUT)
		TweenNode.start()
