︠18fa7e2f-d3b0-4e8e-af9f-8d6e6cb568aasr︠
###############################################################################
# Computes best standard (t,r) broadcasts.                                    #
#                                                                             #
# (c) Tim Randolph 2017                                                       #
#                                                                             #
# This code is licensed under a Creative Commons Attribution 4.0 International#
# License (CC BY 4.0), which means you can share and adapt it as long as you  #
# credit the author. For more information, see                                #
# https://creativecommons.org/licenses/by/4.0                                 #
###############################################################################

import math

# Returns the (Manhattan) distance between two vertices on the infinite grid
def _dist(x1, y1, x2, y2):
	return abs(x1-x2) + abs(y1-y2)

# Returns the signal provided for a vertex v by a tower T
def _sig(t, vx, vy, Tx, Ty):
	return max(0, t - _dist(vx, vy, Tx, Ty))
	
# Returns a theoretical lower bound on the density of towers in 
# a standard (t,r) broadcast
def _getDMax(t,r):
	usable_signal = 0
	
	# Count 1 signal from each vertex v with sig(v,T) >=1
	# Count 2 signal from each vertex v with sig(v,T) >=2
	# ...
	# Count r signal from each vertex v with sig(v,T) >=r
	for t_rad in range(t, max(t-r,0), -1):
		usable_signal += _A(t_rad)

	return int(float(usable_signal) / r)

# Returns the number of vertices covered by a tower of signal strength t
def _A(t):
	return t*t + (t-1)*(t-1)
	
# Returns the minimum total signal at any vertex when towers in T(d,e) have
# signal strength t.
def _getMinSignalDepth(t, d, e):
	# Create the list of test vertices v_(0,0) ... v_(d-1,0) to be tested
	test_vertices = [0] * d
	
	# Sum the signal of all towers within a close window:
	# Test y values from -t+1 to t-1
	# Test x values from -t+1 to d+t-2
	for Ty in range(-t+1, t):
		for Tx in range(-t + 1, d+t-1):
		
			# Test if v_(x,y) \in T(d,e)
			# If so, account for signal.
			if ((Tx - e*Ty) % d == 0):
				# Increment signal recieved at each test vertex from tower
				for vx in range(0,d):
					test_vertices[vx] += _sig(t, vx, 0, Tx, Ty)
	return min(test_vertices)

# Given a t,r standard broadcast, test all standard patterns up to the 
# lower bound of density and return the standard broadcast of lowest density.
def getBestTRStandardBroadcast(t,r):
	d_opt = 0
	e_opt = 0

	for d in range(1, _getDMax(t,r) + 1):
		for e in range(d-1, -1, -1):
			if _getMinSignalDepth(t,d,e) >= r:
				d_opt = d
				e_opt = e
				
	print "Best standard ("+str(t)+", "+str(r)+") broadcast is",
	print "T("+str(d_opt)+","+str(e_opt)+"). (Density 1/"+str(d_opt)+")"

###############################################################################
# Call methods from here                                                      #
###############################################################################
%time
for t in range(1, 11):
    for r in range(1, t+1):
        getBestTRStandardBroadcast(t,r)
