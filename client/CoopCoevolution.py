import random
import matplotlib.pyplot as plt
import numpy
import pickle
import time

from functools import partial
from operator import attrgetter

from Costants import NUM_BOTS
from Costants import NUM_SERVER
from Costants import PORT

from BalancedWeaponClient import BalancedWeaponClient
from ClientThread import myThread

from math import log

from deap import base
from deap import creator
from deap import tools


WEIGHT = 100

###############
# Weapon ######
###############

#default Rof = 100
ROF_MIN, ROF_MAX = 1, 1000
#default Spread = 0
SPREAD_MIN, SPREAD_MAX = 0, 100
#default MaxAmmo = 40
AMMO_MIN, AMMO_MAX = 10, 1000
#deafult ShotCost = 1
SHOT_COST_MIN, SHOT_COST_MAX = 1, 10
#defualt Range 10000
RANGE_MIN, RANGE_MAX = 1, 100000

###################
# Projectile ######
###################

#default speed = 1000
SPEED_MIN, SPEED_MAX = 1, 10000
#default damage = 1
DMG_MIN, DMG_MAX = 1, 100
#default damgae radius = 10
DMG_RAD_MIN, DMG_RAD_MAX = 1, 100
#default gravity = 1
GRAVITY_MIN, GRAVITY_MAX = 1, 100

limits = [(ROF_MIN, ROF_MAX), (SPREAD_MIN, SPREAD_MAX), (AMMO_MIN, AMMO_MAX), (SHOT_COST_MIN, SHOT_COST_MAX), (RANGE_MIN, RANGE_MAX),
          (SPEED_MIN, SPEED_MAX), (DMG_MIN, DMG_MAX), (DMG_RAD_MIN, DMG_RAD_MAX), (GRAVITY_MIN, GRAVITY_MAX)]

def create_species():

    return list(toolbox.Rof, toolbox.Spread, toolbox.Ammo, toolbox.ShotCost, toolbox.Range, 
                toolbox.Speed, toolbox.Damage, toolbox.DamageRadius, toolbox.Gravity)



N_CYCLES = 10
# size of the population
NUM_POP = NUM_BOTS*NUM_SERVER

creator.create("FitnessMax", base.Fitness, weights=(1.0,))
creator.create("Individual", list, fitness=creator.FitnessMax)

toolbox = base.Toolbox()

toolbox.register("attr_rof", random.randint, ROF_MIN, ROF_MAX)
toolbox.register("attr_spread", random.randint, SPREAD_MIN, SPREAD_MAX)
toolbox.register("attr_ammo", random.randint, AMMO_MIN, AMMO_MAX)
toolbox.register("attr_shot_cost", random.randint, SHOT_COST_MIN, SHOT_COST_MAX)
toolbox.register("attr_range", random.randint, RANGE_MIN, RANGE_MAX)

toolbox.register("attr_speed", random.randint, SPEED_MIN, SPEED_MAX)
toolbox.register("attr_dmg", random.randint, DMG_MIN, DMG_MAX)
toolbox.register("attr_dmg_rad", random.randint, DMG_RAD_MIN, DMG_RAD_MAX)
toolbox.register("attr_gravity", random.randint, GRAVITY_MIN, GRAVITY_MAX)

toolbox.register("Rof", tools.initCycle, creator.Individual,
                  toolbox.attr_rof, n = N_CYCLES)

toolbox.register("Spread", tools.initCycle, creator.Individual,
                  toolbox.attr_spread, n = N_CYCLES)

toolbox.register("Ammo", tools.initCycle, creator.Individual,
                  toolbox.attr_ammo, n = N_CYCLES)

toolbox.register("ShotCost", tools.initCycle, creator.Individual,
                  toolbox.attr_shot_cost, n = N_CYCLES)

toolbox.register("Range", tools.initCycle, creator.Individual,
                  toolbox.attr_range, n = N_CYCLES)

toolbox.register("Speed", tools.initCycle, creator.Individual,
                  toolbox.attr_speed, n = N_CYCLES)

