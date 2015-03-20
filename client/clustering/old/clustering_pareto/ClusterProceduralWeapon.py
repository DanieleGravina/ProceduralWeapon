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
from radar_chart import draw_radar
from math import *
from sklearn.preprocessing import StandardScaler
from sklearn.preprocessing import Normalizer
from sklearn.preprocessing import MinMaxScaler
from sklearn.decomposition import PCA


from Costants import *

limits = [(ROF_MIN/100, ROF_MAX/100), (SPREAD_MIN/100, SPREAD_MAX/100), (AMMO_MIN, AMMO_MAX), (SHOT_COST_MIN, SHOT_COST_MAX), (RANGE_MIN/100, RANGE_MAX/100),
          (SPEED_MIN, SPEED_MAX), (DMG_MIN, DMG_MAX), (DMG_RAD_MIN, DMG_RAD_MAX), (-GRAVITY_MIN, -GRAVITY_MAX), 
          (EXPLOSIVE_MIN, EXPLOSIVE_MAX)]

label =["ROF", "SPREAD", "AMMO", "SHOT_COST", "RANGE", "SPEED", "DMG", "DMG_RAD", "GRAVITY", "EXPLOSIVE"]

def printWeapon(pop):
    i = 0
    for ind in pop :
        print("(" + str(i) + ")")
        i += 1
        print("Weapon "+ " Rof:" + str(ind[0]) + " Spread:" + str(ind[1]) + " MaxAmmo:" + str(ind[2]) 
            + " ShotCost:" + str(ind[3]) + " Range:" + str(ind[4]) )
        print("Projectile "+ " Speed:" + str(ind[5]) + " Damage:" + str(ind[6]) + " DamageRadius:" + str(ind[7])
            + " Gravity:" + str(ind[8]) + " Explosive:" + str(ind[9]))

        print("Weapon "+ " Rof:" + str(ind[10]) + " Spread:" + str(ind[11]) + " MaxAmmo:" + str(ind[12]) 
            + " ShotCost:" + str(ind[13]) + " Range:" + str(ind[14]) )
        print("Projectile "+ " Speed:" + str(ind[15]) + " Damage:" + str(ind[16]) + " DamageRadius:" + str(ind[17])
            + " Gravity:" + str(ind[18]) + " Explosive:" + str(ind[19]))

        print("*********************************************************")


def writeWeapon(pop, pop_file):
    i = 0
    for ind in pop :
        pop_file.write("(" + str(i*2) + ")\n")
        i += 1
        pop_file.write("Weapon "+ " Rof:" + str(ind[0]) + " Spread:" + str(ind[1]) + " MaxAmmo:" + str(ind[2]) 
            + " ShotCost:" + str(ind[3]) + " Range:" + str(ind[4]) + "\n")
        pop_file.write("Projectile "+ " Speed:" + str(ind[5]) + " Damage:" + str(ind[6]) + " DamageRadius:" + str(ind[7])
            + " Gravity:" + str(ind[8]) + " Explosive:" + str(ind[9]) +"\n")

        pop_file.write("Weapon "+ " Rof:" + str(ind[10]) + " Spread:" + str(ind[11]) + " MaxAmmo:" + str(ind[12]) 
            + " ShotCost:" + str(ind[13]) + " Range:" + str(ind[14]) + "\n")
        pop_file.write("Projectile "+ " Speed:" + str(ind[15]) + " Damage:" + str(ind[16]) + " DamageRadius:" + str(ind[17])
            + " Gravity:" + str(ind[18]) + " Explosive:" + str(ind[19]) + "\n")

        pop_file.write("*********************************************************" + "\n")
    pop_file.write("\n" + "============================================================================================================" + "\n")


def normalize(data):
	for i in range(data.shape[0]):
		for j in range(data.shape[1]):
			data[i][j] = (data[i][j] - limits[j%NUM_PAR][0])/(limits[j%NUM_PAR][1] - limits[j%NUM_PAR][0])

	return data

