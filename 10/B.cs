using System;
using System.Collections.Generic;
using System.Linq;

namespace B {
    internal static class B {
        private static void Main() {
            var data = System.IO.File.ReadAllText(@"input.txt").Trim().Split('\n');
            var symbolMap = new Dictionary<char, char> { {')', '('}, {']', '['}, {'}', '{'}, {'>', '<'} };
            var scoreMap = new Dictionary<char, int> { {'(', 1}, {'[', 2}, {'{', 3}, {'<', 4} };
            var scores = new List<long>();
            foreach (var d in data) {
                var stack = new Stack<char>();
                var bad = false;
                foreach (var c in d) {
                    if ("([{<".Any(ch => c.Equals(ch))) stack.Push(c);
                    else if (stack.Peek() == symbolMap[c]) stack.Pop();
                    else {
                        bad = true;
                        break;
                    }
                }
                if (bad) continue;
                var score = 0L;
                foreach (var i in stack) {
                    score *= 5;
                    score += scoreMap[i];
                }
                scores.Add(score);
            }
            scores.Sort();
            Console.WriteLine(scores[(scores.Count - 1) / 2]);
        }
    }
}