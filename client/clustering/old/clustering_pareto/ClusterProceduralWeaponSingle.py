import os,sys,inspect
os.chdir("..")
currentdir = os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe())))
parentdir = os.path.dirname(currentdir)
sys.path.insert(0,parentdir) 

from sklearn.manifold import MDS
from sklearn.decomposition import PCA
from sklearn.cluster import DBSCAN
from sklearn.cluster import KMeans
from sklearn import metrics
import numpy as np
from sklearn import metrics
import statistics
import matplotlib.pyplot as plt
from radar_chart_single import draw_radar
from math import *

from Costants import *

limits = [(ROF_MIN/100, ROF_MAX/100), (SPREAD_MIN/100, SPREAD_MAX/100), (AMMO_MIN, AMMO_MAX), (SHOT_COST_MIN, SHOT_COST_MAX), (RANGE_MIN/100, RANGE_MAX/100),
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
	clone = list(data)

	#fireinterval become rate of fire -> (1/fireinterval)
	clone[0] = log(1/(ROF_MIN/100)) + log(1/clone[0])

	#gravity is inverted
	clone[8] = - clone[8]

	return clone

class ClusterProceduralWeapon:
	def __init__(self, data = None, fitness = None, file = None):
		self.data = data
		self.fits = fitness
		self.file = file

	def cluster(self):

		try :
			os.makedirs("cluster")
			os.chdir("cluster")
		except :
			os.chdir("cluster")

		self.file = open("cluster.txt", "w")

		cluster_file = self.file

		X = np.array(self.data, np.float32)

		print(X.shape)

		X = normalize(X)

		db = DBSCAN(eps=0.05, min_samples=2).fit(X)
		labels = db.labels_

		#k = KMeans(init='random', n_clusters=4, n_init=10).fit(X)
		#labels = k.labels_

		labels_unique = np.unique( [labels[i] for i in range(len(labels)) if labels[i] != - 1] )
		n_clusters_ = len(labels_unique)

		print(labels)

		index = []
		fitness = []

		entropy_mean = []
		entropy_stdev = []
		dist_mean = []
		dist_stdev = []

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

			if len(fitness) == 1 :
				fitness += [fitness[0]]
				fits_clustered[k] += [fitness[0]]
			
			if fitness != []:

				entropy_mean += [ statistics.mean( [fitness[i][0] for i in range(len(fitness))] ) ]
				entropy_stdev += [ statistics.stdev( [fitness[i][0] for i in range(len(fitness))] ) ]
				dist_mean += [ statistics.mean( [fitness[i][1] for i in range(len(fitness))] ) ]
				dist_stdev += [ statistics.stdev( [fitness[i][1] for i in range(len(fitness))] ) ]

			clusters[k] += [postProcess(self.data[i]) for i in range(len(labels)) if my_members[i]]

			cluster_file.write("index:"+ "\n")
			cluster_file.write(str(index) + "\n")
			cluster_file.write("fitness:"+ "\n")
			cluster_file.write(str(fitness)+ "\n")

			cluster_file.write("mean entropy:"+ "\n")
			cluster_file.write(str(entropy_mean)+ "\n")
			cluster_file.write("std dev fitness:"+ "\n")
			cluster_file.write(str(entropy_stdev)+ "\n")

			cluster_file.write("mean dist:"+ "\n")
			cluster_file.write(str(dist_mean)+ "\n")
			cluster_file.write("std dev dist:"+ "\n")
			cluster_file.write(str(dist_stdev)+ "\n")

			cluster_file.write("members:"+ "\n")
			writeWeapon([self.data[i] for i in range(len(labels)) if my_members[i]], cluster_file)

			print(index)
			print("members:")
			printWeapon([self.data[i] for i in range(len(labels)) if my_members[i]])
			print("fitness:"+ "\n")
			print(str(fitness)+ "\n")

			print("mean entropy:"+ "\n")
			print(str(entropy_mean)+ "\n")
			print("std dev fitness:"+ "\n")
			print(str(entropy_stdev)+ "\n")

			print("mean dist:"+ "\n")
			print(str(dist_mean)+ "\n")
			print("std dev dist:"+ "\n")
			print(str(dist_stdev)+ "\n")

			print("mean of cluster")
			print(np.mean([self.data[i] for i in range(len(labels)) if my_members[i]], axis=0))
			print("std of cluster")
			print(np.std([self.data[i] for i in range(len(labels)) if my_members[i]], axis=0))


			index = []
			fitness = []

			entropy_mean = []
			entropy_stdev = []
			dist_mean = []
			dist_stdev = []


		#mds = MDS(n_components=2)

		#pos = mds.fit_transform(X.astype(np.float64))

		pca = PCA(n_components=2)

		pos = pca.fit_transform(X.astype(np.float64))

		colors = list('bgrcmykbgrcmykbgrcmykbgrcmyk')

		plt.figure(figsize = (16,9))

		for i in range(len(pos[:,0])):

			plt.plot(pos[i, 0], pos[i, 1], 'o', markerfacecolor=colors[labels[i]], markeredgecolor='k')

		plt.savefig("mds.png", bbox_inches='tight')

		X_ordered = []
		X = np.array(self.data);
		colors_ordered = []
		fits_ordered = []
		colors_cluster = []

		for i in range(n_clusters_):
			for j in range(len(labels)):
				if labels[j] == i and labels[j] != -1:
					X_ordered.append(X[j][:])
					fits_ordered.append(self.fits[j])
					colors_ordered += [colors[labels[j]]]
			colors_cluster += [colors_ordered[len(colors_ordered) - 1]]

		labels_ = [labels[i] for i in range(len(labels)) if labels[i] != -1]

		#plt.show()

		drawRadarChart(self, clusters, n_clusters_, colors_cluster, fits_clustered)
		drawBarPlot(self, clusters, n_clusters_, colors_cluster, fits_clustered)

def drawRadarChart(self, clusters, n_clusters_, colors, fits):

	weapons = []

	for cluster in clusters:
		if(len(cluster) > 0):
			weapons += [np.mean(cluster, axis=0)]

	index = 0
	
	while len(weapons) > 0 :
		draw_radar(weapons[:1], colors[index], fits[index])
		weapons = weapons[1:]
		index += 1
		plt.savefig("radar"+ str(index) + ".png", bbox_inches='tight')

def drawBarPlot(self, clusters, n_clusters_, colors_cluster, fitness_cluster):

	weapons = []
	weapons_std = []

	limits[0] = (0, log(1/(ROF_MIN/100))*2)

	alphabet = list("ABCDEFGHILMNOPQRSTUVZ")

	k = np.arange(n_clusters_)
	width = 0.4

	for cluster in clusters:
		if(len(cluster) > 0):
			weapons += [list(np.mean(cluster, axis=0))]
			weapons_std += [list(np.std(cluster, axis=0))]

	fig = plt.figure(figsize=(16, 9))
	fig.subplots_adjust(wspace=0.50, hspace=0.25)

	for j in range(10):
		ax = fig.add_subplot(4, 3, j+1)
		plt.ylabel(label[j])
		#plt.ylim(limits[j][0], limits[j][1])
		ax.bar(k, [weapons[ind][j] for ind in range(n_clusters_)], width, color=colors_cluster)
		ax.set_xticks(k + width/2)
		ax.set_xticklabels( alphabet[:n_clusters_] )

	ax = fig.add_subplot(4, 3, 11)
	plt.ylabel("ENTROPY")
	ax.bar(k, [np.mean(fitness_cluster[i], axis = 0)[0] for i in range(n_clusters_)], width, color=colors_cluster,
			yerr = [np.std(fitness_cluster[i], axis = 0)[0] for i in range(n_clusters_)])
	ax.set_xticks(k + width)
	ax.set_xticklabels( alphabet[:n_clusters_] )

	ax = fig.add_subplot(4, 3, 12)
	plt.ylabel("DIST")
	ax.bar(k, [np.mean(fitness_cluster[i], axis = 0)[1] for i in range(n_clusters_)], width, color=colors_cluster,
			yerr = [np.std(fitness_cluster[i], axis = 0)[1] for i in range(n_clusters_)])
	ax.set_xticks(k + width)
	ax.set_xticklabels( alphabet[:n_clusters_] )

	plt.savefig("cluster.png", bbox_inches='tight')



def main():

	os.chdir("clustering_pareto")

	data = []

	pop_file = open("population_cluster.txt", "r")

	content = pop_file.readlines()

	temp = []

	fitness = []

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
			temp_fit = []

			for splitted in split_spaces:
				if "(" in splitted:
					splitted = splitted.replace("(", "")
					splitted = splitted.replace(")", "")
					splitted = splitted.replace(",", "")
					splitted = splitted.replace("\n", "")
					fit = float(splitted)
					temp_fit += [fit]
				if ")" in splitted:
					splitted = splitted.replace("(", "")
					splitted = splitted.replace(")", "")
					splitted = splitted.replace(",", "")
					splitted = splitted.replace("\n", "")
					dist = float(splitted)
					temp_fit += [dist]

			fitness += [temp_fit]

	'''
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
	'''



	c = ClusterProceduralWeapon(data, fitness)

	c.cluster()

main()


