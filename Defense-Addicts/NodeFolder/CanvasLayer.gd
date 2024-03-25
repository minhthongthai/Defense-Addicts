extends Node2D


@onready var tile_map = $NavigationRegion2D/TileMap


var Putting = false
var SelectGuy = null

const MAGIC_GUY = preload("res://NodeFolder/magic_guy.tscn")

func _on_get_magic_pressed():
	if Putting == false:
		Putting = true
		var ClonerMagic = MAGIC_GUY.instantiate()
		add_child(ClonerMagic)
		ClonerMagic.following_mouse()
		SelectGuy = ClonerMagic
		
func _input(event):
	if Input.is_action_just_pressed("Click") and Putting == true and SelectGuy != null:
		
		Putting = false
		SelectGuy.followingMouse = false
		
		var mouse_position = get_global_mouse_position()
		SelectGuy.global_position = mouse_position
		SelectGuy = null
