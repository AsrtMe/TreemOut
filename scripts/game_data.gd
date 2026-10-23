extends Node
const PIXELS_PER_METER: float = 20.0

var coins: int = 0
var time_limit: float = 5.0
var best_height: int = 0

func pixels_to_meters(pixels: float) -> float:
	return pixels / PIXELS_PER_METER
