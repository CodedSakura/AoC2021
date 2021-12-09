with open("input.txt") as f:
    data = [[int(i) for i in h] for h in f.read().strip().split("\n")]

w = len(data[0])
h = len(data)
def neighbours(x, y):
    if x > 0: yield (x-1, y)
    if y > 0: yield (x, y-1)
    if x < w-1: yield (x+1, y)
    if y < h-1: yield (x, y+1)

basinStarts = []
for y in range(len(data)):
    for x in range(len(data[y])):
        if data[y][x] < min([data[yn][xn] for (xn, yn) in neighbours(x, y)]):
            basinStarts.append((x, y))

basinSizes = []
for (x, y) in basinStarts:
    counter = 1
    pCounter = 0
    basin = [[(x, y)]]
    flatBasin = [(x, y)]
    while counter != pCounter:
        pCounter = counter
        basinCont = set([g for b in basin[-1] for g in [n for n in neighbours(b[0], b[1]) if n not in flatBasin and data[n[1]][n[0]] != 9]])
        flatBasin += basinCont
        basin.append(basinCont)
        counter += len(basinCont)
    basinSizes.append(counter)
    # print("\n".join(["".join(["x" if (x, y) in flatBasin else "-" for x in range(w)]) for y in range(h)]))
prod = 1
for i in sorted(basinSizes)[-3:]:
    prod *= i
print(prod)
