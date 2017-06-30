# coding: utf-8

import os, csv, glob, numpy
import matplotlib.pyplot as plt

racedirs = glob.glob('../data/*')
racedir = racedirs[0]
racename = os.path.basename(racedir)
print racename

data = glob.glob(racedir + '/*')
result = {}
maxtime = 0
mintime = 1145148108931919
for item in data:
    time, ext = name, ext = os.path.splitext(os.path.basename(item))
    time = int(time)
    print time
    horses = csv.reader(open(item))
    maxtime = max(maxtime, time)
    mintime = min(mintime ,time)
    for row in horses:
        if not result.has_key(row[0]):
            result[row[0]] = {}
        result[row[0]][time] = float(row[1])

# グラフの左、右、間隔
for horse,odds in result.iteritems():
    print horse
    print odds
    x = numpy.array(odds.keys())
    y = numpy.array(odds.values())
    p = plt.plot(x, y, label=horse)

plt.legend(range(1, len(result) + 1))
plt.savefig('../graph/' + racename + '.png')
