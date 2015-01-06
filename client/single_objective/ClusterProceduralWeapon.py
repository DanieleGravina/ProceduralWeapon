from sklearn.cluster import k_means
from sklearn.cluster import MeanShift, estimate_bandwidth
from sklearn.cluster import AffinityPropagation
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

		bandwidth = estimate_bandwidth(X, quantile=0.2, n_samples=100)

		ms = MeanShift(bandwidth=bandwidth, bin_seeding=True)
		ms.fit(X)
		labels = ms.labels_
		cluster_centers = ms.cluster_centers_

		print(cluster_centers)
		print(labels)

		labels_unique = np.unique(labels)
		n_clusters_ = len(labels_unique)

		index = []
		fitness = []
		mean = []

		print("number of estimated clusters : %d" % n_clusters_ )
		cluster_file.write("number of estimated clusters : %d" % n_clusters_ + "\n")

		for k in range(n_clusters_):
			my_members = labels == k
			cluster_center = cluster_centers[k]
			for i in range(100):
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
			cluster_file.write("center: \n")
			cluster_file.write(str(cluster_center)+ "\n")
			cluster_file.write("members:"+ "\n")
			cluster_file.write(str(X[my_members])+ "\n")

			print(index)
			print("center:")
			print(cluster_center)
			print("members:")
			print(X[my_members])
			print("fitness:"+ "\n")
			print(str(fitness)+ "\n")

			index = []
			fitness = []
			mean = []



		import matplotlib.pyplot as plt
		from itertools import cycle

		plt.figure(1)
		plt.title("number of estimated clusters : %d" % n_clusters_)
		colors = list('bgrcmykbgrcmykbgrcmykbgrcmyk')
		k = [i for i in range(n_clusters_)]
		for j in range(9):
			plt.subplot(330 + j)
			plt.ylabel(label[j])
			cluster_center = [cluster_centers[i, j] for i in range(n_clusters_)]
			plt.ylim(limits[j][0], limits[j][1])
			plt.plot(k, cluster_center, 'o', markerfacecolor=colors[j],
			             markeredgecolor='k', markersize=14)
		plt.show()

	def write(self, file):
		file.write(str(AffinityPropagation().fit(self.data)))

def main():


	data = []

	pop_file = open("population.txt", "r")

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


	c = ClusterProceduralWeapon(data, 4, 9, 3, None)

	c.cluster()




