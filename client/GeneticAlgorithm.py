import random
from BalancedWeaponClient import BalancedWeaponClient

from deap import base
from deap import creator
from deap import tools

creator.create("FitnessMax", base.Fitness, weights=(1.0,))
creator.create("Individual", list, fitness=creator.FitnessMax)

#initialization

toolbox = base.Toolbox()

messageWeapon = ':WeaponPar:Rof:0.1:Spread:0.5:MaxAmmo:40:ShotCost:1:Range:10000'

WEIGHT = 1000

#default Rof = 1.0
ROF_MIN, ROF_MAX = 1, 500
#default Spread = 0
SPREAD_MIN, SPREAD_MAX = 0, 50
#default MaxAmmo = 40
AMMO_MIN, AMMO_MAX = 1, 1000
#deafult ShotCost = 1
SHOT_COST_MIN, SHOT_COST_MAX = 1, 10
#defualt Range 10000
RANGE_MIN, RANGE_MAX = 100, 100000

N_CYCLES = 1

toolbox.register("attr_rof", random.randint, ROF_MIN, ROF_MAX)
toolbox.register("attr_spread", random.randint, SPREAD_MIN, SPREAD_MAX)
toolbox.register("attr_ammo", random.randint, AMMO_MIN, AMMO_MAX)
toolbox.register("attr_shot_cost", random.randint, SHOT_COST_MIN, SHOT_COST_MAX)
toolbox.register("attr_range", random.randint, RANGE_MIN, RANGE_MAX)

toolbox.register("individual", tools.initCycle, creator.Individual,
                 (toolbox.attr_rof, toolbox.attr_spread, toolbox.attr_ammo, 
                    toolbox.attr_shot_cost, toolbox.attr_range), n = N_CYCLES)

toolbox.register("population", tools.initRepeat, list, toolbox.individual)

def difference_from_population(individual, population):
    sum = 0
    pop = [x for x in population if x != individual]

    for l in pop :
        for i in range(0, len(l)):
            sum += abs(individual[i] - l[i])


    return sum/len(population)

def difference_statics(index, statics):
    sum = 0

    for i in range(0, len(statics)):
        if i != index :
            sum += abs(statics[index][0] - statics[i][0]) + abs(statics[index][1] - statics[i][1])

    return sum*WEIGHT/len(statics)

def evaluate_population(population) :
    client = BalancedWeaponClient()
    client.SendInit()

    for i in range (0, 8):
        client.SendWeaponParams(i, population[i][0], population[i][1], population[i][2], population[i][3], population[i][4])

    for i in range (0, 8):
        client.SendProjectileParams(1000, 5, 10, 1)

    client.SendStartMatch()

    client.WaitForBotStatics()

    return client.GetStatics()


def evaluate(index, population, statics):
    return difference_from_population(population[index], population) + difference_statics(index, statics)


toolbox.register("mate", tools.cxTwoPoint)
toolbox.register("mutate", tools.mutGaussian, mu = 0, sigma = 1, indpb = 0.1)
toolbox.register("select", tools.selTournament, tournsize = 3)
toolbox.register("evaluate", evaluate)

def main():

    pop = toolbox.population(n = 8)
    CXPB, MUTPB, NGEN = 0.5, 0.2, 1

    fitnesses = []

    print(pop)

    statics = evaluate_population(pop)

    # Evaluate the entire population
    for i in range(len(pop)) :
        fitnesses += [toolbox.evaluate(i, pop, statics)]

    print(fitnesses)

    for ind, fit in zip(pop, fitnesses):
        ind.fitness.values = fit

    for g in range(NGEN):
        # Select the next generation individuals
        offspring = toolbox.select(pop, len(pop))
        # Clone the selected individuals
        offspring = list(map(toolbox.clone, offspring))

        # Apply crossover and mutation on the offspring
        for child1, child2 in zip(offspring[::2], offspring[1::2]):
            if random.random() < CXPB:
                toolbox.mate(child1, child2)
                del child1.fitness.values
                del child2.fitness.values

        for mutant in offspring:
            if random.random() < MUTPB:
                toolbox.mutate(mutant)
                del mutant.fitness.values

        # Evaluate the individuals with an invalid fitness
        invalid_ind = [ind for ind in offspring if not ind.fitness.valid]

        for i in range(len(invalid_ind)) :
            fitnesses += [toolbox.evaluate(i, invalid_ind, statics)]

        for ind, fit in zip(invalid_ind, fitnesses):
            ind.fitness.values = fit

        # The population is entirely replaced by the offspring
        pop[:] = offspring

    print(pop)

main()