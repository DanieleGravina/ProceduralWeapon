import socket
import time

messageWeapon = ':WeaponPar:Rof:0.1:Spread:0.5:MaxAmmo:40:ShotCost:1:Range:10000'

messageProjectile = ':ProjectilePar:Speed:1000:Damage:1:DamageRadius:10:Gravity:1'

messageInit = ':Init'
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
        time.sleep(0.1) 
        self.s.send(messageInit.encode(encoding='utf-8',errors='strict'))

    def SendStartMatch(self):
        time.sleep(0.1)
        self.s.send(messageStartMatch.encode(encoding='utf-8',errors='strict'))

    def SendWeaponParams(self, id, Rof, Spread, MaxAmmo, ShotCost, Range):
        time.sleep(0.1) 
        messageWeapon = ':WeaponPar'
        messageWeapon += ':ID:' + str(id)
        messageWeapon += ':Rof:' + str(Rof)
        messageWeapon += ':Spread:' + str(Spread)
        messageWeapon += ':MaxAmmo:' + str(MaxAmmo)
        messageWeapon += ':ShotCost:' + str(ShotCost)
        messageWeapon += ':Range:' + str(Range)
        print('Send ' + str(id))
        self.s.send(messageWeapon.encode(encoding='utf-8',errors='strict'))
        time.sleep(0.1)

    def SendProjectileParams(self, Speed, Damage, DamageRadius, Gravity):
        time.sleep(0.1) 
        messageProjectile = ':ProjectilePar'
        messageProjectile += ':Speed:' + str(Speed)
        messageProjectile += ':Damage:' + str(Damage)
        messageProjectile += ':DamageRadius:' + str(DamageRadius)
        messageProjectile += ':Gravity:' + str(Gravity)
        #print('Send ' + messageProjectile)
        self.s.send(messageProjectile.encode(encoding='utf-8',errors='strict'))
        time.sleep(0.1)

    def SendClose(self):
        time.sleep(0.1) 
        self.s.send(messageClose.encode(encoding='utf-8',errors='strict'))

    def SendReset(self):
        time.sleep(0.1) 
        self.s.send(messageReset.encode(encoding='utf-8',errors='strict'))

    def WaitForBotStatics(self):

        finish = True

        while finish:
            data = self.s.recv(255)
            data.decode()

            splitted = data.decode().split("%")

            for string in splitted:

                #print("Received %s" % string)

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

         #print(self.statics)

         return self.statics       




                