def normalize_single(data):
	clone = np.array(data, np.float32)
	for i in range(data.shape[0]):
		clone[i] = (data[i] - limits[i%NUM_PAR][0])/(limits[i%NUM_PAR][1] - limits[i%NUM_PAR][0])

	return clone

def postProcess(data):
	clone = list(data)

	#fireinterval become rate of fire -> (1/fireinterval)
	clone[0] = log(1/(ROF_MIN/100)) + log(1/clone[0])

	#gravity is inverted
	clone[8] = - clone[8]

	return clone

class ClusterProceduralWeapon:
	def __init__(self, pure_data = None, fits = [], file = None):
		self.pure_data = pure_data
		self.fits = fits
		self.file = file

	def cluster(self):

		try :
			os.makedirs("cluster")
			os.chdir("cluster")
		except :
			os.chdir("cluster")

		self.file = open("cluster.txt", "w")

		cluster_file = self.file

		data = []

		i = 0

		while i < len(self.pure_data) :

			temp = self.pure_data[i] + self.pure_data[i + 1]
			data += [temp]

			i += 2

		X = np.array(data, np.float32)

		print(X.shape)

		X = normalize(X)

		printWeapon(X)

		db = DBSCAN(eps=0.8, min_samples=10).fit(X)
		labels = db.labels_

		labels_unique = np.unique( [labels[i] for i in range(len(labels)) if labels[i] != - 1] )
		n_clusters_ = len(labels_unique)

		print(labels)

		labels_unique = np.unique(labels)
		n_clusters_ = len(labels_unique)

		index = []
		fitness = []
		mean = []
		stdev = []
		fits_clustered = [[] for _ in range(n_clusters_)]
		clusters = [[] for _ in range(n_clusters_)]

		print("number of estimated clusters : %d" % n_clusters_ )
		cluster_file.write("number of estimated clusters : %d" % n_clusters_ + "\n")

		for k in range(n_clusters_):
			my_members = labels == k
			for i in range(len(labels)):
				if my_members[i]:
					index += [i]
					fitness += [self.fits[i]]
					fits_clustered[k] += [self.fits[i]]
			
			if fitness != []:
				mean += [statistics.mean(fitness)]
				stdev += [statistics.stdev(fitness)]

			clusters[k] += [postProcess(data[i]) for i in range(len(labels)) if my_members[i]]

			cluster_file.write("index:"+ "\n")
			cluster_file.write(str(index) + "\n")
			cluster_file.write("fitness:"+ "\n")
			cluster_file.write(str(fitness)+ "\n")
			cluster_file.write("mean fitness:"+ "\n")
			cluster_file.write(str(mean)+ "\n")
			cluster_file.write("std dev fitness:"+ "\n")
			cluster_file.write(str(stdev)+ "\n")
			cluster_file.write("members:"+ "\n")
			writeWeapon(clusters[k], cluster_file)

			print(index)
			print("members:")
			printWeapon(clusters[k])
			print("fitness:"+ "\n")
			print(str(fitness)+ "\n")
			print("mean fitness:"+ "\n")
			print(str(mean)+ "\n")
			print("std dev fitness:"+ "\n")
			print(str(stdev)+ "\n")
			print("mean of cluster")
			print(np.mean(clusters[k], axis=0))
			print("std of cluster")
			print(np.std(clusters[k], axis=0))


			index = []
			mean = []
			fitness = []
			stdev = []

		colors = list('bgrcmykbgrcmykbgrcmykbgrcmyk')

		pca = MDS(n_components=2)

		pos = pca.fit_transform(X.astype(np.float64))

		'''
		plt.figure(7)

		for i in range(len(pos[:,0])):

			plt.plot(pos[i, 0], pos[i, 1], 'o', markerfacecolor=colors[labels[i] % len(colors)], markeredgecolor='k')

		plt.show()

		return
		'''

		X_ordered = []
		X = np.array(data);
		colors_ordered = []
		fits_ordered = []
		colors_cluster = []

		for i in range(n_clusters_):
			for j in range(len(labels)):
				if labels[j] == i and labels[j] != -1:
					X_ordered.append(X[j][:NUM_PAR])
					X_ordered.append(X[j][NUM_PAR:])
					fits_ordered.append(self.fits[j])
					colors_ordered += [colors[labels[j]]]
					colors_ordered += [colors[labels[j]]]
			colors_cluster += [colors_ordered[len(colors_ordered) - 1]]

		labels_ = [labels[i] for i in range(len(labels)) if labels[i] != -1]

		#fig = plt.figure(figsize=(9, 9))
		#fig.subplots_adjust(wspace=0.50, hspace=0.25)
		'''
		k = [i for i in range(len(labels_)*2)]
		for j in range(10):
			#ax = fig.add_subplot(4, 3, j+1)
			plt.figure(10 + j)
			plt.ylabel(label[j])
			plt.ylim(limits[j][0], limits[j][1])
			plt.bar(k, [X_ordered[ind][j] for ind in range(len(labels_)*2)], color=colors_ordered)
		'''

		'''
		plt.figure(9)

		k = [i for i in range(len(labels_))]
		plt.ylabel("Entropy")
		plt.bar(k, fits_ordered, color=[colors_ordered[i] for i in range(len(colors_ordered)) if i % 2 == 0])
		'''

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

		drawRadarChart(self, clusters, n_clusters_, colors_cluster, fits_clustered)
		drawBarPlot(self, clusters, n_clusters_, colors_cluster, fits_clustered)

		#plt.show()

