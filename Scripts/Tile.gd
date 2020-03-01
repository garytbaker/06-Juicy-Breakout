extends StaticBody2D

var points = 10
onready var colorRect = get_node("ColorRect")

func _ready():
	colorRect.color = Color((randi()%3),(randi()%3),(randi()%3))


