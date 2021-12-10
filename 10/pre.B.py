with open("input.txt") as f:
    data = f.read().strip().split("\n")

scores = []
for d in data:
    stack = []
    bad = False
    for c in d:
        if c == "[": stack.append("[")
        if c == "<": stack.append("<")
        if c == "{": stack.append("{")
        if c == "(": stack.append("(")

        if c == "]":
            if stack[-1] != "[": 
                bad = True
                break
            else: del stack[-1]
        if c == ">":
            if stack[-1] != "<": 
                bad = True
                break
            else: del stack[-1]
        if c == "}":
            if stack[-1] != "{": 
                bad = True
                break
            else: del stack[-1]
        if c == ")":
            if stack[-1] != "(": 
                bad = True
                break
            else: del stack[-1]
    if bad: continue
    stack = stack[::-1]
    score = 0
    for i in stack:
        score *= 5
        if i == "(": score += 1
        if i == "[": score += 2
        if i == "{": score += 3
        if i == "<": score += 4
    scores.append(score)
print(sorted(scores)[len(scores) // 2])