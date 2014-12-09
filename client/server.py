import os

try:
    import _thread
except ImportError:
    import _dummy_thread as _thread

from Costants import PORT1, PORT2, PORT3, PORT4, PORT5
from ServerLaunchThread import ServerLaunchThread

os.chdir('..')
os.chdir('..')
os.chdir('..')

print(os.getcwd())

os.chdir('Binaries')
os.chdir('Win32')

# max GameSpeed UDK = 12

# create servers
thread1 = ServerLaunchThread(1, "Thread-1", 1, PORT1, 120)
thread2 = ServerLaunchThread(2, "Thread-2", 5, PORT2, 120)
thread3 = ServerLaunchThread(3, "Thread-3", 15, PORT3, 120)
thread4 = ServerLaunchThread(4, "Thread-4", 15, PORT4, 120)
thread5 = ServerLaunchThread(5, "Thread-5", 15, PORT5, 120)

thread1.start()
thread2.start()
thread3.start()
thread4.start()
thread5.start()


