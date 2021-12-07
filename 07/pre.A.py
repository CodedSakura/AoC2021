with open("input.txt") as f:
    data = list(map(int, f.read().strip().split(",")))

print(min([sum([abs(i - j) for i in data]) for j in range(len(data))]))
