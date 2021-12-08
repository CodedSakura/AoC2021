with open("input.txt") as f:
    data = [[m.split(" ") for m in n.split(" | ")] for n in f.read().strip().split("\n")]
total = 0
digit_map = {
    #   a  b  c  d  e  f  g
    0: [1, 1, 1, 0, 1, 1, 1], # 6
    1: [0, 0, 1, 0, 0, 1, 0], # 2
    2: [1, 0, 1, 1, 1, 0, 1], # 5
    3: [1, 0, 1, 1, 0, 1, 1], # 5
    4: [0, 1, 1, 1, 0, 1, 0], # 4
    5: [1, 1, 0, 1, 0, 1, 1], # 5
    6: [1, 1, 0, 1, 1, 1, 1], # 6
    7: [1, 0, 1, 0, 0, 1, 0], # 3
    8: [1, 1, 1, 1, 1, 1, 1], # 7
    9: [1, 1, 1, 1, 0, 1, 1], # 6
}
def strdiff(a, b):
    return ''.join(set(i for i in a if i not in b) | set(i for i in b if i not in a))
def strdiff2(a, b):
    return ''.join(set(i for i in a if i not in b))
def strinter(a, b):
    return ''.join(set(a) & set(b))
for d in data:
    c = {i: "" for i in [1,7,4,8]}
    p = {i: [] for i in [5,6]}
    for h in [j for i in d for j in i if len(j)]:
        if len(h) == 2: c[1] = "".join(sorted(h))
        elif len(h) == 3: c[7] = "".join(sorted(h))
        elif len(h) == 4: c[4] = "".join(sorted(h))
        elif len(h) == 5: p[5].append("".join(sorted(h)))
        elif len(h) == 6: p[6].append("".join(sorted(h)))
        elif len(h) == 7: c[8] = "".join(sorted(h))
    cmap = ["-"] * 7
    cmap[2] = cmap[5] = c[1]
    cmap[0] = strdiff(c[1], c[7])
    cmap[1] = cmap[3] = strdiff(c[1], c[4])
    cmap[4] = cmap[6] = strdiff(c[4]+c[7], c[8])
    p[6] = ''.join(set(strdiff(c[8], i) for i in p[6]))
    cmap[2] = strinter(cmap[2], p[6])
    cmap[3] = strinter(cmap[3], p[6])
    cmap[4] = strinter(cmap[4], p[6])
    g = cmap[0]+cmap[2]+cmap[3]+cmap[4]
    cmap[1] = strdiff2(cmap[1], g)
    cmap[5] = strdiff2(cmap[5], g)
    cmap[6] = strdiff2(cmap[6], g)
    num = ""
    for i in d[1]:
        h = [1 if c in i else 0 for c in cmap]
        num += str([b for b in digit_map if digit_map[b] == h][0])
    total+=int(num)
print(total)
