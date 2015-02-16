import os,sys,inspect
currentdir = os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe())))
parentdir = os.path.dirname(currentdir)
sys.path.insert(0,parentdir) 

from sklearn.manifold import MDS
from sklearn.cluster import DBSCAN
import numpy as np
from sklearn import metrics
import statistics
import matplotlib.pyplot as plt
from radar_chart_single import draw_radar
from math import *

from Costants import *

limits = [(0, log(1/(ROF_MIN/100))*2), (SPREAD_MIN/100, SPREAD_MAX/100), (AMMO_MIN, AMMO_MAX), (SHOT_COST_MIN, SHOT_COST_MAX), (RANGE_MIN/100, RANGE_MAX/100),
          (SPEED_MIN, SPEED_MAX), (DMG_MIN, DMG_MAX), (DMG_RAD_MIN, DMG_RAD_MAX), (-GRAVITY_MIN, -GRAVITY_MAX), 
          (EXPLOSIVE_MIN, EXPLOSIVE_MAX)]

label =["ROF", "SPREAD", "AMMO", "SHOT_COST", "RANGE", "SPEED", "DMG", "DMG_RAD", "GRAVITY", "EXPLOSIVE"]

def printWeapon(pop):

    for ind in pop :

        print("Weapon "+ " Rof:" + str(ind[0]) + " Spread:" + str(ind[1]) + " MaxAmmo:" + str(ind[2]) 
            + " ShotCost:" + str(ind[3]) + " Range:" + str(ind[4]) )
        print("Projectile "+ " Speed:" + str(ind[5]) + " Damage:" + str(ind[6]) + " DamageRadius:" + str(ind[7])
            + " Gravity:" + str(ind[8]) + " Explosive:" + str(ind[9]))
        print("*********************************************************" + "\n")


def writeWeapon(pop, pop_file):
    for ind in pop :
        pop_file.write("Weapon "+ " Rof:" + str(ind[0]) + " Spread:" + str(ind[1]) + " MaxAmmo:" + str(ind[2]) 
            + " ShotCost:" + str(ind[3]) + " Range:" + str(ind[4]) + "\n")
        pop_file.write("Projectile "+ " Speed:" + str(ind[5]) + " Damage:" + str(ind[6]) + " DamageRadius:" + str(ind[7])
            + " Gravity:" + str(ind[8]) + " Explosive:" + str(ind[9]) +"\n")

def normalize(data):
	for i in range(data.shape[0]):
		for j in range(data.shape[1]):
			data[i][j] = (data[i][j] - limits[j][0])/(limits[j][1] - limits[j][0])

	return data

def postProcess(data):

	#fireinterval become rate of fire -> (1/fireinterval)
	data[0] = log(1/(ROF_MIN/100)) + log(1/data[0])

	#gravity is inverted
	data[8] = - data[8]

	return data

