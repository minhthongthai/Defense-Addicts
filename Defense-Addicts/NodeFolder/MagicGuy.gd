extends Area2D

@onready var visual = $"../Visual"
@onready var muzzle_2d = $Muzzle2D
@onready var animation_magic = $AnimationMagic


const dot = preload("res://NodeFolder/dot.tscn")

var enemies = []
var Target = null
var target_found = false
var followingMouse = false

func _physics_process(delta):
	if followingMouse == true:
		global_position = get_global_mouse_position()
	for enemy in enemies:
		if enemy != null and Target != null:
			look_at(Target.global_position)

func _on_area_entered(area):
	if area.get_parent().name == "EnemyNode":
		var new_enemy = area
		enemies.append(new_enemy)
		StartAttacking()

func _on_area_exited(area):
	if area in enemies:
		enemies.erase(area)
		if area == Target:
			Target = null
			target_found = false
func StartAttacking():
	while true:
		for enemy in enemies:
			if enemy != null:
				if enemy.Health <= 0 :
					print("Dont change")
				else:
					target_found = true
					Target = enemy
					break
		if not target_found:
			animation_magic.play("RESET")
		

		await get_tree().create_timer(1).timeout

func _ready():
	while  true:
		if target_found == true:
			var newDot = dot.instantiate()
			visual.add_child(newDot)
			newDot.global_position = muzzle_2d.global_position
			newDot.Target = Target
			newDot.rotation = rotation
		await get_tree().create_timer(1).timeout


func following_mouse():
	followingMouse = true
