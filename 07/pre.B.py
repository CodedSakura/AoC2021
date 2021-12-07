with open("input.txt") as f:
    data = list(map(int, f.read().strip().split(",")))

def n(x):
    return x*(x+1)//2

print(min([sum([n(abs(i-j)) for i in data]) for j in range(len(data))]))
