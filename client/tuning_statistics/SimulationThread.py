import threading
import time
from Costants import MAX_DURATION
from Costants import GOAL_SCORE

class SimulationThread(threading.Thread):
	"""#Simulation thread that communicate with the server UT3"""

	def __init__(self, pop_to_simulate, index_port, port, lock):
		super(SimulationThread, self).__init__()
		self.pop_to_simulate = pop_to_simulate
		self.index_port = index_port
		self.port = port
		self.my_port = None
		self.result = {}
		self.lock = lock
		
	def run(self):

		b_not_finished = True;

		while b_not_finished:

			self.lock.acquire()

			if self.my_port == None :
				self.my_port = self.port[index_port]

			if len(pop_to_simulate) != 0:
				individual_index = pop_to_simulate.keys()[0]
				individual = pop_to_simulate.get(individual_index)

				del pop_to_simulate[individual_index]

				self.lock.release()

				result = simulate(individual_index, individual)

				if result != None :
					self.result.update(result)
				else
					#server crashed
					b_not_finished = False

					self.lock.acquire()

					pop_to_simulate.update({individual_index : individual})
					del port[index_port]

					self.lock.release()					


			else :
				self.lock.release()
				b_not_finished = False;

	def simulate(ind_index, individual):
		print("Starting " + str(self.index_port))

		client = BalancedWeaponClient(my_port)
        client.SendInit()
        client.SendMaxDuration(MAX_DURATION)
        client.SendGoalScore(GOAL_SCORE)

        client.SendWeaponParams(ind_index, individual[0], individual[1], individual[2], individual[3], individual[4])

        client.SendProjectileParams(individual[5], individual[6], individual[7], individual[8], individual[9])

        client.SendWeaponParams(ind_index + 1, individual[10], individual[11], individual[12], individual[13], individual[14])

        client.SendProjectileParams(individual[15], individual[16], individual[17], individual[18], individual[19])

        client.SendStartMatch()

        client.WaitForBotStatics()

        print(str(self.index_port) + " " + str(time.clock() - t0))

        result = self.client.GetStatics()

        print(result)

        return result

	def join(self):
        threading.Thread.join(self)
        return self.result


