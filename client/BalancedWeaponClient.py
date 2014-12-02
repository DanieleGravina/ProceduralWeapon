import socket
import time

messageWeapon = ':WeaponPar:Rof:0.1:Spread:0.5:MaxAmmo:40:ShotCost:1:Range:10000'

messageProjectile = ':ProjectilePar:Speed:1000:Damage:1:DamageRadius:10:Gravity:1'

messageInit = ":Init"
messageStartMatch = ':StartMatch'
messageClose = ":Close"
messageReset = ':Reset'


class BalancedWeaponClient:
    def __init__(self, port): 
        self.buffer = ''
        self.statics = {}
        #create socket object
        self.s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.port = port
        self.host = 'localhost'

        # connection to hostname on the port.
        self.s.connect((self.host, self.port))  
        time.sleep(0.1) 

    def SendInit(self):
        #send to UDK server init message
        self.s.send(messageInit.encode())

    def SendStartMatch(self):
        self.s.send(messageStartMatch.encode())

    def SendWeaponParams(self, id, Rof, Spread, MaxAmmo, ShotCost, Range):
        messageWeapon = ':WeaponPar'
        messageWeapon += ':ID:' + str(id)
        messageWeapon += ':Rof:' + str(Rof/100)
        messageWeapon += ':Spread:' + str(Spread/10)
        messageWeapon += ':MaxAmmo:' + str(MaxAmmo)
        messageWeapon += ':ShotCost:' + str(ShotCost)
        messageWeapon += ':Range:' + str(Range)
        print('Send ' + messageWeapon)
        self.s.send(messageWeapon.encode())
        time.sleep(0.1)

    def SendProjectileParams(self, Speed, Damage, DamageRadius, Gravity):
        messageProjectile = ':ProjectilePar'
        messageProjectile += ':Speed:' + str(Speed)
        messageProjectile += ':Damage:' + str(Damage)
        messageProjectile += ':DamageRadius:' + str(DamageRadius)
        messageProjectile += ':Gravity:' + str(Gravity)
        print('Send ' + messageProjectile)
        self.s.send(messageProjectile.encode())
        time.sleep(0.1)

    def SendClose(self):
        self.s.send(messageClose.encode())

    def SendReset(self):
        self.s.send(messageReset.encode())

    def WaitForBotStatics(self):

        finish = True

        while finish:
            data = self.s.recv(255)
            data.decode()

            splitted = data.decode().split("%")

            for string in splitted:

                print("Received %s" % string)

                if  string == 'End' : 
                    finish = False
                else :
                    self.buffer += string

        self.SendClose()
        self.s.close()




    def GetStatics(self):

         strings = self.buffer.split(":")

         i = 0

         while(i < len(strings)) :
            if strings[i] == "ID":
                self.statics.update({ int(strings[i+1]) : (int(strings[i+3]), int(strings[i+5]) ) })
                i += 6
            else :
                i += 1

         print(self.statics)

         return self.statics       




                




