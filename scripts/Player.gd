extends Area2D

signal hit

export (int) var SPEED # define a velocidade do player
var screen_size # define o tamanho da tela do jogo





func _ready():
	screen_size = get_viewport_rect().size



func _process(delta):
	#Criando os comandos de movimrntação do personagem
	var velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x +=1
	if Input.is_action_pressed("ui_left"):
		velocity.x -=1
	if Input.is_action_pressed("ui_down"):
		velocity.y +=1
	if Input.is_action_pressed("ui_up"):
		velocity.y -=1
	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED
		$Animation.play()
	else:
		$Animation.stop()
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	#Trocando as animaçoes de acordo com a ação do jogo
	if velocity.x != 0:
		$Animation.animation = "right"
		$Animation.flip_v = false
		$Animation.flip_h = velocity.x < 0
		
	if velocity.y != 0:
		$Animation.animation = "up"
		$Animation.flip_v = velocity.y > 0


func _on_Player_body_entered(body):
	hide()
	emit_signal("hit")
	$CollisionShape2D.disabled = true
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
