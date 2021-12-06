IFS=','
read -r -a input <<< "$(cat "input.txt")"

array=(0 0 0 0 0 0 0 0 0);

for i in "${input[@]}"; do (( array[i]++ )); done

for _ in {1..80}; do
  array2=(0 0 0 0 0 0 0 0 0);
  for i in {0..9}; do
    if [ "$i" == 0 ]; then
      (( array2[8] += array[0] ))
      (( array2[6] += array[0] ))
    else
      (( array2[i - 1] += array[i] ))
    fi
  done
  array=("${array2[@]}");
done

echo $(IFS=+; echo "$((${array[*]}))")
