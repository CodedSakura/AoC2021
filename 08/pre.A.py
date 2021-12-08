with open("input.txt") as f:
    data = [[m.split(" ") for m in n.split(" | ")] for n in f.read().strip().split("\n")]

print(len([len(j) for i in data for j in i[1] if len(j) in [2, 3, 4, 7]]))
