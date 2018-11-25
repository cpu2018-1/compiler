let z = ((fun a -> fun b -> fun c -> a + b + c) 6) in
print_int (z 8 3)
