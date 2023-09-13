extends Node

export (PackedScene) var Mob
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Let's Go")
	$Music.play()
	$Death.stop();
	
func game_over():
	score = 0 # Reinicia a contagem de pontos
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.update_score(score)
	$HUD.show_game_over()
	$HUD.show_message("You Died!")
	$Music.stop()	
	$Death.play()
	
	
		

func _on_Player_hit():
	pass # Replace with function body.

func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()


func _on_ScoreTimer_timeout():
	score +=1
	$HUD.update_score(score)


func _on_MobTimer_timeout():
	$MobPath/Spawn.set_offset(randi())
	var mob = Mob.instance()
	add_child(mob)
	var direction = $MobPath/Spawn.rotation + PI/2
	mob.position = $MobPath/Spawn.position
	direction  += rand_range(-PI/4, PI/4)
	mob.rotation = direction
	var rand_x = rand_range(mob.MIN_SPEED, mob.MAX_SPEED)
	mob.set_linear_velocity(Vector2(rand_x, 0).rotated(direction))
	
