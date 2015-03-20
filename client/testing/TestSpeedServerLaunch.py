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

NUM_SERVER = 10

MAX_GAMESPEED = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

threads = []

for i in range(NUM_SERVER):
    threads.append(ServerLaunchThread(i, "Thread-" + str(i), MAX_GAMESPEED[i], PORT[i], 2400))

for thread in threads:
    thread.start()