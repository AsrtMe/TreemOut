extends Node2D

@onready var coins_label: Label = $Hud/Coinslabel
@onready var time_limit_label: Label = $Hud/timelimitlabel
@onready var height_label: Label = $Hud/HeightrecordLabel


func _process(_delta: float) -> void:
	coins_label.text = "Монеты: %d" % GameData.coins
	time_limit_label.text = "Лимит времени: %.0f сек" % GameData.time_limit
	height_label.text = "Рекордная высота: %.1f м" % GameData.pixels_to_meters(GameData.best_height)
