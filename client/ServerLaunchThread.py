import threading
import os

class ServerLaunchThread (threading.Thread):
    def __init__(self, threadID, name, speed, port, maxDuration):
        threading.Thread.__init__(self)
        self.threadID = threadID
        self.name = name
        self.speed = speed
        self.port = port
        self.maxDuration = maxDuration

    def run(self):
        os.system("UDK.exe server DM-Deck.udk?game=ServerGame?listen=false?bIsLanMatch=true?numplay=2?ServerListenPort=" + str(self.port)
            + "?GameSpeed=" + str(self.speed) + "?MaxDuration=" + str(self.maxDuration))