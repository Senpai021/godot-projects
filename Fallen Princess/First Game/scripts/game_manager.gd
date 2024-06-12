extends Node

var score = 0
@onready var score_label = $ScoreLabel
@onready var coins = %Coins
@onready var player = $"../Entities/Player"
var total_coins 

const GAME_VERSION = "0.1"


func _input(event):
	if event.is_action_pressed("enter") and score == total_coins:
		get_tree().paused = false
		get_tree().reload_current_scene()
	

func add_point():
	if score == 0:
		total_coins = coins.get_child_count(false)
	score += 1
	score_label.text = "You collected " + str(score) + " / " + str(total_coins) +  " coins."
	if score == total_coins:
		await get_tree().create_timer(1).timeout
		get_tree().paused = true
		print("paused")
		
