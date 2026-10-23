extends Node2D

@onready var coins_label: Label = $Hud/Coinslabel
@onready var time_limit_label: Label = $Hud/timelimitlabel


func _process(_delta: float) -> void:
	coins_label.text = "Монеты: %d" % GameData.coins
	time_limit_label.text = "Лимит времени: %.0f сек" % GameData.time_limit
