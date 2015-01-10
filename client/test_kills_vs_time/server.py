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
MAX_GAMESPEED = [1, 1, 1, 1, 12, 12, 12, 12]

NUM_SERVER = 8

threads = []

for i in range(NUM_SERVER):
	threads.append(ServerLaunchThread(i, "Thread-" + str(i), MAX_GAMESPEED[i], PORT[i], 7200))

for thread in threads:
	thread.start()
	time.sleep(21)

