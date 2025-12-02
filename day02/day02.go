package main

import (
	"fmt"
	"os"
	"strings"
	"strconv"
)



func is_invalid(num string) bool {
	return (num[:len(num)/2] == num[len(num)/2:])
}

func is_invalid2(num string) bool {
	n := len(num)
	for i := 1; i <= n/2; i++ {
		
		all := true

		for j := 0; j + 2 * i <= n; j += i  {
			//fmt.Printf("1: %s ", num[j:j+i])
			//fmt.Printf("2: %s\n", num[j+i:j+ 2*i])

			if num[j:j+i] != num[j+i:j+i+i] {
				all  = false
				break
			}

		} 

		if all && n % i == 0 {
			return true
		}

	}
	return false
}

func part1(ranges [][]int) int {
	ans := 0
	for _, r := range ranges {
		start := r[0]
		end := r[1]

		for start <= end {
			numS := strconv.Itoa(start)
			if is_invalid(numS) {
				ans += start;
			}
			start++
		}
	}

	return ans;
}

func part2(ranges [][]int) int {
	ans := 0
	for _, r := range ranges {
		start := r[0]
		end := r[1]

		for start <= end {
			numS := strconv.Itoa(start)
			if is_invalid2(numS) {
				ans += start;
			}
			start++
		}
	}

	return ans;
}

func main() {

	data, err := os.ReadFile("input.txt")
	if err != nil {
		panic(err)
	}

	content := string(data)
	//content = "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"

	parts := strings.Split(content, ",")
	var ranges [][]int

		for _, p := range parts {
		p = strings.TrimSpace(p)
		if p == "" {
			continue
		}

		sides := strings.Split(p, "-")
		if len(sides) != 2 {
			continue
		}

		start, err1 := strconv.Atoi(sides[0])
		end, err2 := strconv.Atoi(sides[1])
		if err1 != nil || err2 != nil {
			continue
		}

		ranges = append(ranges, []int{start, end})
	}

	part1 := part1(ranges)
	fmt.Printf("Part1: %d\n", part1);

	part2 := part2(ranges)
	fmt.Printf("Part2: %d\n", part2);



}
