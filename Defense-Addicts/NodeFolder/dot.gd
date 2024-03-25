extends Area2D


var movementVector := Vector2(1,0)
var speed = 500

var Target = null

func _physics_process(delta):
	if Target != null:
		global_position = global_position.move_toward(Target.global_position, delta * speed)
	else:
		queue_free()


func _on_area_entered(area):
	if  area.get_parent().name == "EnemyNode":
		
		queue_free()
		area.Health -= 5
		area.get_node("AnimationEnemy").play("Damage")
		speed = 0 
		visible = false
		area.speed = 0
		
		
