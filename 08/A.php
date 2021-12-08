<?php
$handle = fopen("input.txt", "r");
$total = 0;
while (($line = trim(fgets($handle))) != false) {
  list($a, $b) = explode(" | ", $line);
  foreach (explode(" ", $b) as $c) {
    if (strlen($c) === 2) $total++;
    if (strlen($c) === 3) $total++;
    if (strlen($c) === 4) $total++;
    if (strlen($c) === 7) $total++;
  }
}
echo $total, PHP_EOL;
