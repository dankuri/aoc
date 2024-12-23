use std::collections::HashMap;

fn main() {
    let input = include_str!("../inputs/day1.txt").trim();
    let _input = "3   4
4   3
2   5
1   3
3   9
3   3";

    part1(input);
    part2(input);
}

fn part1(input: &str) {
    let (mut left, mut right): (Vec<i64>, Vec<i64>) = parse_input(input);

    left.sort();
    right.sort();

    let res: i64 = std::iter::zip(left, right)
        .map(|(a, b)| (a - b).abs())
        .sum();

    println!("part1: {res}");
}

fn part2(input: &str) {
    let (left, right): (Vec<i64>, Vec<i64>) = parse_input(input);

    let frequencies: HashMap<i64, i64> =
        right.iter().copied().fold(HashMap::new(), |mut acc, val| {
            *acc.entry(val).or_default() += 1;
            acc
        });

    let res: i64 = left
        .iter()
        .map(|num| num * frequencies.get(num).unwrap_or(&0))
        .sum();

    println!("part2: {res}");
}

fn parse_input(input: &str) -> (Vec<i64>, Vec<i64>) {
    let (left, right): (Vec<i64>, Vec<i64>) =
        input
            .split('\n')
            .fold((vec![], vec![]), |(mut l, mut r), val| {
                let mut iter = val.split_whitespace();
                let left_num: i64 = iter.next().unwrap().parse().unwrap();
                let rigth_num: i64 = iter.next().unwrap().parse().unwrap();
                l.push(left_num);
                r.push(rigth_num);
                (l, r)
            });

    (left, right)
}
