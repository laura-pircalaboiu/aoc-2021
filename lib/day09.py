def split(word):
    return [char for char in word]

with open("../input/day09_ex.txt") as f:
    inp = [i.strip() for i in f.readlines() if i != ""]
    inp = [split(line) for line in inp]


part1 = 0
width = len(inp[0])
# for y in range(len(inp)):
#     for x in range(width):
#         neighbors = []
#         lowp = True
#         curr = int(inp[y][x])
#         if x > 0:
#             neighbors.append(int(inp[y][x - 1]))
#         if y > 0: 
#             neighbors.append(int(inp[y - 1][x]))
#         if  x < width - 1:
#             neighbors.append(int(inp[y][x + 1]))
#         if y < len(inp) - 1:
#             neighbors.append(int(inp[y + 1][x]))
#         for i in neighbors:
#             if curr > i:
#                 lowp = False

#         if lowp == True:
            
#             if curr != 9:
#                 part1 = part1 + curr + 1


def is_lowpoint(x, y, inp):
    neighbors = []
    lowp = True
    if x > 0:
        neighbors.append(int(inp[y][x - 1]))
    if y > 0: 
        neighbors.append(int(inp[y - 1][x]))
    if  x < width - 1:
        neighbors.append(int(inp[y][x + 1]))
    if y < len(inp) - 1:
        neighbors.append(int(inp[y + 1][x]))
    for i in neighbors:
        if int(inp[y][x]) > i:
            lowp = False
    return lowp



part2 = 0
width = len(inp[0])
basins = {}

def valid_neighbors(curr, inp):
    (x, y) = curr
    neighbors = []
    valid_boys = []

    if x > 0:
        neighbors.append((y, x-1, int(inp[y][x - 1])))
    if y > 0: 
        neighbors.append((y-1, x, int(inp[y - 1][x])))
    if  x < width - 1:
        neighbors.append((y, x + 1, int(inp[y][x + 1])))
    if y < len(inp) - 1:
        neighbors.append((y + 1, x, int(inp[y + 1][x])))
    for (yp, xp, h) in neighbors:
        if int(inp[y][x]) < h and h != 9:
            valid_boys.append((yp, xp))
    return valid_boys


for y in range(len(inp)):
    for x in range(width):
        if(is_lowpoint(x, y, inp)):
            basins[(x, y)] = set([(x, y)])

for (x, y) in basins:
    curr = (x, y)
    toadd = set(valid_neighbors(curr, inp))
    while len(toadd) != 0:
        basins[(x, y)].update(toadd)
        toadd.clear()
        for point in basins[(x, y)]:
            print(toadd)
            toadd.update(valid_neighbors(point, inp))
            print(toadd)


