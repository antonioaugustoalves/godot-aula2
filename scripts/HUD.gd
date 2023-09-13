extends CanvasLayer

signal start_game

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()

func show_game_over():
	show_message('Fim de jogo!')
	yield($MessageTimer, "timeout")
	$ButtonStart.show()
	$MessageLabel.text = 'Dodge The Creepers'
	$MessageLabel.show()
	
func update_score(score):
	$ScoreLabel.text = str(score)

func _on_StartButton_pressed():
	$ButtonStart.hide()
	
	
