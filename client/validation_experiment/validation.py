import numpy as np
import matplotlib.pyplot as plt
from matplotlib.ticker import FuncFormatter

import matplotlib

file1 = "convalidation_data_2.txt"

def to_percent(y, position):
    # Ignore the passed in position. This has the effect of scaling the default
    # tick locations.
    s = str(100 * y)

    # The percent symbol needs escaping in latex
    if matplotlib.rcParams['text.usetex'] == True:
        return s + r'$\%$'
    else:
        return s + '%'

def main() :

	data = open(file1, "r")

	content = data.readlines()

	conoscenza = []
	preferenza = []
	div_blu = []
	eq_blu = []
	div_rossa = []
	eq_rossa = []

	for line in content:
		if "conoscenza" in line:
			split_space = line.split(" ")
			stats = split_space[2]
			stats = stats.replace("[", "")
			stats = stats.replace("]", "")
			stats = stats.replace("\n", "")
			split_num = stats.split(",")
			for num in split_num:
				conoscenza += [int(num)]

		if "preferenza" in line:
			split_space = line.split(" ")
			stats = split_space[2]
			stats = stats.replace("[", "")
			stats = stats.replace("]", "")
			stats = stats.replace("\n", "")
			split_num = stats.split(",")
			for num in split_num:
				preferenza += [int(num)]

		if "div_blu" in line:
			split_space = line.split(" ")
			stats = split_space[2]
			stats = stats.replace("[", "")
			stats = stats.replace("]", "")
			stats = stats.replace("\n", "")
			print(stats)
			split_num = stats.split(",")
			for num in split_num:
				div_blu += [int(num)]

		if "eq_blu" in line:
			split_space = line.split(" ")
			stats = split_space[2]
			stats = stats.replace("[", "")
			stats = stats.replace("]", "")
			stats = stats.replace("\n", "")
			split_num = stats.split(",")
			for num in split_num:
				eq_blu += [int(num)]

		if "div_rossa" in line:
			split_space = line.split(" ")
			stats = split_space[2]
			stats = stats.replace("[", "")
			stats = stats.replace("]", "")
			stats = stats.replace("\n", "")
			split_num = stats.split(",")
			for num in split_num:
				div_rossa += [int(num)]

		if "eq_rossa" in line:
			split_space = line.split(" ")
			stats = split_space[2]
			stats = stats.replace("[", "")
			stats = stats.replace("]", "")
			stats = stats.replace("\n", "")
			split_num = stats.split(",")
			for num in split_num:
				eq_rossa += [int(num)]

	c_low = 0
	c_med = 0
	c_high = 0

	for i in conoscenza :
		if i == 1:
			c_low += 1
		elif i == 2:
			c_med += 1
		else :
			c_high += 1
	print("conoscenza")
	print(c_low/len(conoscenza)*100)
	print(c_med/len(conoscenza)*100)
	print(c_high/len(conoscenza)*100)

	p_red = 0
	p_blue = 0

	for i in preferenza :
		if i == 1:
			p_red += 1
		else:
			p_blue += 1

	print("preferenza")
	print(p_red/len(preferenza)*100)
	print(p_blue/len(preferenza)*100)

	ind = np.arange(2)  # the x locations for the groups
	width = 0.35       # the width of the bars

	fig = plt.figure(figsize=(16, 9))
	formatter = FuncFormatter(to_percent)
	ax = fig.add_subplot(2, 3, 1)
	ax.set_title("Weapon Preference")
	plt.ylim(0, 1)
	rects1 = ax.bar([0], p_red/len(preferenza), width, color='r', align="center")
	rects2 = ax.bar([1], p_blue/len(preferenza), width, color='b', align="center")
	ax.set_xticks(ind)
	ax.set_xticklabels( ('Weapon Red', 'Weapon Blue') )
	plt.gca().yaxis.set_major_formatter(formatter)

	c_low = 0
	c_med = 0
	c_high = 0

	for i in div_blu :
		if i == 1:
			c_low += 1
		elif i == 2:
			c_med += 1
		else :
			c_high += 1
	print("div_blu")
	print(c_low/len(conoscenza)*100)
	print(c_med/len(conoscenza)*100)
	print(c_high/len(conoscenza)*100)

	ind = np.arange(3)  # the x locations for the groups
	width = 0.35       # the width of the bars

	formatter = FuncFormatter(to_percent)
	ax = fig.add_subplot(2, 3, 2)
	ax.set_title("Weapon Blue enjoyment")
	plt.ylim(0, 1)
	rects1 = ax.bar([0], c_low/len(preferenza), width, color='b', align="center")
	rects2 = ax.bar([1], c_med/len(preferenza), width, color='b', align="center")
	rects2 = ax.bar([2], c_high/len(preferenza), width, color='b', align="center")

	ax.set_xticks(ind)
	ax.set_xticklabels( ('Low', 'Medium', 'High'))
	plt.gca().yaxis.set_major_formatter(formatter)

	c_low = 0
	c_med = 0
	c_high = 0

	for i in eq_blu :
		if i == 1:
			c_low += 1
		elif i == 2:
			c_med += 1
		else :
			c_high += 1
	print("eq_blu")
	print(c_low/len(conoscenza)*100)
	print(c_med/len(conoscenza)*100)
	print(c_high/len(conoscenza)*100)

	ind = np.arange(3)  # the x locations for the groups
	width = 0.35       # the width of the bars

	formatter = FuncFormatter(to_percent)
	ax = fig.add_subplot(2, 3, 3)
	ax.set_title("Weapon Blue balance")
	plt.ylim(0, 1)
	rects1 = ax.bar([0], c_low/len(preferenza), width, color='b', align="center")
	rects2 = ax.bar([1], c_med/len(preferenza), width, color='b', align="center")
	rects2 = ax.bar([2], c_high/len(preferenza), width, color='b', align="center")

	ax.set_xticks(ind)
	ax.set_xticklabels( ('disadvant.', 'balanced', 'advant.'))
	plt.gca().yaxis.set_major_formatter(formatter)

	c_low = 0
	c_med = 0
	c_high = 0

	for i in div_rossa :
		if i == 1:
			c_low += 1
		elif i == 2:
			c_med += 1
		else :
			c_high += 1
	print("div_rossa")
	print(c_low/len(conoscenza)*100)
	print(c_med/len(conoscenza)*100)
	print(c_high/len(conoscenza)*100)

	ind = np.arange(3)  # the x locations for the groups
	width = 0.35       # the width of the bars

	formatter = FuncFormatter(to_percent)
	ax = fig.add_subplot(2, 3, 5)
	ax.set_title("Weapon Red enjoyment")
	plt.ylim(0, 1)
	rects1 = ax.bar([0], c_low/len(preferenza), width, color='r', align="center")
	rects2 = ax.bar([1], c_med/len(preferenza), width, color='r', align="center")
	rects2 = ax.bar([2], c_high/len(preferenza), width, color='r', align="center")

	ax.set_xticks(ind)
	ax.set_xticklabels( ('Low', 'Medium', 'High'))
	plt.gca().yaxis.set_major_formatter(formatter)


	c_low = 0
	c_med = 0
	c_high = 0

	for i in eq_rossa :
		if i == 1:
			c_low += 1
		elif i == 2:
			c_med += 1
		else :
			c_high += 1
	print("eq_rossa")
	print(c_low/len(conoscenza)*100)
	print(c_med/len(conoscenza)*100)
	print(c_high/len(conoscenza)*100)

	ind = np.arange(3)  # the x locations for the groups
	width = 0.35       # the width of the bars

	formatter = FuncFormatter(to_percent)
	ax = fig.add_subplot(2, 3, 6)
	ax.set_title("Weapon Red balance")
	plt.ylim(0, 1)
	rects1 = ax.bar([0], c_low/len(preferenza), width, color='r', align="center")
	rects2 = ax.bar([1], c_med/len(preferenza), width, color='r', align="center")
	rects2 = ax.bar([2], c_high/len(preferenza), width, color='r', align="center")

	ax.set_xticks(ind)
	ax.set_xticklabels( ('disadvant.', 'balanced', 'advant.'))
	plt.gca().yaxis.set_major_formatter(formatter)

	plt.savefig("validation_2.png", bbox_inches='tight', dpi = 200)
	plt.close()

main()




