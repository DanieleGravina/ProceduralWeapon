LOW = 0
MEDIUM = 1
HIGH = 2
VERY_HIGH = 3


#ROF/100

def RoF(label):
	if label == LOW :
		return 10, 100
	elif label == MEDIUM :
		return 100, 200
	elif label == HIGH:
		return 200, 400
	else:
		return 400, 1000

#SPREAD/100

def Spread( label):
	if label == LOW :
		return 0, 10
	elif label == MEDIUM :
		return 10, 50
	elif label == HIGH:
		return 50, 150
	else:
		return 150, 300

#AMMO

def Ammo( label):
	if label == LOW :
		return 0, 30
	elif label == MEDIUM :
		return 30, 100
	elif label == HIGH:
		return 100, 400
	else:
		return 400, 999

#SHOTCOST

def ShotCost( label):
	if label == LOW :
		return 1, 2
	elif label == MEDIUM :
		return 2, 4
	elif label == HIGH:
		return 4, 7
	else:
		return 7, 10

#RANGE/100

def Range( label):
	if label == LOW :
		return 10, 100
	elif label == MEDIUM :
		return 100, 500
	elif label == HIGH:
		return 500, 1000
	else:
		return 1000, 10000


#SPEED

def Speed( label):
	if label == LOW :
		return 1, 10
	elif label == MEDIUM :
		return 10, 100
	elif label == HIGH:
		return 100, 1000
	else:
		return 1000, 10000


#DAMAGE

def Damage( label):
	if label == LOW :
		return 1, 25
	elif label == MEDIUM :
		return 25, 50
	elif label == HIGH:
		return 50, 75
	else:
		return 75, 100

#DAMAGE RADIUS

def DamageRad( label):
	if label == LOW :
		return 0, 25
	elif label == MEDIUM :
		return 25, 50
	elif label == HIGH:
		return 50, 75
	else:
		return 75, 100

#GRAVITY of PROJECTILE (/100)

def Gravity( label):
	if label == LOW :
		return -10, 10
	elif label == MEDIUM :
		return -100, 100
	elif label == HIGH:
		return -500, 500
	else:
		return -2000, 2000