toolbox.register("Damage", tools.initCycle, creator.Individual,
                  toolbox.attr_dmg, n = N_CYCLES)

toolbox.register("DamageRadius", tools.initCycle, creator.Individual,
                  toolbox.attr_dmg_rad, n = N_CYCLES)

toolbox.register("Gravity", tools.initCycle, creator.Individual,
                  toolbox.attr_gravity , n = N_CYCLES)

toolbox.register("species", create_species)


def printWeapon(pop):
    for ind in pop :
        print("Weapon "+ " Rof:" + str(ind[0]/100) + " Spread:" + str(ind[1]/10) + " MaxAmmo:" + str(ind[2]) 
            + " ShotCost:" + str(ind[3]) + " Range:" + str(ind[4]) )
        print("Projectile "+ " Speed:" + str(ind[5]) + " Damage:" + str(ind[6]) + " DamageRadius:" + str(ind[7])
            + " Gravity:" + str(ind[8]) )
        print("fitness: " + str(ind.fitness.values))
        print("*********************************************************")

def writeWeapon(pop, pop_file):
    for ind in pop :
        pop_file.write("Weapon "+ " Rof:" + str(ind[0]/100) + " Spread:" + str(ind[1]/10) + " MaxAmmo:" + str(ind[2]) 
            + " ShotCost:" + str(ind[3]) + " Range:" + str(ind[4]) + "\n")
        pop_file.write("Projectile "+ " Speed:" + str(ind[5]) + " Damage:" + str(ind[6]) + " DamageRadius:" + str(ind[7])
            + " Gravity:" + str(ind[8]) +"\n")
        pop_file.write("fitness: " + str(ind.fitness.values)+"\n")
        pop_file.write("*********************************************************" + "\n")

def selRoulette(individuals, k):

    for ind in individuals:
        fit = ind.fitness.values[0]
        fit += 1
        del ind.fitness.values
        ind.fitness.values = fit, 

    s_inds = sorted(individuals, key=attrgetter("fitness"), reverse=True)
    sum_fits = sum(ind.fitness.values[0] for ind in individuals)
    
    chosen = []
    for i in range(k):
        u = random.random() * sum_fits
        sum_ = 0
        for ind in s_inds:
            sum_ += ind.fitness.values[0]
            if sum_ > u:
                chosen.append(ind)
                break

    for ind in individuals:
        fit = ind.fitness.values[0]
        fit -= 1
        del ind.fitness.values
        ind.fitness.values = fit,
    
    return chosen


def check_param(param, min, max):
    if param < min :
        param = min
    elif param > max :
        param = max

def check(param, n) :

    check_param(param, limits[n][0], limits[n][1])

def checkBounds(min, max):
    def decorator(func):
        def wrapper(*args, **kargs):
            offspring = func(*args, **kargs)
            for child in offspring:
                for i in range(len(child)):
                    check(child[i], i)
            return offspring
        return wrapper
    return decorator

def initialize_server():
    clients = []

    for i in range(NUM_SERVER):
        clients.append(BalancedWeaponClient(PORT[i]))

    for c in clients :
        c.SendInit()
        c.SendStartMatch()
        c.SendClose()

# Run the simulation on the server side (UDK)
def simulate_population(population, statics) :

    stats = {}
    threads = []

    for i in range(NUM_SERVER):
        threads.append( myThread(i*2, "Thread-" + str(i), population, statics, PORT[i]) )

    for t in threads:
        t.start()

    # Wait for all threads to complete
    for t in threads:
        stats.update(t.join())

    return stats

def entropy(index, statics) :

    e = 0

    total_kills = 0
    total_dies = 0

    ind = index if index % 2 == 0 else index - 1

    for key, val in statics.items():
        if key >= ind and key < ind + NUM_BOTS :
            total_kills += val[0]
            total_dies += val[1]

    for i in range(ind, ind + NUM_BOTS):
        e += evaluate_entropy(i, statics, total_kills, total_dies, NUM_BOTS)

    return e


