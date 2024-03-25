extends Area2D

@onready var tilemap = $"../../TileMap"
@onready var goal = %Goal
var current_path: Array[Vector2i]

var orginalSpeed = randi_range(80,150)
var speed = orginalSpeed
var Health = 100



func _ready():
	#nav.target_position = goal.global_position
	while true:
		await get_tree().create_timer(0.1).timeout
		if Health <= 0:
			speed = 0
			await get_tree().create_timer(0.05).timeout
			queue_free()
		if speed == 0:
			await get_tree().create_timer(0.25).timeout
			speed = orginalSpeed


func _physics_process(delta):
	if current_path.is_empty():
		return
		
	var target_position = tilemap.map_to_local(current_path.front())
	global_position = global_position.move_toward(target_position, speed * delta)
	
	if global_position == target_position:
		current_path.pop_front()
		
func _unhandled_input(event):
	var click_position = goal.global_position
	if tilemap.is_point_walkable(click_position):
		if event.is_action_pressed("Click"):
			current_path = tilemap.astar.get_id_path(
				tilemap.local_to_map(global_position),
				tilemap.local_to_map(click_position)
			).slice(1)
	
