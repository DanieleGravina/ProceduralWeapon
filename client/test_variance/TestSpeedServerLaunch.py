import os

try:
    import _thread
except ImportError:
    import _dummy_thread as _thread

from Costants import PORT
from ServerLaunchThread import ServerLaunchThread

os.chdir('..')
os.chdir('..')
os.chdir('..')

print(os.getcwd())

os.chdir('Binaries')
os.chdir('Win32')

NUM_SERVER = 7

MAX_GAMESPEED = [1, 1, 1, 1, 1, 5, 5, 12]

threads = []

for i in range(NUM_SERVER):
    threads.append(ServerLaunchThread(i, "Thread-" + str(i), MAX_GAMESPEED[i], PORT[i], 1200))

for thread in threads:
    thread.start()