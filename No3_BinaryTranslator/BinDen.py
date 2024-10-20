Value = 0

d1 = input('Digit 1:')
if d1 == '1':
    Value += 128
elif d1 == '0':
    Value += 0
else:
    print('Only ones and zeros allowed!')
    exit()
d2 = input(d1 + ' Digit 2:')
if d2 == '1':
    Value += 64
elif d2 == '0':
    Value += 0
else:
    print('Only ones and zeros allowed!')
    exit()
d3 = input(d1 + d2 + ' Digit 3:')
if d3 == '1':
    Value += 32
elif d3 == '0':
    Value += 0
else:
    print('Only ones and zeros allowed!')
    exit()
d4 = input(d1 + d2 + d3 + ' Digit 4:')
if d4 == '1':
    Value += 16
elif d4 == '0':
    Value += 0
else:
    print('Only ones and zeros allowed!')
    exit()
d5 = input(d1 + d2 + d3 + d4 + 'Digit 5:')
if d5 == '1':
    Value += 8
elif d5 == '0':
    Value += 0
else:
    print('Only ones and zeros allowed!')
    exit()
d6 = input(d1 + d2 + d3 + d4 + d5 + 'Digit 6:')
if d6 == '1':
    Value += 4
elif d6 == '0':
    Value += 0
else:
    print('Only ones and zeros allowed!')
    exit()
d7 = input(d1 + d2 + d3 + d4 + d5 + d6 + 'Digit 7:')
if d7 == '1':
    Value += 2
elif d7 == '0':
    Value += 0
else:
    print('Only ones and zeros allowed!')
    exit()
d8 = input(d1 + d2 + d3 + d4 + d5 + d6 + d7 + 'Digit 8:')
if d8 == '1':
    Value += 1
elif d8 == '0':
    Value += 0
else:
    print('Only ones and zeros allowed!')
    exit()
print('Binary:', d1 + d2 + d3 + d4 + d5 + d6 + d7 + d8)
print('Decimal:', Value)
