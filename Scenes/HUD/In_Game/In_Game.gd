extends Control

var Score = 0
@export var Kill : int = 0

@onready var score_nb = $ScoreLabel/Score_nb
@onready var kill_nb = $KillLabel/Kill_nb


func _ready():
	score_nb.text = str(Score)
	Global.pauseable = true

func _physics_process(_delta):
	score_nb.text = str(Score)
	kill_nb.text = str(Global.Kill)

func _on_timer_timeout():
	Score += 1
	Global.score = Score

func stop_score_timer():
	$ScoreTimer.stop()
