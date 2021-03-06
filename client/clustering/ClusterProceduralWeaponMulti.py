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
from radar_chart_multi import draw_radar
from math import *
from sklearn.preprocessing import StandardScaler
from sklearn.preprocessing import Normalizer
from sklearn.preprocessing import MinMaxScaler


from Costants import *

limits = [(ROF_MIN/100, ROF_MAX/100), (SPREAD_MIN/100, SPREAD_MAX/100), (AMMO_MIN, AMMO_MAX), (SHOT_COST_MIN, SHOT_COST_MAX), (RANGE_MIN/100, RANGE_MAX/100),
          (SPEED_MIN, SPEED_MAX), (DMG_MIN, DMG_MAX), (DMG_RAD_MIN, DMG_RAD_MAX), (GRAVITY_MIN, GRAVITY_MAX), 
          (EXPLOSIVE_MIN, EXPLOSIVE_MAX)]

label =["ROF", "SPREAD", "AMMO", "SHOT_COST", "LIFE_SPAN", "SPEED", "DMG", "DMG_RAD", "GRAVITY", "EXPLOSIVE"]

objective_1 = "DISTANCE"

objective_2 = "KILL_STREAK"

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
        pop_file.write("(" + str(i) +  ")" + "\n")
        i += 1
        pop_file.write("Weapon "+ " Rof:" + str(ind[0]) + " Spread:" + str(ind[1]) + " MaxAmmo:" + str(ind[2]) 
            + " ShotCost:" + str(ind[3]) + " Range:" + str(ind[4]) + "\n")
        pop_file.write("Projectile "+ " Speed:" + str(ind[5]) + " Damage:" + str(ind[6]) + " DamageRadius:" + str(ind[7])
            + " Gravity:" + str(ind[8]) + " Explosive:" + str(ind[9]) +"\n")
        pop_file.write("Weapon "+ " Rof:" + str(ind[10]) + " Spread:" + str(ind[11]) + " MaxAmmo:" + str(ind[12]) 
            + " ShotCost:" + str(ind[13]) + " Range:" + str(ind[14]) + "\n")
        pop_file.write("Projectile "+ " Speed:" + str(ind[15]) + " Damage:" + str(ind[16]) + " DamageRadius:" + str(ind[17])
            + " Gravity:" + str(ind[18]) + " Explosive:" + str(ind[19]) +"\n")
        pop_file.write("\n")

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
	clone[10] = log(1/(ROF_MIN/100)) + log(1/clone[10])

	#gravity is inverted
	clone[8] = - clone[8]
	clone[18] = - clone[18]

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

		db = DBSCAN(eps=0.2, min_samples=5).fit(X)
		labels = db.labels_

		labels_unique = np.unique(labels)
		n_clusters_ = len(labels_unique)

		print(labels)

		labels_unique = np.unique(labels)
		n_clusters_ = len(labels_unique)

		index = []
		fitness = []

		entropy_mean = []
		entropy_stdev = []
		obj1_mean = []
		obj1_stdev = []

		obj2_mean = []
		obj2_stdev = []

		fits_clustered = [[] for _ in range(n_clusters_)]
		clusters = [[] for _ in range(n_clusters_)]

		print("number of estimated clusters : %d" % n_clusters_ )
		cluster_file.write("number of estimated clusters : %d" % n_clusters_ + "\n")

		num_cluster = 0

		for k in range(n_clusters_):
			my_members = labels == k
			for i in range(len(labels)):
				if my_members[i]:
					index += [i]
					fitness += [self.fits[i]]
					fits_clustered[k] += [self.fits[i]]
			
			if fitness != []:

				entropy_mean += [ statistics.mean( [fitness[i][0] for i in range(len(fitness))] ) ]
				entropy_stdev += [ statistics.stdev( [fitness[i][0] for i in range(len(fitness))] ) ]

				obj1_mean += [ statistics.mean( [fitness[i][1] for i in range(len(fitness))] ) ]
				obj1_stdev += [ statistics.stdev( [fitness[i][1] for i in range(len(fitness))] ) ]

				obj2_mean += [ statistics.mean( [fitness[i][2] for i in range(len(fitness))] ) ]
				obj2_stdev += [ statistics.stdev( [fitness[i][2] for i in range(len(fitness))] ) ]

			clusters[k] += [postProcess(data[i]) for i in range(len(labels)) if my_members[i]]

			cluster_file.write("cluster: " + str(num_cluster) + "°" + "\n")
			num_cluster += 1

			cluster_file.write("index:"+ "\n")
			cluster_file.write(str(index) + "\n")
			cluster_file.write("fitness:"+ "\n")
			cluster_file.write(str(fitness)+ "\n")

			cluster_file.write("mean balance:"+ "\n")
			cluster_file.write(str(entropy_mean)+ "\n")
			cluster_file.write("std dev balance:"+ "\n")
			cluster_file.write(str(entropy_stdev)+ "\n")

			cluster_file.write("mean obj1:"+ "\n")
			cluster_file.write(str(obj1_mean)+ "\n")
			cluster_file.write("std dev obj1:"+ "\n")
			cluster_file.write(str(obj1_stdev)+ "\n")

			cluster_file.write("mean obj2:"+ "\n")
			cluster_file.write(str(obj2_mean)+ "\n")
			cluster_file.write("std dev obj2:"+ "\n")
			cluster_file.write(str(obj2_stdev)+ "\n")

			cluster_file.write("members:"+ "\n")
			writeWeapon([data[i] for i in range(len(labels)) if my_members[i]], cluster_file)

			cluster_file.write("==========================================================================="+ "\n")

			print(index)
			print("members:")
			printWeapon([data[i] for i in range(len(labels)) if my_members[i]])
			print("fitness:"+ "\n")
			print(str(fitness)+ "\n")

			print("mean entropy:"+ "\n")
			print(str(entropy_mean)+ "\n")
			print("std dev fitness:"+ "\n")
			print(str(entropy_stdev)+ "\n")

			print("mean obj1:"+ "\n")
			print(str(obj1_mean)+ "\n")
			print("std dev obj1:"+ "\n")
			print(str(obj1_stdev)+ "\n")

			print("mean obj2:"+ "\n")
			print(str(obj2_mean)+ "\n")
			print("std dev obj2:"+ "\n")
			print(str(obj2_stdev)+ "\n")

			print("mean of cluster")
			print(np.mean([data[i] for i in range(len(labels)) if my_members[i]], axis=0))
			print("std of cluster")
			print(np.std([data[i] for i in range(len(labels)) if my_members[i]], axis=0))


			index = []
			fitness = []

			entropy_mean = []
			entropy_stdev = []
			obj1_mean = []
			obj1_stdev = []
			obj2_stdev = []
			obj2_mean = []

		colors = list('bgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmyk')

		'''

		mds = MDS(n_components=2)

		pos = mds.fit_transform(X.astype(np.float64))

		plt.figure(figsize = (16,9))

		for i in range(len(pos[:,0])):

			if labels[i] != -1 :
				plt.plot(pos[i, 0], pos[i, 1], 'o', markerfacecolor=colors[labels[i]], markeredgecolor='k')
			else:
				plt.plot(pos[i, 0], pos[i, 1], 'x', markerfacecolor=colors[labels[i]], markeredgecolor='k')

		plt.savefig("mds.png", bbox_inches='tight')
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

		if -1 in labels:
			drawBarPlot(self, clusters, n_clusters_ - 1, colors_cluster, fits_clustered)
		else :
			drawBarPlot(self, clusters, n_clusters_, colors_cluster, fits_clustered)

		#plt.show()

def drawRadarChart(self, clusters, n_clusters_, colors, fits_clustered):

	max_radars = 2
	n_clusters_ = 2

	weapons = []
	num_samples = []

	for cluster in clusters:
		if(len(cluster) > 0):
			temp = list(np.mean(cluster, axis=0))
			num_samples += [len(cluster)]
			weapons += [temp[:NUM_PAR]]
			weapons += [temp[NUM_PAR:]]
	
	index = 0

	while len(weapons) > 0 :

		if len(weapons) > max_radars :
			draw_radar(weapons[:max_radars], colors[index], fits_clustered[index], num_samples[0])
			plt.savefig("radar"+ str(index) + ".png", bbox_inches='tight')
			plt.close()
			weapons = weapons[max_radars:]
			num_samples = num_samples[1:]
		else :
			draw_radar(weapons, colors[index], fits_clustered[index], num_samples[0])
			plt.savefig("radar"+ str(index) + ".png", bbox_inches='tight')
			plt.close()
			weapons = []

		index += 1

def drawBarPlot(self, clusters, n_clusters_, colors_cluster, fitness_cluster, index = 0):

	limits[0] = (0, log(1/(ROF_MIN/100))*2)

	path = "cluster.png"

	if n_clusters_ > 10 :
		drawBarPlot(self, clusters[10:], n_clusters_ - 10, colors_cluster[10:], fitness_cluster[10:], index + 1)
		clusters = clusters[:10]
		n_clusters_  = 10
		colors_cluster = colors_cluster[:10]
		fitness_cluster[:10]
		path = "cluster" + str(index) + ".png"

	weapons = []
	weapons_std = []

	alphabet = list("ABCDEFGHILMNOPQRSTUVZ")

	k = np.arange(n_clusters_)
	width = 0.4

	for cluster in clusters:
		if(len(cluster) > 0):
			weapons += [list(np.mean(cluster, axis=0))]
			weapons_std += [list(np.std(cluster, axis=0))]

	fig = plt.figure(figsize=(16, 9))
	fig.subplots_adjust(wspace=0.5, hspace=0.25)

	for j in range(10):
		ax = fig.add_subplot(4, 4, j+1)
		plt.ylabel(label[j])
		plt.ylim(limits[j][0], limits[j][1])
		ax.bar(k, [weapons[ind][j] for ind in range(n_clusters_)], width, color=colors_cluster)
		ax.bar(k + width, [weapons[ind][j + NUM_PAR] for ind in range(n_clusters_)], width, color=colors_cluster)
		ax.set_xticks(k + width)
		ax.set_xticklabels( alphabet[:n_clusters_] )

	ax = fig.add_subplot(4, 4, 11)
	plt.ylabel("BALANCE")
	ax.bar(k, [np.mean(fitness_cluster[i], axis = 0)[0] for i in range(n_clusters_)], width, color=colors_cluster,
			yerr = [np.std(fitness_cluster[i], axis = 0)[0] for i in range(n_clusters_)])
	ax.set_xticks(k + width/2)
	ax.set_xticklabels( alphabet[:n_clusters_] )

	ax = fig.add_subplot(4, 4, 12)
	plt.ylabel(objective_1)
	ax.bar(k, [np.mean(fitness_cluster[i], axis = 0)[1] for i in range(n_clusters_)], width, color=colors_cluster,
			yerr = [np.std(fitness_cluster[i], axis = 0)[1] for i in range(n_clusters_)])
	ax.set_xticks(k + width/2)
	ax.set_xticklabels( alphabet[:n_clusters_] )

	ax = fig.add_subplot(4, 4, 13)
	plt.ylabel(objective_2)
	ax.bar(k, [np.mean(fitness_cluster[i], axis = 0)[2] for i in range(n_clusters_)], width, color=colors_cluster,
			yerr = [np.std(fitness_cluster[i], axis = 0)[2] for i in range(n_clusters_)])
	ax.set_xticks(k + width/2)
	ax.set_xticklabels( alphabet[:n_clusters_] )



	plt.savefig(path, bbox_inches='tight')
	plt.close()

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

			index = 0
			temp_fit = []

			for splitted in split_spaces:

				if index > 0 and index < 4:
					splitted = splitted.replace("(", "")
					splitted = splitted.replace(")", "")
					splitted = splitted.replace(",", "")
					splitted = splitted.replace("\n", "")
					temp_fit += [float(splitted)]

				index += 1

			fits += [temp_fit]
			
	c = ClusterProceduralWeapon(data, fits)

	c.cluster()

main()


