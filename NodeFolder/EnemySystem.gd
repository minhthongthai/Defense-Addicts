extends PathFollow2D

@onready var nav : NavigationAgent2D = $Area2D/NavigationAgent2D
@onready var goal = %Goal
@onready var PathFollow = $"."

var speed = randi_range(100,150)
var Health = 50
func _ready():
	while true:
		await get_tree().create_timer(0.1).timeout
		nav.target_position = goal.global_position
		if Health <= 0:
			speed = 0
			await get_tree().create_timer(0.05).timeout
			queue_free()
func _physics_process(delta):
	PathFollow.progress += speed * delta
	


