extends Camera2D

var mouse_starting_position
var starting_position
var is_dragging = false

# Define the limits
var min_limit = Vector2(0, 0)  # Minimum limit
var max_limit = Vector2(600, 500)  # Maximum limit

func _ready():
	pass

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			starting_position = position
			mouse_starting_position = event.position
			is_dragging = true
		else: 
			is_dragging = false
	if event is InputEventMouseMotion and is_dragging:
		var new_position = starting_position - zoom * (event.position - mouse_starting_position)
		# Clamp the new position within the limits
		position.x = clamp(new_position.x, min_limit.x, max_limit.x)
		position.y = clamp(new_position.y, min_limit.y, max_limit.y)
