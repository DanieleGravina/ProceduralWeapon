import numpy as np
import matplotlib.pyplot as plt

def main():

	statistics_file = open("statistics.txt", "r")

	content = statistics_file.readlines()

	index = 0
	i = 0

	statistics = {}
	data = [[] for _ in range(5)]

	for string in content:
		if "[" in string:
			split_spaces = string.split(" ")
			for splitted in split_spaces :
				splitted = splitted.replace("[", "")
				splitted = splitted.replace("]", "")
				splitted = splitted.replace(",", "")
				splitted = splitted.replace("\n", "")
				try:
					val = int(splitted)
				except :
					val = float(splitted)
				data[i] += [val]
			i += 1
			if i == 5 :
				i = 0
				statistics.update({index : data})
				data = [[] for _ in range(5)]
				index += 1

	mean_time = []
	std_time = []

	for key, val in statistics.items():
		mean_time += [np.mean(val[4])]
		std_time += [np.std(val[4])]

	plt.figure(figsize=(16, 9))
	plt.ylabel("Time")
	plt.xlabel("Game Speed")
	plt.xlim(0, len(mean_time) + 1)
	labels = [str(i) + "x" for i in range(len(mean_time))]
	plt.errorbar([i + 1 for i in range(len(mean_time))], mean_time, yerr = std_time)
	plt.xticks([i + 1 for i in range(len(mean_time))], labels)
	plt.savefig("time_speed.png", bbox_inches='tight', dpi = 200)
	plt.close()

	plt.figure(figsize=(16, 9))
	plt.ylim(0, 40)
	plt.boxplot([val[1] for key, val in statistics.items()], labels=[str(i + 1) + "x" for i in range(len(mean_time))])
	plt.savefig("kill_bot1_speed.png", bbox_inches='tight', dpi = 200)
	plt.close()

	plt.figure(figsize=(16, 9))
	plt.ylim(0, 40)
	plt.boxplot([val[2] for key, val in statistics.items()], labels=[str(i + 1) + "x" for i in range(len(mean_time))])
	plt.savefig("kill_bot2_speed.png", bbox_inches='tight', dpi = 200)
	plt.close()
		

main()




