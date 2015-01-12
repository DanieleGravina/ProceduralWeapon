from sklearn.cluster import MeanShift, estimate_bandwidth
from sklearn.cluster import DBSCAN
from sklearn.manifold import MDS
from sklearn.preprocessing import StandardScaler
import numpy as np
from sklearn import metrics
import statistics

#default Rof = 100
ROF_MIN, ROF_MAX = 10, 1000
#default Spread = 0
SPREAD_MIN, SPREAD_MAX = 0, 300
#default MaxAmmo = 40
AMMO_MIN, AMMO_MAX = 1, 999
#deafult ShotCost = 1
SHOT_COST_MIN, SHOT_COST_MAX = 1, 999
#defualt Range 10000
RANGE_MIN, RANGE_MAX = 100, 10000

###################
# Projectile ######
###################

#default speed = 1000
SPEED_MIN, SPEED_MAX = 1, 10000
#default damage = 1
DMG_MIN, DMG_MAX = 1, 100
#default damgae radius = 10
DMG_RAD_MIN, DMG_RAD_MAX = 0, 100
#default gravity = 1
GRAVITY_MIN, GRAVITY_MAX = -2000, 2000

limits = [(ROF_MIN/100, ROF_MAX/100), (SPREAD_MIN/100, SPREAD_MAX/100), (AMMO_MIN, AMMO_MAX), (SHOT_COST_MIN, SHOT_COST_MAX), (RANGE_MIN/100, RANGE_MAX/100),
          (SPEED_MIN, SPEED_MAX), (DMG_MIN, DMG_MAX), (DMG_RAD_MIN, DMG_RAD_MAX), (GRAVITY_MIN/100, GRAVITY_MAX/100)]

label =["ROF", "SPREAD", "AMMO", "SHOT_COST", "RANGE", "SPEED", "DMG", "DMG_RAD", "GRAVITY"]

def normalize(data):
	for i in range(100):
		for j in range(9):
			data[i][j] = (data[i][j] - limits[j][0])/(limits[j][1] - limits[j][0])

	return data

class ClusterProceduralWeapon:
	def __init__(self, data = None, pure_data = None, num_weapon = 0, num_par = 0, num_clusters = 0, file = None):
		self.data = np.array(data, np.float32)
		self.pure_data = pure_data
		self.num_weapon = num_weapon
		self.num_par = num_par
		self.num_clusters = num_clusters
		self.file = file

	def cluster(self):

		cluster_file = open("cluster.txt", "w")

		print(self.data.shape)

		X = self.data

		#X = normalize(X)

		db = DBSCAN(eps=1000, min_samples=10).fit(X)
		labels = db.labels_

		print(labels)

		# Number of clusters in labels, ignoring noise if present.
		n_clusters_ = len(set(labels)) - (1 if -1 in labels else 0)


		index = []
		fitness = []
		mean = []

		print("number of estimated clusters : %d" % n_clusters_ )
		cluster_file.write("number of estimated clusters : %d" % n_clusters_ + "\n")

		for k in range(n_clusters_):
			my_members = (labels == k)

			for i in range(len(X)):
				if my_members[i]:
					index += [i]
					if self.pure_data != None:
						num = 0
						if i % 2 == 0:
							num = int(i/2)
							fitness += [self.pure_data[num].fitness.values] 
						else :
							num = int((i-1)/2)
							fitness += [self.pure_data[num].fitness.values]

			
			if fitness != []:
				for i in range(len(fitness[0])):
					mean += [statistics.mean([ind[i] for ind in fitness])]

			cluster_file.write("index:"+ "\n")
			cluster_file.write(str(index) + "\n")
			cluster_file.write("fitness:"+ "\n")
			cluster_file.write(str(fitness)+ "\n")
			cluster_file.write("mean fitness:"+ "\n")
			cluster_file.write(str(mean)+ "\n")
			cluster_file.write("members:"+ "\n")
			cluster_file.write(str(X[my_members])+ "\n")

			print(index)
			print("members:")
			print(X[my_members])
			print("fitness:"+ "\n")
			print(str(fitness)+ "\n")

			index = []
			fitness = []
			mean = []

		mds = MDS(n_components=2)

		pos = mds.fit_transform(X.astype(np.float64))

		import matplotlib.pyplot as plt

		colors = list('bgrcmykbgrcmykbgrcmykbgrcmyk')

		plt.figure(2)

		for i in range(len(pos[:,0])):

			plt.plot(pos[i, 0], pos[i, 1], 'o', markerfacecolor=colors[labels[i]], markeredgecolor='k')



		import matplotlib.pyplot as plt
		from itertools import cycle

		plt.figure(1)
		plt.title("number of estimated clusters : %d" % n_clusters_)
		colors = list('bgrcmykbgrcmykbgrcmykbgrcmyk')
		colors_cluster = [colors[labels[i]] for i in range(len(X))]
		k = [i for i in range(len(X))]
		for j in range(9):
			plt.subplot(330 + j)
			plt.ylabel(label[j])
			#plt.ylim(limits[j][0], limits[j][1])
			plt.bar(k, self.data[:,j], color=colors_cluster)
		plt.show()

	def write(self, file):
		file.write(str(AffinityPropagation().fit(self.data)))

def main():


	data = []

	pop_file = open("population_cluster.txt", "r")

	text = pop_file.read()

	splitted = text.split(" ")

	temp = []
	n = 0

	for string in splitted:
		split = string.split(":")

		for s in split:
			try:
				n = float(s)
				temp += [n]
				print(n)
				if (len(temp) == 9):
					data += [temp]
					temp = []

			except :
				pass

	print(data)


	c = ClusterProceduralWeapon(data, None, 4, 9, 3, None)

	c.cluster()

main()




