module b;
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
    int[][] basinStarts;
    for (int y = 0; y < data.length; y++) {
        for (int x = 0; x < data[y].length; x++) {
            int minim = 10;
            foreach (loc; neighbours(x, y, data[y].length, data.length)) {
                minim = min(minim, data[loc[1]][loc[0]]);
            }
            if (data[y][x] < minim) basinStarts ~= [[x, y]];
        }
    } 

    int[] basinSizes;
    foreach (loc; basinStarts) {
        int[][][] basin = [[loc]];
        int[][] flatBasin = [loc];
        int pFlatBasinSize = -1;
        while (pFlatBasinSize != flatBasin.length) {
            pFlatBasinSize = cast(int) flatBasin.length;
            int[][] basinCont;
            foreach (b; basin[$-1]) {
                int[][] nb = neighbours(b[0], b[1], data[0].length, data.length)
                        .filter!(n => !basinCont.canFind(n) && !flatBasin.canFind(n) && data[n[1]][n[0]] != 9).array();
                basinCont ~= nb;
            }
            flatBasin ~= basinCont;
            basin ~= [basinCont];
        }
        basinSizes ~= cast(int) flatBasin.length;
    }
    basinSizes = sort(basinSizes).array();
    int prod = 1;
    foreach (i; basinSizes[$-3..$]) prod *= i;
    writeln(prod);
}
