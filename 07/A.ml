let () =
  let ic = open_in "input.txt" in
  let data = List.map int_of_string (String.split_on_char ',' (input_line ic)) in
  let fuels = List.map ( fun a -> List.fold_left ( + ) 0 (List.map ( fun b -> abs (b - a) ) data)) (List.init (List.length data) ( succ )) in
  print_int (List.fold_left ( min ) max_int fuels);
  print_newline ()
