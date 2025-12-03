local lines = {}

for line in io.lines("input.txt") do
	local chars = {}

	for c in line:gmatch(".") do
		table.insert(chars, tonumber(c))
	end

	table.insert(lines, chars)
end

local function part1()
	local sum = 0

	for _, line in ipairs(lines) do
		local max_left = 1
		local max_right = #line

		for i = 1, #line - 1 do
			if line[i] > line[max_left] then
				max_left = i
			end
		end

		for j = #line, max_left + 1, -1 do
			if line[j] > line[max_right] then
				max_right = j
			end
		end

		local max_line = 10 * line[max_left] + line[max_right]
		sum = sum + max_line
	end

	return sum
end

local function part2()
	local sum = 0

	for _, line in ipairs(lines) do
		local max_line = 0
		local prev_max = 0
		for i = 1, 12 do
            local curr_max = prev_max + 1
			for j = prev_max + 1, #line - 12 + i do
				if line[j] > line[curr_max] then
					curr_max = j
				end
			end

			prev_max = curr_max
			max_line = max_line + line[curr_max] * 10 ^ (12 - i)
		end

		sum = sum + max_line
	end

	return sum
end

print("Part1:", part1())

-- for some reason printed like this: 1.7041819225686e+14 
-- and I dont know how to count so I missed the last digit (170418192256861)
print("Part2:", string.format("%.0f", part2()))
