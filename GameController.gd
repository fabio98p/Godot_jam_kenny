extends Node

var totalDrop: float = 0
var starDrop: float = 0
var starAnimation: bool = false
var collectedDrop: int = 0
var playerShipPosition: Vector2 = Vector2(0,0)
var currentShield: int

#upgrade
var playerMaxShield: int = 1
var playerMaxVelocity: float = 200
var playerAccel: float = 400
var bulletVelocity: int =  300
var bulletPerFire: float = 0.6   #min 0.6 max 0.15
var autoFire: bool = false
var dropValue: int = 1
var dropVelocity: float = 0

var shildDrop: float = 0 #falla a percentuale, ovvero la percentuale che un nemico lasci una cura

#Upgrade value of setting
var settingPlayerMaxShield: int = 0
var settingPlayerMaxVelocity: int = 0
var settingPlayerAccel: int = 0
var settingBulletVelocity: int =  0
var settingBulletPerFire: int = 0
var SettingAutoFire: int = 0
var settingDropValue: int = 0
var settingDropVelocity: int = 0

var SettingShildDrop: float = 0

var stopGame: bool = false

func getPlayerPosition():
	return playerShipPosition
	
func setPlayerPosition(position):
	playerShipPosition = position

func setCollectDrop():
	collectedDrop += dropValue

func setTotalDrop():
	totalDrop += collectedDrop
	starDrop += collectedDrop
	collectedDrop = 0
	
func setDimensionAndSpriteStar():
		if  starDrop <= 15:
			return "res://Assets/kenney_particle-pack/PNG (Transparent)/circle_01.png"
		if starAnimation:
			if starDrop > 15  && starDrop <= 39:
				return "res://Assets/kenney_particle-pack/PNG (Transparent)/light_02.png"
			if starDrop > 39 && starDrop <= 59:
				#stella media 
				return "res://Assets/kenney_particle-pack/PNG (Transparent)/light_03.png"
			if starDrop > 59 && starDrop <= 89:
				#stella grande 
				return "res://Assets/kenney_particle-pack/PNG (Transparent)/light_01.png"
			if starDrop > 99:
				#stella completa
				return "res://Assets/kenney_particle-pack/PNG (Transparent)/star_09.png"
