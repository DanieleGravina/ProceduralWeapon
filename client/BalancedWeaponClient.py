import socket
import time
import select

from Costants import TIMEOUT

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
        self.serverRunning = True

        # connection to hostname on the port.
        try:
            self.s.connect((self.host, self.port))
        except :
            self.serverRunning = False
            pass

        time.sleep(0.1) 

    def SendInit(self):
        #send to UT3 server init message
        time.sleep(0.1) 
        try:
            self.s.send(messageInit.encode(encoding='utf-8',errors='strict'))
        except :
            self.serverRunning = False
            pass

    def SendGameSpeed(self, gameSpeed):
        time.sleep(0.1)
        message = ":GameSpeed:" + str(gameSpeed)
        try:
            self.s.send(message.encode(encoding='utf-8',errors='strict'))
            print('Send ' + message)
        except :
            self.serverRunning = False
            pass

    def SendMaxDuration(self, maxDuration):
        time.sleep(0.1)
        message = ":MaxDuration:" + str(maxDuration)
        try:
            self.s.send(message.encode(encoding='utf-8',errors='strict'))
            print('Send ' + message)
        except :
            self.serverRunning = False
            pass

    def SendGoalScore(self, goalScore):
        time.sleep(0.1)
        message = ":GoalScore:" + str(goalScore)
        try:
            self.s.send(message.encode(encoding='utf-8',errors='strict'))
            print('Send ' + message)
        except :
            self.serverRunning = False
            pass

    def SendTestKillsVsTime(self):
        time.sleep(0.1)
        message = ":TestKillsVsTime:" 
        try:
            self.s.send(message.encode(encoding='utf-8',errors='strict'))
            print('Send ' + message)
        except :
            self.serverRunning = False
            pass

    def SendStartMatch(self):
        time.sleep(0.1)

        try:
            self.s.send(messageStartMatch.encode(encoding='utf-8',errors='strict'))
        except :
            self.serverRunning = False
            pass

    def SendWeaponParams(self, id, Rof, Spread, MaxAmmo, ShotCost, Range):
        time.sleep(0.1) 
        messageWeapon = ':WeaponPar'
        messageWeapon += ':ID:' + str(id)
        messageWeapon += ':Rof:' + str(Rof)
        messageWeapon += ':Spread:' + str(Spread)
        messageWeapon += ':MaxAmmo:' + str(MaxAmmo)
        messageWeapon += ':ShotCost:' + str(ShotCost)
        messageWeapon += ':Range:' + str(Range)
        print('Send ' + messageWeapon)

        try:
            self.s.send(messageWeapon.encode(encoding='utf-8',errors='strict'))
        except :
            self.serverRunning = False
            pass

        time.sleep(0.1)

    def SendProjectileParams(self, Speed, Damage, DamageRadius, Gravity, Explosive, Bounce = 0):
        time.sleep(0.1) 
        messageProjectile = ':ProjectilePar'
        messageProjectile += ':Speed:' + str(Speed)
        messageProjectile += ':Damage:' + str(Damage)
        messageProjectile += ':DamageRadius:' + str(DamageRadius)
        messageProjectile += ':Gravity:' + str(Gravity)
        messageProjectile += ':Explosive:' + str(Explosive)
        messageProjectile += ':Bounce:' + str(Bounce)
        print('Send ' + messageProjectile)

        try:
            self.s.send(messageProjectile.encode(encoding='utf-8',errors='strict'))
        except :
            self.serverRunning = False
            pass

        time.sleep(0.1)

    def SendClose(self):
        time.sleep(0.1) 

        try:
            self.s.send(messageClose.encode(encoding='utf-8',errors='strict'))
        except :
            self.serverRunning = False
            pass

    def SendReset(self):
        time.sleep(0.1) 

        try:
            self.s.send(messageReset.encode(encoding='utf-8',errors='strict'))
        except :
            self.serverRunning = False
            pass

    def WaitForBotStatics(self):

        self.s.setblocking(0)

        finish = True

        while finish and self.serverRunning:

            #if server crashes, it can continue after timeout
            ready = select.select([self.s], [], [], TIMEOUT)

            if ready[0]:
                data = self.s.recv(255)
            else :
                self.serverRunning = False
                message = ""
                data = message.encode()

            splitted = data.decode().split("%")

            for string in splitted:

                #print("Received %s" % string)

                if  string == 'End' : 
                    finish = False
                else :
                    self.buffer += string

        self.SendClose()

        try:
            self.s.close()
        except :
            self.serverRunning = False
            pass




    def GetStatics(self):

         if not self.serverRunning:
            return None

         strings = self.buffer.split(":")

         i = 0

         while(i < len(strings)) :
            if strings[i] == "ID":
                self.statics.update({ int(strings[i+1]) : (int(strings[i+3]), int(strings[i+5]), 
                                      float(strings[i+7]), float(strings[i+9]) , float(strings[i + 11]), 
                                      float(strings[i + 13])) })
                i += 14
            else :
                i += 1

         return self.statics       




                




