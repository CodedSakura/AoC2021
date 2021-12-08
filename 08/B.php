<?php
$handle = fopen("input.txt", "r");
$total = 0;
$digit_map = [
    #      abcdefg
    0 => 0b1110111, # 6
    1 => 0b0010010, # 2
    2 => 0b1011101, # 5
    3 => 0b1011011, # 5
    4 => 0b0111010, # 4
    5 => 0b1101011, # 5
    6 => 0b1101111, # 6
    7 => 0b1010010, # 3
    8 => 0b1111111, # 7
    9 => 0b1111011, # 6
];
function strSort($w): string {
  $ws = str_split($w);
  sort($ws);
  return implode($ws);
}
function strDiff($a, $b): string {
  $o = [];
  foreach (str_split($a) as $i) if (!str_contains($b, $i)) $o[] = $i;
  foreach (str_split($b) as $i) if (!str_contains($a, $i)) $o[] = $i;
  return implode(array_unique($o));
}
function strDiff2($a, $b): string {
  $o = [];
  foreach (str_split($a) as $i) if (!str_contains($b, $i)) $o[] = $i;
  return implode(array_unique($o));
}
function strInter($a, $b): string {
  return implode(array_intersect(str_split($a), str_split($b)));
}
while (($line = trim(fgets($handle))) != false) {
  list($a, $b) = explode(" | ", $line);
  $c = [1 => "", 4 => "", 7 => "", 8 => ""];
  $p = [5 => [], 6 => []];
  foreach (explode(" ", $a." ".$b) as $h) {
    switch (strlen($h)) {
      case 2: $c[1] = strSort($h); break;
      case 3: $c[7] = strSort($h); break;
      case 4: $c[4] = strSort($h); break;
      case 5: $p[5][] = strSort($h); break;
      case 6: $p[6][] = strSort($h); break;
      case 7: $c[8] = strSort($h); break;
    }
  }
  $cmap = ["-", "-", "-", "-", "-", "-", "-"];
  $cmap[2] = $cmap[5] = $c[1];
  $cmap[0] = strDiff($c[1], $c[7]);
  $cmap[1] = $cmap[3] = strDiff($c[1], $c[4]);
  $cmap[4] = $cmap[6] = strDiff($c[4].$c[7], $c[8]);
  $p6 = [];
  foreach ($p[6] as $i) {
    $p6[] = strDiff($c[8], $i);
  }
  $p[6] = implode(array_unique($p6));
  $cmap[2] = strInter($cmap[2], $p[6]);
  $cmap[3] = strInter($cmap[3], $p[6]);
  $cmap[4] = strInter($cmap[4], $p[6]);
  $g = $cmap[0].$cmap[2].$cmap[3].$cmap[4];
  $cmap[1] = strDiff2($cmap[1], $g);
  $cmap[5] = strDiff2($cmap[5], $g);
  $cmap[6] = strDiff2($cmap[6], $g);
  $num = "";
  foreach (explode(" ", $b) as $i) {
    $h = 0;
    foreach ($cmap as $c) {
      $h <<= 1;
      if (str_contains($i, $c)) $h += 1;
    }
    $num .= array_search($h, $digit_map);
  }
  $total += (int)$num;
}
echo $total, PHP_EOL;
