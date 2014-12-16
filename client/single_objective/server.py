import os
import time

try:
    import _thread
except ImportError:
    import _dummy_thread as _thread

from Costants import PORT
from Costants import NUM_SERVER
from ServerLaunchThread import ServerLaunchThread

os.chdir('..')

# max GameSpeed UDK = 12
MAX_GAMESPEED = 12

NUM_SERVER = 10

threads = []

for i in range(NUM_SERVER):
	threads.append(ServerLaunchThread(i, "Thread-" + str(i), MAX_GAMESPEED, PORT[i], 600))

for thread in threads:
	thread.start()
	time.sleep(20)

