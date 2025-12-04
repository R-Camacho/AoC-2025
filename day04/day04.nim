import std/[strutils]

type
    Grid = seq[string]

proc at(grid: Grid, x, y: int): char = 
    if y < 0 or y >= grid.len: return '\0'
    if x < 0 or x >= grid[y].len: return '\0'
    return grid[y][x] 


proc countAdjacents(grid: Grid, x, y: int) : int = 
    const directions = [
        (1, 0), (-1, 0),
        (0, 1), (0, -1),
        (1, 1), (-1, -1),
        (-1, 1), (1, -1)
    ]

    var count = 0
    for (dx, dy) in directions:
        if grid.at(x, y) == grid.at(x + dx, y + dy):
            count += 1
    
    return count

proc part1(grid: Grid): int = 

    var count = 0
    for y in 0 ..< grid.len:
        for x in 0 ..< grid[0].len:
            if grid.at(x, y) == '@' and countAdjacents(grid, x, y) < 4:
                count += 1
            
    return count

proc part2(grid: var Grid): int = 

    var count = 0
    while true:
        var removed = 0
        for y in 0 ..< grid.len:
            for x in 0 ..< grid[0].len:
                if grid.at(x, y) == '@' and countAdjacents(grid, x, y) < 4:
                    removed += 1
                    grid[y][x] = '.'
        
        if removed == 0:
            break
        count += removed

    return count

proc main() =
    let input = readFile("input.txt").strip()
    var grid: Grid = input.splitLines()

    echo "Part 1: ", part1(grid)
    echo "Part 2: ", part2(grid)

main()
