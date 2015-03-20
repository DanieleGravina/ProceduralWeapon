class Simulation :
	def __init__(self, population, numServerCrashed, PORT, NUM_SERVER):
		self.population = list(population)
		self.numServerCrashed = numServerCrashed
		self.port = PORT
		self.statistics = {}
		self.num_server = NUM_SERVER

	def simulate(self):
		lock_pop = Lock()
		lock_stats = Lock()

		threads = []

		for i in range(self.num_server):
			threads.append( myThread(i, "Thread-" + str(i), self.population, self.PORT[i], lock_pop, self.statistics, lock_stats) )

		for t in threads:
	        t.join()

		return self.statistics








