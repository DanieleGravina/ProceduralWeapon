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
        print(self.threadID)
        os.system("UT3.exe server DM-Biohazard.ut3?game=Tutorial.ServerGame?numplay=4??botskill=7?TestGame=true?ServerListenPort=" + str(self.port)
            + "?GameSpeed=" + str(self.speed) + "?MaxDuration=" + str(self.maxDuration) + " -useunpublished")

         