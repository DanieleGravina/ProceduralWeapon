import os
import time

try:
    import _thread
except ImportError:
    import _dummy_thread as _thread

from Costants import PORT
from Costants import NUM_SERVER
from ServerLaunchThread import ServerLaunchThread

NUM_SERVER = 10

os.chdir('..')

# max GameSpeed UDK = 12
MAX_GAMESPEED = 12

threads = []

for i in range(NUM_SERVER):
	threads.append(ServerLaunchThread(i, "Thread-" + str(i), MAX_GAMESPEED, PORT[i], 120))

for thread in threads:
	thread.start()

