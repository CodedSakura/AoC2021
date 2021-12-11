with open("input.txt") as f:
    data = [[int(x) for x in b] for b in f.read().strip().split("\n")]

w = len(data[0])
h = len(data)

def neighbours(x, y):
    if x > 0:
        if y > 0: yield (x-1, y-1)
        yield (x-1, y)
        if y < h-1: yield (x-1, y+1)
    if y > 0: yield (x, y-1)
    if y < h-1: yield (x, y+1)
    if x < w-1:
        if y > 0: yield (x+1, y-1)
        yield (x+1, y)
        if y < h-1: yield (x+1, y+1)

def sign(n):
    return 0 if n == 0 else (-1 if n < 0 else 1)

iteration = 0
while True:
    iteration += 1
    counter = 0
    data = [[e+1 for e in r] for r in data]
    while max([i for r in data for i in r]) > 9:
        for (y, r) in enumerate(data):
            for (x, e) in enumerate(r):
                if e > 9:
                    data[y][x] = -e
                    counter += 1
                    for (nx, ny) in neighbours(x, y):
                        data[ny][nx] += 1 * sign(data[ny][nx])
    data = [[0 if e < 0 else e for e in r] for r in data]
    if counter == w*h:
        break
print(iteration)
