def split(word):
    return [char for char in word]

with open("./input/day11.txt") as f:
    inp = [i.strip() for i in f.readlines() if i != ""]

class day11:
    def __init__(self, inp):
        self.octopi = [[int(x) for x in split(line)] for line in inp]
        self.flashed = [[0] * len(self.octopi) for _ in range(len(self.octopi[0]))]
        self.nfl = 0

    def step(self, n):
        if self.flashed == [[1] * len(self.octopi) for _ in range(len(self.octopi[0]))]:
            print("part 2", n)
        else:
            self.flashed = [[0] * len(self.octopi) for _ in range(len(self.octopi[0]))]
            for y in range(len(self.octopi)):
                for x in range(len(self.octopi[0])):
                    self.increase_octopus(y, x)

            for y in range(len(self.octopi)):
                for x in range(len(self.octopi[0])):
                    self.flash_octopus(y, x)
            self.step(n+1)

    def increase_octopus(self, y, x):
        self.octopi[y][x] += 1

    def flash_octopus(self, y, x):
        if self.octopi[y][x] > 9 and self.flashed[y][x] != 1:
            self.nfl = self.nfl + 1
            self.octopi[y][x] = 0
            self.flashed[y][x] = 1

            min_x = max(0, x - 1)
            min_y = max(0, y - 1)
            max_x = min(9, x + 1)
            max_y = min(9, y + 1)
            
            for xp in range(min_x, max_x + 1):
                for yp in range(min_y, max_y + 1):  
                    if xp != x or yp != y:
                        if self.flashed[yp][xp] != 1:
                            self.increase_octopus(yp, xp)

            for xp in range(min_x, max_x + 1):
                for yp in range(min_y, max_y + 1):
                    if xp != x or yp != y:
                        self.flash_octopus(yp, xp)

day11(inp).step(0)