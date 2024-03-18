Y = (lambda g: 
        (lambda f: g(lambda arg: f(f)(arg)))
        (lambda f: g(lambda arg: f(f)(arg))))

fac = (lambda f: 
        lambda n: (1 if n<2 else n*f(n-1)))

assert Y(fac)(7) == 5040
