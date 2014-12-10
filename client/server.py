import os

try:
    import _thread
except ImportError:
    import _dummy_thread as _thread

from Costants import PORT
from Costants import NUM_SERVER
from ServerLaunchThread import ServerLaunchThread

os.chdir('..')
os.chdir('..')
os.chdir('..')

print(os.getcwd())

os.chdir('Binaries')
os.chdir('Win32')

# max GameSpeed UDK = 12
MAX_GAMESPEED = 15

threads = []

for i in range(NUM_SERVER):
	threads.append(ServerLaunchThread(i, "Thread-" + str(i), MAX_GAMESPEED, PORT[i], 1200))

for thread in threads:
	thread.start()

