using System;
using System.Collections.Generic;
using System.Linq;

namespace A {
    internal static class A {
        private static void Main() {
            var data = System.IO.File.ReadAllText(@"input.txt").Trim().Split('\n');
            var symbolMap = new Dictionary<char, char> { {')', '('}, {']', '['}, {'}', '{'}, {'>', '<'} };
            var scoreMap = new Dictionary<char, int> { {')', 3}, {']', 57}, {'}', 1197}, {'>', 25137} };
            var score = 0;
            foreach (var d in data) {
                var stack = new Stack<char>();
                foreach (var c in d) {
                    if ("([{<".Any(ch => c.Equals(ch))) stack.Push(c);
                    else if (stack.Peek() == symbolMap[c]) stack.Pop();
                    else {
                        score += scoreMap[c];
                        break;
                    }
                }
            }
            Console.WriteLine(score);
        }
    }
}