def evaluate_entropy(index, statics, total_kills, total_dies, N) :

    p_kills = 0  if total_kills == 0 else statics[index][0]/total_kills
    p_dies = 0 if total_dies == 0 else statics[index][1]/total_dies

    entropy_kill = p_kills*log(p_kills, N) if p_kills != 0 else 0

    entropy_dies = p_dies*log(p_dies, N) if p_dies != 0 else 0

    return -(entropy_kill + entropy_dies)

# ATTENTION, you MUST return a tuple
def evaluate(index, population, statics):
    e = entropy(index, statics)
    print('entropy :' + str(index) + " " + str(e))
    return e,


toolbox.register("mate", tools.cxTwoPoint)

toolbox.register("mutate", tools.mutUniformInt, low = 0,
                                                up  = 1000, 
                                                indpb = 0.1)

toolbox.register("select", tools.selTournament, tournsize=2)
toolbox.register("get_best", tools.selBest, k=1)

toolbox.decorate("mate", checkBounds(0,1))
toolbox.decorate("mutate", checkBounds(0,1))

toolbox.register("evaluate", evaluate)

stats = tools.Statistics(key=lambda ind: ind.fitness.values)

stats.register("avg", numpy.mean)
stats.register("std", numpy.std)
stats.register("min", numpy.min)
stats.register("max", numpy.max)

logbook = tools.Logbook()

def main(extended=True, verbose=True):
    target_set = []
    
    stats = tools.Statistics(lambda ind: ind.fitness.values)
    stats.register("avg", numpy.mean)
    stats.register("std", numpy.std)
    stats.register("min", numpy.min)
    stats.register("max", numpy.max)
    
    logbook = tools.Logbook()
    logbook.header = "gen", "species", "evals", "std", "min", "avg", "max"
    
    ngen = 10
    g = 0
    
    for i in range(len(schematas)):
        size = int(TARGET_SIZE/len(schematas))
        target_set.extend(toolbox.target_set(schematas[i], size))
    
    species = toolbox.species()
    
    # Init with random a representative for each species
    representatives = [random.choice(s) for s in species]
    
    while g < ngen:
        # Initialize a container for the next generation representatives
        next_repr = [None] * len(species)
        for i, s in enumerate(species):
            # Vary the species individuals
            s = algorithms.varAnd(s, toolbox, 0.6, 1.0)
            
            # Get the representatives excluding the current species
            r = representatives[:i] + representatives[i+1:]
            for ind in s:
                ind.fitness.values = toolbox.evaluate([ind] + r, target_set)
                
            record = stats.compile(s)
            logbook.record(gen=g, species=i, evals=len(s), **record)
            
            if verbose: 
                print(logbook.stream)
            
            # Select the individuals
            species[i] = toolbox.select(s, len(s))  # Tournament selection
            next_repr[i] = toolbox.get_best(s)[0]   # Best selection
        
            g += 1
            
            if plt and extended:
                # Compute the match strength without noise for the
                # representatives on the three schematas
                t1.append(toolbox.evaluate_nonoise(representatives,
                    toolbox.target_set(schematas[0], 1), noise)[0])
                t2.append(toolbox.evaluate_nonoise(representatives,
                    toolbox.target_set(schematas[1], 1), noise)[0])
                t3.append(toolbox.evaluate_nonoise(representatives,
                    toolbox.target_set(schematas[2], 1), noise)[0])
            
        representatives = next_repr
    if extended:
        for r in representatives:
            # print individuals without noise
            print("".join(str(x) for x, y in zip(r, noise) if y == "*"))
    
    if plt and extended:
        # Do the final plotting
        plt.plot(t1, '-', color="k", label="Target 1")
        plt.plot(t2, '--', color="k", label="Target 2")
        plt.plot(t3, ':', color="k", label="Target 3")
        plt.legend(loc="lower right")
        plt.axis([0, ngen, 0, max(max(t1), max(t2), max(t3)) + 1])
        plt.xlabel("Generations")
        plt.ylabel("Number of matched bits")
        plt.show()
    
if __name__ == "__main__":
    main()



