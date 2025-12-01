use std::fs;

fn part1(rotations: &Vec<(i64, i64)>) -> u64 {
    let (zeros, _) = rotations
        .iter()
        .fold((0, 50), |(zeros, dial), (dir, num)| {
            let diff = dial + num * dir;
            let new_dial = ((diff % 100) + 100) % 100;

            (zeros + (new_dial == 0) as u64, new_dial)
        });

    zeros
}

fn part2(rotations: &Vec<(i64, i64)>) -> u64 {
    let (zeros, _) = rotations
        .iter()
        .fold((0, 50), |(zeros, dial), (dir, num)| {
            let diff = dial + num * dir;
            let new_dial = ((diff % 100) + 100) % 100;

            let mut zero_passes = diff.div_euclid(100).abs() as u64; 
            if dial == 0 && *dir == -1 {
                zero_passes -= 1;
            }

            (zeros + zero_passes + (new_dial == 0 && *dir == -1) as u64, new_dial)
        });

    zeros
}


fn main() {

    let input_str = fs::read_to_string("input.txt").unwrap();

    let test_str = "L68
L30
R48
L5
R60
L55
L1
L99
R14
L82";

    let rotations = input_str 
        .lines()
        .map(|line| {
            let (dir, num) = line.split_at(1);
            let dir = dir.chars().next().unwrap();
            let num = num.parse().unwrap();
            match dir {
                'L' => (-1, num),
                'R' => (1, num),
                 _  => unreachable!(),
            }
        })
        .collect();

    let part1 = part1(&rotations);
    println!("Part1: {part1}");

    let part2 = part2(&rotations);
    println!("Part2: {part2}");
}
