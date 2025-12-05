import Data.List

parseInput :: String -> ([(Int,Int)], [Int])
parseInput input =
    let (rangePart, numPart) = break null (lines input)
        ranges = map parseRange rangePart
        nums   = map read (drop 1 numPart)
    in (ranges, nums)

parseRange :: String -> (Int, Int)
parseRange s =
    let (a, _ : b) = break (== '-') s
    in (read a, read b)


part1 :: [(Int, Int)] -> [Int] -> Int
part1 ranges nums = 
    length (filter inAnyRange nums)
    where
    inAnyRange n = any (\(a,b) -> n >= a && n <= b) ranges


mergeRanges :: [(Int, Int)] -> [(Int, Int)] 
mergeRanges ranges = go (sortOn fst ranges) []
    where 
        go [] acc    = reverse acc
        go (r:rs) [] = go rs [r]
        go ((a, b):rs) ((c, d): acc)
            | a <= d + 1 = go rs ((c, max d b): acc)
            | otherwise = go rs ((a, b):(c, d):acc)

part2 :: [(Int, Int)] -> Int
part2 ranges =
      sum [ b - a + 1 | (a,b) <- mergeRanges ranges ]
    

main :: IO ()
main = do
    input <- readFile "input.txt"
    let (ranges, nums) = parseInput input
    -- print ranges 
    -- print nums

    let result1 = part1 ranges nums
    print result1 

    let result2 = part2 ranges
    print result2 

    
