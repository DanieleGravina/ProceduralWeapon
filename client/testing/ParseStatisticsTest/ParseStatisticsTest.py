import numpy as np
import matplotlib.pyplot as plt
from math import log
from math import pow
from matplotlib.ticker import FuncFormatter
import matplotlib

def to_percent(y, position):
    # Ignore the passed in position. This has the effect of scaling the default
    # tick locations.
    s = str(100 * y)

    # The percent symbol needs escaping in latex
    if matplotlib.rcParams['text.usetex'] == True:
        return s + r'$\%$'
    else:
        return s + '%'

def entropy(kill1, kill2, die1, die2):
	e = []
	for i in range(len(kill1)):
		e += [eval_entropy(kill1[i], kill2[i], die1[i], die2[i])]
	return e 

def eval_entropy(kill_1, kill_2, die_1, die_2):
	kill1 = kill_1
	kill2 = kill_2
	total = kill1 + kill2

	e1 = kill1/total*log(kill1/total, 2) if kill1 != 0 else 0
	e2 = kill2/total*log(kill2/total,2) if kill2 != 0 else 0

	e = -(e1 + e2)

	#e += total/40
	#e += pow(0.9, suicides)

	return e

def main():

	statistics_file = open("statistics.txt", "r")

	content = statistics_file.readlines()

	i = 0

	statistics = {}
	data = [[] for _ in range(8)]

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
			if i == 8 :
				i = 0

	statistics.update({0 : data[:4]})
	statistics.update({1 : data[4:]})

	plt.figure(figsize=(16, 9))

	#plt.subplot(221)
	#plt.title("time kill")
	#plt.boxplot([val[0] for key, val in statistics.items()], labels=[str(i + 1) + "° weapon" for i in range(2)])
	plt.subplot(221)
	plt.title("distance")
	plt.ylabel("Unreal Unit")
	plt.boxplot([val[1] for key, val in statistics.items()], labels=[str(i + 1) + "° weapon" for i in range(2)])
	plt.subplot(222)
	plt.title("kill streak")
	plt.ylabel("Kill")
	plt.boxplot([val[2] for key, val in statistics.items()], labels=[str(i + 1) + "° weapon" for i in range(2)])
	plt.subplot(223)
	plt.title("precision")
	formatter = FuncFormatter(to_percent)
	plt.boxplot([val[3] for key, val in statistics.items()], labels=[str(i + 1) + "° weapon" for i in range(2)])
	plt.gca().yaxis.set_major_formatter(formatter)


	plt.savefig("statistics.png", bbox_inches='tight', dpi = 200)
	plt.close()

main()




