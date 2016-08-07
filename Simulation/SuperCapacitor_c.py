# -*- coding: utf-8 -*-

import numpy as np
import math

class SuperCapacitor_c:
    """ Class containing model of Super Capacitor """
    
    #Constants
    
    #Variable arrays
    
    #equations
    
        
    def __init__(self,SimulationTime,TimeInterval):
        #class constructor
        print('Super Capacitor Object Created')
        
        #Allocate RAM
        DataPoints = math.floor(SimulationTime/TimeInterval)    