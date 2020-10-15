#Cleaning functions:

#Convert y/n flag values into 0 and 1

def flag1(x):
    if x == 'N':
        return 0
    elif x == 'Y':
        return 1
    else:
        return x

Y_N_dictionary= {'Y':1,
                 'N':0}

#Convert sex flag values into 0 and 1

def flag2(x):
    if x == 'M':
        return 0
    elif x == 'F':
        return 1
    else:
        return x

M_F_dictionary= {'M':0,
                 'F':1}

#Clean years_employed

def cleanyears(x):
    if x == -1000:
        return 0
    else:
        return x