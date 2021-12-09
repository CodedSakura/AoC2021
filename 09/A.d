module a;
import std;

int[][] neighbours(int x, int y, ulong w, ulong h) {
    int[][] output;
    if (x > 0) output ~= [[x-1, y]];
    if (y > 0) output ~= [[x, y-1]];
    if (x < w-1) output ~= [[x+1, y]];
    if (y < h-1) output ~= [[x, y+1]];
    return output;
}

void main() {
    int[][] data = splitLines(readText("input.txt"))
            .map!(x => x.split("").map!(y => y.to!int).array()).array();
    int total = 0;
    for (int y = 0; y < data.length; y++) {
        for (int x = 0; x < data[y].length; x++) {
            int minim = 10;
            foreach (loc; neighbours(x, y, data[y].length, data.length)) {
                minim = min(minim, data[loc[1]][loc[0]]);
            }
            if (data[y][x] < minim) total += data[y][x] + 1;
        }
    } 
    
    writeln(total);
}