def drawRadarChart(self, clusters, n_clusters_, colors, fits_clustered):

	max_radars = 2
	n_clusters_ = 2

	weapons = []

	for cluster in clusters:
		if(len(cluster) > 0):
			temp = list(np.mean(cluster, axis=0))
			weapons += [temp[NUM_PAR:]]
			weapons += [temp[:NUM_PAR]]
	
	index = 0

	while len(weapons) > 0 :

		if len(weapons) > max_radars :
			draw_radar(weapons[:max_radars], colors[index], fits_clustered[index])
			plt.savefig("radar"+ str(index) + ".png", bbox_inches='tight')
			weapons = weapons[max_radars:]
		else :
			draw_radar(weapons, colors[index], fits_clustered[index])
			plt.savefig("radar"+ str(index) + ".png", bbox_inches='tight')
			weapons = []

		index += 1

def drawBarPlot(self, clusters, n_clusters_, colors_cluster, fitness_cluster):

	weapons = []
	weapons_std = []

	limits[0] = (0, log(1/(ROF_MIN/100))*2)

	alphabet = list("ABCDEFGHILMNOPQRSTUVZ")

	width = 0.4

	for cluster in clusters:
		if(len(cluster) > 0):
			weapons += [list(np.mean(cluster, axis=0))]
			weapons_std += [list(np.std(cluster, axis=0))]

	fig = plt.figure(figsize=(16, 9))
	fig.subplots_adjust(wspace=0.50, hspace=0.25)

	k = np.arange(len(weapons))

	for j in range(10):
		ax = fig.add_subplot(4, 3, j+1)
		plt.ylabel(label[j])
		plt.ylim(limits[j][0], limits[j][1])
		ax.bar(k, [weapons[ind][j] for ind in range(len(weapons))], width, color=colors_cluster)
		ax.bar(k + width, [weapons[ind][j + NUM_PAR] for ind in range(len(weapons))], width, color=colors_cluster)
		ax.set_xticks(k + width)
		ax.set_xticklabels( alphabet[:n_clusters_] )

	ax = fig.add_subplot(4, 3, 11)
	plt.ylabel("ENTROPY")
	ax.bar(k, [np.mean(fitness_cluster[i]) for i in range(len(weapons))], width, color=colors_cluster,
			yerr = [np.std(fitness_cluster[i]) for i in range(len(weapons))])
	ax.set_xticks(k + width/2)
	ax.set_xticklabels( alphabet[:(len(weapons))] )

	plt.savefig("cluster.png", bbox_inches='tight')

def main():


	data = []
	fits = []

	pop_file = open("population_cluster.txt", "r")

	content = pop_file.readlines()

	temp = []

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


	c = ClusterProceduralWeapon(data, fits)

	c.cluster()

main()


