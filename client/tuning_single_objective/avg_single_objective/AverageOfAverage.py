from deap import base
from deap import creator
from deap import tools
from math import pow, log

import random
import matplotlib.pyplot as plt
import numpy
import pickle
import time
import threading

import os


creator.create("FitnessMax", base.Fitness, weights = (1.0, 1.0, 1.0, 1.0))
creator.create("Individual", list, fitness = creator.FitnessMax)

#initialization

toolbox = base.Toolbox()

toolbox.register("individual", tools.initCycle, creator.Individual, [lambda : 0 for _ in range(20)], n = 1)

toolbox.register("population", tools.initRepeat, list, toolbox.individual)

#num of final population
NUM_POPs = 10


NUM_POP = 100

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

        pop_file.write("fitness: " + "(" + str(ind.fitness.values[0]) + ",)" + "\n")
        pop_file.write("*********************************************************" + "\n")
    pop_file.write("\n" + "============================================================================================================" + "\n")

def getFitness(kills, dies):

	p = 0
	e = 0

	s = (dies[0] - kills[1]) + (dies[1] - kills[0])

	total = sum(kills)

	for d in kills:
	    p = d/total if total != 0 else 0
	    e += p*log(p, 2) if p != 0 else 0

	return -e, total/20, pow(9/10, s)


def getLogData(log_file) :
    content = log_file.readlines()

    kills = []
    dies = []
    result = []

    temp = {}

    for string in content:
        
        if "(" in string:
            split_spaces = string.split(" ")

            weap_index = int(split_spaces[0])

            if weap_index % 2 == 0:
                kill = split_spaces[2]
                kill = kill.replace("(", "")
                kill = kill.replace(",", "")
                kills += [int(kill)]

                die = split_spaces[3]
                die = die.replace("(", "")
                die = die.replace(",", "")
                dies += [float(die)]

            else :
                weap_index -= 1
                kill = split_spaces[2]
                kill = kill.replace("(", "")
                kill = kill.replace(",", "")
                kills += [int(kill)]

                die = split_spaces[3]
                die = die.replace("(", "")
                die = die.replace(",", "")
                dies += [int(die)]

                temp.update({int(weap_index/2) : getFitness(kills, dies) } )
                kills = []
                dies = []

        if "*" in string:
        	result += [temp]
        	temp = {}

    log_file.close()

    return result

def getPopulationData() :

	logbooks = []
	best_weapons = []
	pops = []

	os.chdir("..")

	for index in range(NUM_POPs):

		pop = toolbox.population(NUM_POP)

		logbook = tools.Logbook()

		stats1 = tools.Statistics(key = lambda ind: ind.fitness.values[0])

		stats1.register("avg", numpy.mean)
		stats1.register("std", numpy.std)
		stats1.register("min", numpy.min)
		stats1.register("max", numpy.max)

		stats2 = tools.Statistics(key = lambda ind: ind.fitness.values[1])

		stats2.register("avg", numpy.mean)
		stats2.register("std", numpy.std)
		stats2.register("min", numpy.min)
		stats2.register("max", numpy.max)

		stats3 = tools.Statistics(key = lambda ind: ind.fitness.values[2])

		stats3.register("avg", numpy.mean)
		stats3.register("std", numpy.std)
		stats3.register("min", numpy.min)
		stats3.register("max", numpy.max)

		stats4 = tools.Statistics(key = lambda ind: ind.fitness.values[3])

		stats4.register("avg", numpy.mean)
		stats4.register("std", numpy.std)
		stats4.register("min", numpy.min)
		stats4.register("max", numpy.max)


		mstats = tools.MultiStatistics(entropy = stats1, e = stats2, t = stats3, s = stats4)

		os.chdir("single_objective_100_pop_50_iter_simulated_binary_final_" + str(index + 1))

		pop_file = open("population.txt", "r")
		log_file = open("logbook.txt", "r")

		content = pop_file.readlines()

		temp = []

		index_pop = 0
		gen = 0
		bIsFirst = True
		fit = 0

		result_log = getLogData(log_file)

		for string in content:
			
			if "Weapon" in string or "Projectile" in string:
				split_spaces = string.split(" ")

				for splitted in split_spaces:
					if ":" in splitted:
						split_colon = splitted.split(":")
						temp += [float(split_colon[1])]
						if (len(temp) == 20):
							for i in range(20):
							    pop[index_pop][i] = temp[i]
							temp = []

			if "fitness" in string :
				split_spaces = string.split(" ")

				for splitted in split_spaces:
					if "(" in splitted and not bIsFirst:
						splitted = splitted.replace("(", "")
						splitted = splitted.replace(")", "")
						splitted = splitted.replace(",", "")
						splitted = splitted.replace("\n", "")
						fit = float(splitted)

				if not bIsFirst:
					try:
						log = result_log[gen][index_pop]
						pop[index_pop].fitness.values = fit, log[0], log[1], log[2]
					except :
						pop[index_pop].fitness.values = fit, pop[index_pop].fitness.values[1], pop[index_pop].fitness.values[2], pop[index_pop].fitness.values[3]

					if pop[index_pop].fitness.values[0] == 3 and gen == 49:
							best_weapons += [ pop[index_pop] ]

				index_pop += 1

				if index_pop == NUM_POP :

					if not bIsFirst :
						record = mstats.compile(pop)
						logbook.record(gen = gen, **record)
						gen += 1
					else :
						bIsFirst = False

					index_pop = 0


		pops += [pop]

		logbooks += [logbook]

		logbook.header = "gen", "entropy", "e", "s", "t"
		logbook.chapters["entropy"].header = "avg", "max"
		logbook.chapters["e"].header = "avg", "max"
		logbook.chapters["s"].header = "avg", "max"
		logbook.chapters["t"].header = "avg", "max"


		pop_file.close()

		os.chdir("..")

	return logbooks, best_weapons, pops


