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
	clusters = []

	pop_file = open("cluster.txt", "r")

	content = pop_file.readlines()

	temp = []

	for string in content:
		
		if "Weapon" in string or "Projectile" in string:
			split_spaces = string.split(" ")

			for splitted in split_spaces:
				if ":" in splitted:
					split_colon = splitted.split(":")
					temp += [float(split_colon[1])]
					if (len(temp) == 20):
						data += [temp]
						temp = []

		if "=" in string:
			if len(data) != 0:
				clusters += [data]
			data = []

			
	for c in clusters:
		print("cluster:")
		for d in c:
			print(c)
		print("=============")

main()