︡b0d26960-3b3d-40a8-94d5-72f177f682a3︡{"stdout":"Best standard (1, 1) broadcast is T(1,0). (Density 1/1)\nBest standard (2, 1) broadcast is T(5,2). (Density 1/5)\nBest standard (2, 2) broadcast is T(3,1). (Density 1/3)\nBest standard (3, 1) broadcast is T(13,5). (Density 1/13)\nBest standard (3, 2) broadcast is T(8,3). (Density 1/8)\nBest standard (3, 3) broadcast is T(5,1). (Density 1/5)\nBest standard (4, 1) broadcast is"}︡{"stdout":" T(25,7). (Density 1/25)\nBest standard (4, 2) broadcast is T(18,5). (Density 1/18)\nBest standard (4, 3) broadcast is"}︡{"stdout":" T(13,5). (Density 1/13)\nBest standard (4, 4) broadcast is T(10,3). (Density 1/10)\nBest standard (5, 1) broadcast is"}︡{"stdout":" T(41,9). (Density 1/41)\nBest standard (5, 2) broadcast is"}︡{"stdout":" T(32,7). (Density 1/32)\nBest standard (5, 3) broadcast is"}︡{"stdout":" T(25,7). (Density 1/25)\nBest standard (5, 4) broadcast is"}︡{"stdout":" T(18,4). (Density 1/18)\nBest standard (5, 5) broadcast is T(14,4). (Density 1/14)\nBest standard (6, 1) broadcast is"}︡{"stdout":" T(61,11). (Density 1/61)\nBest standard (6, 2) broadcast is"}︡{"stdout":" T(50,9). (Density 1/50)\nBest standard (6, 3) broadcast is"}︡{"stdout":" T(41,9). (Density 1/41)\nBest standard (6, 4) broadcast is"}︡{"stdout":" T(34,13). (Density 1/34)\nBest standard (6, 5) broadcast is"}︡{"stdout":" T(26,10). (Density 1/26)\nBest standard (6, 6) broadcast is"}︡{"stdout":" T(22,5). (Density 1/22)\nBest standard (7, 1) broadcast is"}︡{"stdout":" T(85,13). (Density 1/85)\nBest standard (7, 2) broadcast is"}︡{"stdout":" T(72,11). (Density 1/72)\nBest standard (7, 3) broadcast is"}︡{"stdout":" T(61,11). (Density 1/61)\nBest standard (7, 4) broadcast is"}︡{"stdout":" T(50,9). (Density 1/50)\nBest standard (7, 5) broadcast is"}︡{"stdout":" T(42,16). (Density 1/42)\nBest standard (7, 6) broadcast is"}︡{"stdout":" T(36,15). (Density 1/36)\nBest standard (7, 7) broadcast is"}︡{"stdout":" T(29,12). (Density 1/29)\nBest standard (8, 1) broadcast is"}︡{"stdout":" T(113,15). (Density 1/113)\nBest standard (8, 2) broadcast is"}︡{"stdout":" T(98,13). (Density 1/98)\nBest standard (8, 3) broadcast is"}︡{"stdout":" T(85,13). (Density 1/85)\nBest standard (8, 4) broadcast is"}︡{"stdout":" T(74,31). (Density 1/74)\nBest standard (8, 5) broadcast is"}︡{"stdout":" T(62,26). (Density 1/62)\nBest standard (8, 6) broadcast is"}︡{"stdout":" T(54,15). (Density 1/54)\nBest standard (8, 7) broadcast is"}︡{"stdout":" T(43,12). (Density 1/43)\nBest standard (8, 8) broadcast is"}︡{"stdout":" T(39,16). (Density 1/39)\nBest standard (9, 1) broadcast is"}︡{"stdout":" T(145,17). (Density 1/145)\nBest standard (9, 2) broadcast is"}︡{"stdout":" T(128,15). (Density 1/128)\nBest standard (9, 3) broadcast is"}︡{"stdout":" T(113,15). (Density 1/113)\nBest standard (9, 4) broadcast is"}︡{"stdout":" T(98,13). (Density 1/98)\nBest standard (9, 5) broadcast is"}︡{"stdout":" T(86,36). (Density 1/86)\nBest standard (9, 6) broadcast is"}︡{"stdout":" T(76,21). (Density 1/76)\nBest standard (9, 7) broadcast is"}︡{"stdout":" T(65,18). (Density 1/65)\nBest standard (9, 8) broadcast is"}︡{"stdout":" T(58,17). (Density 1/58)\nBest standard (9, 9) broadcast is"}
︠edfa2cfc-fcea-43a0-add8-c8cd75eb1742s︠

###############################################################################
#                                                                             #
# (c) Tom Shlomi 2019                                                         #
#                                                                             #
# This code is licensed under a Creative Commons Attribution 4.0 International#
# License (CC BY 4.0), which means you can share and adapt it as long as you  #
# credit the author. For more information, see                                #
# https://creativecommons.org/licenses/by/4.0                                 #
###############################################################################


def MinDensity(t,r):
    d=floor(2*r^2/3-2*r*t+2*t^2+1/3)
    while d>=0:
        e=1
        while e<d:
            if IsBroadcast(t,r,d,e):
                return d
            e=e+1
        d=d-1
def IsBroadcast(t,r,d,e):
    a=[]
    for i in range(d):
        a.append(0)
    for i in range(t):
        a[i]=t-i
        a[-i]=t-i
    #print a,d,e, len(a)
    for i in range(t-r+1,d/2+1):
        rcpt=a[i]
        for j in range(1,t):
            m1=(i+j*e)%d
            #print 'm1',m1
            if a[m1] > j:
                rcpt += a[m1]-j
            m2= (i-j*e) % d
            #print 'm2',m2
            if a[m2] > j:
                rcpt += a[m2]-j
        if rcpt < r:
            #print rcpt, i,
            return False
    return True
︡9ed04144-217e-4975-965d-4215b3672899︡{"done":true}
︠43e9268c-6efc-4dcd-92e0-9eb373283113s︠
%time
for t in range(1, 11):
    for r in range(1, t+1):
        MinDensity(t,r)
︡50867e47-dde8-4c9e-bde9-8ef70a731217︡{"stdout":"5\n3\n13\n8\n5\n25\n18\n13\n10\n41\n32\n25\n18\n14\n61\n50\n41\n34\n26\n22\n85\n72\n61\n50\n42\n36\n29\n113"}︡{"stdout":"\n98\n85\n74\n62\n54"}︡{"stdout":"\n43\n39\n145\n128"}︡{"stdout":"\n113\n98\n86"}︡{"stdout":"\n76\n65\n58"}︡{"stdout":"\n49\n181\n162"}︡{"stdout":"\n145\n130\n114"}︡{"stdout":"\n102\n89"}︡{"stdout":"\n78"}︡{"stdout":"\n68\n62"}︡{"stdout":"\n"}︡{"stdout":"\nCPU time: 1.20 s, Wall time: 1.23 s\n"}︡{"done":true}
︠810f1f96-74bf-4482-884d-68b4c67cd887︠













