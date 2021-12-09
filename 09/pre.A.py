with open("input.txt") as f:
    data = [[int(i) for i in h] for h in f.read().strip().split("\n")]

def neighbours(x, y, w, h):
    if x > 0: yield (x-1, y)
    if y > 0: yield (x, y-1)
    if x < w-1: yield (x+1, y)
    if y < h-1: yield (x, y+1)

total = 0
for y in range(len(data)):
    for x in range(len(data[y])):
        if data[y][x] < min([data[yn][xn] for (xn, yn) in neighbours(x, y, len(data[y]), len(data))]):
            total += data[y][x] + 1
print(total)
