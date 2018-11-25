let z = ((fun a -> fun b -> fun c -> a + b + c)) in
print_int (z 6 8 3)
