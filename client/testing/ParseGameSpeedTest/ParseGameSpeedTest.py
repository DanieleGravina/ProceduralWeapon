import numpy as np
import matplotlib.pyplot as plt
from math import log
from math import pow

def entropy(kill1, kill2, die1, die2):
	e = []
	for i in range(len(kill1)):
		e += [eval_entropy(kill1[i], kill2[i], die1[i], die2[i])]
	return e 

def eval_entropy(kill_1, kill_2, die_1, die_2):
	suicides = 0
	suicides += (die_1 - kill_2)
	suicides += (die_2 - kill_1)
	kill1 = kill_1
	kill2 = kill_2
	total = kill1 + kill2

	e = -(kill1/total*log(kill1/total, 2) + kill2/total*log(kill2/total,2))

	#e += total/40
	#e += pow(0.9, suicides)

	return e

def main():

	statistics_file = open("statistics.txt", "r")

	content = statistics_file.readlines()

	index = 0
	i = 0
	j = 0

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
				j += 1
				data[i] += [val]
				if j == 10:
					j = 0
					break
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

	for i in range(len(mean_time)) :
		print("mean" + str(i+1) + " " + str(mean_time[i]))
		print("std" + str(i+1) + " " + str(std_time[i]))
		print("************")

	i = 0
	for key, val in statistics.items():
		print(i + 1)
		i += 1
		print(np.mean(entropy(val[0], val[1], val[2], val[3])))
		print(np.std(entropy(val[0], val[1], val[2], val[3])))



	plt.figure(figsize=(16, 9))
	plt.ylabel("Time")
	plt.xlabel("Game Speed")
	plt.xlim(0, len(mean_time) + 1)
	labels = [str(i + 1) + "x" for i in range(len(mean_time))]
	plt.errorbar([i + 1 for i in range(len(mean_time))], mean_time, yerr = std_time)
	plt.xticks([i + 1 for i in range(len(mean_time))], labels)
	plt.savefig("time_speed.png", bbox_inches='tight', dpi = 200)
	plt.close()

	plt.figure(figsize=(16, 9))
	plt.ylim(0, 40)
	plt.ylabel("Kill 1° bot")
	plt.xlabel("Game Speed")
	plt.boxplot([val[0] for key, val in statistics.items()], labels=[str(i + 1) + "x" for i in range(len(mean_time))])
	plt.savefig("kill1_speed.png", bbox_inches='tight', dpi = 200)
	plt.close()

	plt.figure(figsize=(16, 9))
	plt.ylim(0, 40)
	plt.ylabel("Kill 2° bot")
	plt.xlabel("Game Speed")
	plt.boxplot([val[1] for key, val in statistics.items()], labels=[str(i + 1) + "x" for i in range(len(mean_time))])
	plt.savefig("kill2_speed.png", bbox_inches='tight', dpi = 200)
	plt.close()

	plt.figure(figsize=(16,9))
	plt.subplot(121)
	plt.title("Velocity 1x")
	plt.ylim(0, 40)
	plt.ylabel("Kill")
	plt.boxplot([val[0] for key, val in statistics.items() if key == 0] + [val[1] for key, val in statistics.items() if key == 0], labels=[str(i + 1)+"° Bot" for i in range(2)])
	plt.subplot(122)
	plt.title("Velocity 8x")
	plt.ylabel("Kill")
	plt.ylim(0, 40)
	plt.boxplot([val[0] for key, val in statistics.items() if key == 7] + [val[1] for key, val in statistics.items() if key == 7], labels=[str(i + 1)+"° Bot" for i in range(2)])
	plt.savefig("1vs8.png", bbox_inches='tight', dpi = 200)
	plt.close()

	plt.figure(figsize=(16, 9))
	plt.ylim(0, 1.5)
	plt.ylabel("Entropy")
	plt.xlabel("Game Speed")
	plt.boxplot([entropy(val[0], val[1], val[2], val[3]) for key, val in statistics.items()], labels=[str(i + 1) + "x" for i in range(len(mean_time))])
	plt.savefig("entropy_speed.png", bbox_inches='tight', dpi = 200)
	plt.close()
		

main()




