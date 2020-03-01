extends KinematicBody2D
onready var colorRect = get_node("ColorRect")

func _ready():
	colorRect.color = Color((randi()%3),(randi()%3),(randi()%3))
	
func _physics_process(delta):
	var shape = $ColorRect.get_rect().size
	var view = get_viewport().get_visible_rect().size
	var target = get_viewport().get_mouse_position().x
	if target < shape.x / 2:
		target = shape.x / 2
	if target > view.x - shape.x / 2:
		target = view.x - shape.x / 2
	position = Vector2(target, position.y)

func changeColor():
	var oldcolor = colorRect.color
	while(colorRect.color == oldcolor):
		colorRect.color = Color((randi()%3),(randi()%3),(randi()%3))
