extends Node

var totalDrop: float = 200
var collectedDrop: int = 0
var playerShipPosition: Vector2 = Vector2(0,0)
var currentShield: int

#upgrade 
var playerMaxShield: int = 9
var playerMaxVelocity: float = 500
var playerAccel: float = 1500
var bulletVelocity: int =  1
var bulletPerFire: int = 1
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
	if totalDrop > 19 && totalDrop <= 39:
		#stella media 
		return "res://Assets/kenney_particle-pack/PNG (Transparent)/light_03.png"
	if totalDrop > 39 && totalDrop <= 59:
		#stella grande 
		return "res://Assets/kenney_particle-pack/PNG (Transparent)/light_01.png"
	if totalDrop > 59:
		#stella completa
		return "res://Assets/kenney_particle-pack/PNG (Transparent)/star_09.png"
