extends Node

var totalDrop: float = 0
var collectedDrop: int = 0
var playerShipPosition: Vector2 = Vector2(0,0)
#upgrade 
var playerMaxShield: int = 3
var playerMaxVelocity: float = 500
var playerAccel: float = 1500
var playerBulletDmg: int = 1
var dropValue: int = 1
var playerdimension: int =  1
var bulletVelocity: int =  1

func getPlayerPosition():
	return playerShipPosition
	
func setPlayerPosition(position):
	playerShipPosition = position

func setCollectDrop():
	collectedDrop += 1

func setTotalDrop():
	totalDrop += collectedDrop
	collectedDrop = 0
	
func setDimensionAndSpriteStar():
	if  totalDrop <= 5:
		return "res://Assets/kenney_particle-pack/PNG (Transparent)/circle_01.png"
	if totalDrop > 5  && totalDrop <= 19:
		return "res://Assets/kenney_particle-pack/PNG (Transparent)/light_02.png"
	if totalDrop > 19 && totalDrop <= 29:
		#stella media 
		return "res://Assets/kenney_particle-pack/PNG (Transparent)/light_03.png"
	if totalDrop > 29 && totalDrop <= 39:
		#stella grande 
		return "res://Assets/kenney_particle-pack/PNG (Transparent)/light_01.png"
	if totalDrop > 59 && totalDrop <= 69:
		#stella completa
		return "res://Assets/kenney_particle-pack/PNG (Transparent)/star_09.png"