def plot_avg(gen, fit_avgs, e_avgs, t_avgs, s_avgs):

	fit_avg = numpy.mean(fit_avgs, axis = 0)
	fit_std = numpy.std(fit_avgs, axis = 0)

	e_avg = numpy.mean(e_avgs, axis = 0)
	e_std = numpy.std(e_avgs, axis = 0)

	t_avg = numpy.mean(t_avgs, axis = 0)
	t_std = numpy.std(t_avgs, axis = 0)

	s_avg = numpy.mean(s_avgs, axis = 0)
	s_std = numpy.std(s_avgs, axis = 0)


	plt.figure(figsize=(16, 9))

	plt.ylim(0, 3.5)

	plt.xlabel("Generation")
	plt.ylabel("Fitness")

	plt.errorbar(gen, fit_avg, yerr = fit_std, fmt='-o', label="fitness")
	plt.errorbar(gen, e_avg, yerr = e_std, fmt='-o', c = "r", label="entropy")
	plt.errorbar(gen, t_avg, yerr = t_std, fmt='-o', c = "g", label="score ratio")
	plt.errorbar(gen, s_avg, yerr = s_std, fmt='-o', c = "k", label="suicides")

	plt.legend()

	plt.savefig("avg_of_avg.png", bbox_inches='tight')

	plt.close()

def plot_max(gen, fit_avgs, e_avgs, t_avgs, s_avgs):

	fit_avg = numpy.mean(fit_avgs, axis = 0)
	fit_std = numpy.std(fit_avgs, axis = 0)

	e_avg = numpy.mean(e_avgs, axis = 0)
	e_std = numpy.std(e_avgs, axis = 0)

	t_avg = numpy.mean(t_avgs, axis = 0)
	t_std = numpy.std(t_avgs, axis = 0)

	s_avg = numpy.mean(s_avgs, axis = 0)
	s_std = numpy.std(s_avgs, axis = 0)

	plt.figure(figsize=(16, 9))

	plt.errorbar(gen, fit_avg, yerr = fit_std, fmt='-o', label="fitness")
	plt.errorbar(gen, e_avg, yerr = e_std, fmt='-o', c = "r", label="entropy")
	plt.errorbar(gen, t_avg, yerr = t_std, fmt='-o', c = "g", label="score ratio")
	plt.errorbar(gen, s_avg, yerr = s_std, fmt='-o', c = "k", label="suicides")

	plt.legend()

	plt.ylim(0, 3.5)

	plt.xlabel("Generation")
	plt.ylabel("Fitness")

	plt.savefig("avg_of_max.png", bbox_inches='tight')

	plt.close()


def  AverageOfAverage():

	avg_file = open("avg_of_avg.txt", "w")
	best_pop_file = open("population_cluster.txt", "w")
	population_file = open("population.txt", "w")

	fit_avgs = []

	fit_maxs = []

	logbooks = []
	best_weapons = []

	logbooks, best_weapons, pops = getPopulationData()

	final_population = []

	for i in range(len(pops)):
		final_population += pops[i]

	writeWeapon(final_population, population_file)

	population_file.close()

	gen = logbooks[0].select("gen")

	e_avg, t_avg, s_avg = [], [], []
	e_max, t_max, s_max = [], [], []

	for i in range(NUM_POPs):

		print(logbooks[i])

		fit_avgs += [logbooks[i].chapters["entropy"].select("avg")]

		fit_maxs += [logbooks[i].chapters["entropy"].select("max")]

		e_avg += [logbooks[i].chapters["e"].select("avg")]
		t_avg += [logbooks[i].chapters["t"].select("avg")]
		s_avg += [logbooks[i].chapters["s"].select("avg")]

		e_max += [logbooks[i].chapters["e"].select("max")]
		t_max += [logbooks[i].chapters["t"].select("max")]
		s_max += [logbooks[i].chapters["s"].select("max")]

	writeWeapon(best_weapons, best_pop_file)

	os.chdir("avg_single_objective")

	plot_avg(gen, fit_avgs, e_avg, t_avg, s_avg)

	plot_max(gen, fit_maxs, e_max, t_max, s_max)

	avg = numpy.mean(fit_avgs, axis = 0)
	std = numpy.std(fit_avgs, axis = 0)

	avg_file.write("Average:" + "\n")

	for i in range(len(avg)) :
		avg_file.write( "gen " + str(i) + " " + str(avg[i]) + "\n" )

	avg_file.write("Standard Deviation:" + "\n")

	for i in range(len(std)) :
		avg_file.write( "gen " + str(i) + " " + str(std[i]) + "\n" )

	avg_file.close()
	best_pop_file.close()



if __name__ == '__main__':
    AverageOfAverage()


