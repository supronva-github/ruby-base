fib = [0, 1]
fib << fib[-2] + fib[-1] while fib.size < 100
puts fib
