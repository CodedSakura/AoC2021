with open("input.txt") as f:
    data = f.read().strip().split("\n")

stack = []
points = 0
for d in data:
    for c in d:
        if c == "[": stack.append("[")
        if c == "<": stack.append("<")
        if c == "{": stack.append("{")
        if c == "(": stack.append("(")

        if c == "]":
            if stack[-1] != "[":
                points += 57
                break
            else: del stack[-1]
        if c == ">":
            if stack[-1] != "<":
                points += 25137
                break
            else: del stack[-1]
        if c == "}":
            if stack[-1] != "{":
                points += 1197
                break
            else: del stack[-1]
        if c == ")":
            if stack[-1] != "(":
                points += 3
                break
            else: del stack[-1]
print(points)