class ClusterProceduralWeapon:
	def __init__(self, data = None, pure_data = None, file = open("cluster.txt", "w")):
		self.data = data
		self.pure_data = pure_data
		self.file = file

	def cluster(self):

		cluster_file = self.file

		if self.pure_data == None:
			for ind in pop:
				temp1 = ind[:10]
				temp2 = ind[10:]
				self.pure_data += [temp1]
				self.pure_data += [temp2]

		for i in range(len(self.pure_data)):
			self.pure_data[i] = postProcess(self.pure_data[i])

		X = np.array(self.pure_data, np.float32)

		print(X.shape)

		X = normalize(X)

		db = DBSCAN(eps=0.3, min_samples=2).fit(X)
		labels = db.labels_

		labels_unique = np.unique(labels)
		n_clusters_ = len(labels_unique)

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
			for i in range(len(labels)):
				if my_members[i]:
					index += [i]
					if False:
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
			writeWeapon([self.pure_data[i] for i in range(len(labels)) if my_members[i]], cluster_file)

			print(index)
			print("members:")
			printWeapon([self.pure_data[i] for i in range(len(labels)) if my_members[i]])
			print("fitness:"+ "\n")
			print(str(fitness)+ "\n")

			index = []
			fitness = []
			mean = []


		mds = MDS(n_components=2)

		pos = mds.fit_transform(X.astype(np.float64))

		colors = list('bgrcmykbgrcmykbgrcmykbgrcmyk')

		plt.figure(7)

		for i in range(len(pos[:,0])):

			plt.plot(pos[i, 0], pos[i, 1], 'o', markerfacecolor=colors[labels[i]], markeredgecolor='k')

		X_ordered = []
		X = np.array(self.pure_data);
		colors_ordered = []

		for i in range(n_clusters_):
			for j in range(len(labels)):
				if labels[j] == i and labels[j] != -1:
					X_ordered.append(X[j][:])
					colors_ordered += [colors[labels[j]]]

		labels_ = [labels[i] for i in range(len(labels)) if labels[i] != -1]

		width = 0.8
		ind = np.arange(len(labels_))

		fig = plt.figure(figsize=(9, 9))
		fig.subplots_adjust(wspace=0.50, hspace=0.25)

		k = [i for i in range(len(labels_))]
		for j in range(10):
			ax = fig.add_subplot(4, 3, j+1)
			plt.ylabel(label[j])
			plt.ylim(limits[j][0], limits[j][1])
			ax.bar(k, [X_ordered[ind][j] for ind in range(len(labels_))], color=colors_ordered)

		#plt.show()

		'''
		plt.figure(9)
		colors_cluster = [colors[labels[i]] for i in range(len(labels))]

		width = 0.8
		ind = np.arange(len(labels))

		k = [i for i in range(len(labels))]
		for j in range(9):
			plt.subplot(330 + j)
			plt.ylabel(label[j])
			plt.ylim(limits[j][0], limits[j][1])
			plt.bar(k, [X[i][j] for i in range(len(labels))], color=colors_cluster)
			#plt.xticks(ind+width/2., list(str(i) for i in range(len(labels)) ) )
		#plt.show()
		'''

		drawRadarChart(self, normalize(np.array(self.data)), labels, n_clusters_)

def drawRadarChart(self, data, labels, n_clusters_):

	clusters = [[] for _ in range(n_clusters_)]

	for k in range(n_clusters_):
		my_members = labels == k
		for i in range(len(labels)):
			if my_members[i]:
				clusters[k] += [list(data[i])]

	weapons = []

	for cluster in clusters:
		if(len(cluster) > 0):
			weapons += [np.mean(cluster, axis=0)]

	
	while len(weapons) > 0 :

		if len(weapons) > 1 :
			draw_radar(weapons[:1])
			weapons = weapons[1:]

	draw_radar(weapons)

	plt.show()



def main():


	data = []

	pop_file = open("population_cluster.txt", "r")

	content = pop_file.readlines()

	temp = []

	fits = []
	dists = []

	for string in content:
		
		if "Weapon" in string or "Projectile" in string:
			split_spaces = string.split(" ")

			for splitted in split_spaces:
				if ":" in splitted:
					split_colon = splitted.split(":")
					temp += [float(split_colon[1])]
					if (len(temp) == 10):
						data += [temp]
						temp = []

		if "fitness" in string :
			split_spaces = string.split(" ")

			for splitted in split_spaces:
				if "(" in splitted:
					splitted = splitted.replace("(", "")
					splitted = splitted.replace(")", "")
					splitted = splitted.replace(",", "")
					splitted = splitted.replace("\n", "")
					fit = float(splitted)
					fits += [fit]
				if ")" in splitted:
					splitted = splitted.replace("(", "")
					splitted = splitted.replace(")", "")
					splitted = splitted.replace(",", "")
					splitted = splitted.replace("\n", "")
					dist = float(splitted)
					dists += [dist]

	fits = np.array(fits)
	dists = np.array(dists)

	#get third quartile

	q3 = np.percentile(fits, 75)
	print("third quartile " + str(q3))

	data_filtered = []
	dists_filtered = []

	#filter out ind with fit < q3
	for i in range(len(fits)):
		if fits[i] >= q3 :
			data_filtered += [data[i]]
			dists_filtered += [dists[i]]

	d3 = np.percentile(dists_filtered, 50)
	print("median dist" + str(d3))



	c = ClusterProceduralWeapon(data_filtered, data_filtered)

	c.cluster()

main()


