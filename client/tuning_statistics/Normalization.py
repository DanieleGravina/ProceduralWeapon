import math

def normalize(v, min, max):

    return [ (v[i] - min)/(max - min)  for i in range(len(v)) ]