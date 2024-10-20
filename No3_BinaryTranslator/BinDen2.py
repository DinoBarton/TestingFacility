Value = 0

for i in range(8): 
    digit = input(f'digt {i + 1} (0 or 1):')
    if digit == '1':
        Value += 2 ** (7-i) 
    elif digit == '0':
        Value += 0
    else:
        print('Only ones and zeros allowed!') 
        exit()

print(Value)