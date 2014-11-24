import socket
import time

messageWeapon = ':WeaponPar:Rof:0.1:Spread:0.5:MaxAmmo:40:ShotCost:1:Range:10000'

messageProjectile = ':ProjectilePar:Speed:1000:Damage:1:DamageRadius:10:Gravity:1'

messageInit = ":Init"
messageStartMatch = ':StartMatch'


class BalancedWeaponClient:
    def __init__(self): 
        #create socket object
        self.s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.port = 3742

        # connection to hostname on the port.
        self.s.connect((host, port))  

        #send to UDK server init message
        self.s.send(messageInit.encode()) 

    def SendStartMatch():
        self.s.send(messageStartMatch.encode())

    def SendWeaponParams(self, Rof, Spread, MaxAmmo, ShotCost, Range):
        messageWeapon = ':WeaponPar'
        messageWeapon += ':Rof:' + str(Rof)
        messageWeapon += ':Spread:' + str(Spread)
        messageWeapon += ':MaxAmmo:' + str(MaxAmmo)
        messageWeapon += ':ShotCost:' + str(ShotCost)
        messageWeapon += ':Range:' + str(Range)
        print('Send ' + messageWeapon)
        s.send(messageWeapon.encode())
        time.sleep(0.1)

    def SendProjectileParams(self, Speed, Damage, DamageRadius, Gravity):
        messageProjectile = ':ProjectilePar'
        messageProjectile += ':Speed:' + str(Speed)
        messageProjectile += ':Damage:' + str(Damage)
        messageProjectile += ':DamageRadius:' + str(DamageRadius)
        messageProjectile += ':Gravity:' + str(Gravity)
        print('Send ' + messageProjectile)
        s.send(messageProjectile.encode())
        time.sleep(0.1)

    def WaitForBotStatics(self):
        while True:
            data = s.recv(255)
            data.decode()

            splitted = data.split(":", string.count(data))

            for string in splitted:

                if  string == 'End' : 
                    return;
                else
                    self.buffer += string   
                    print ("Received %s" % string)


                




