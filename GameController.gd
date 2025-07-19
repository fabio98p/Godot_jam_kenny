extends Node

var totalDrop: int = 0
var collectedDrop: int = 0
var playerShipPosition: Vector2
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
