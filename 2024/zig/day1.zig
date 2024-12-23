const std = @import("std");
const ArrayList = std.ArrayList;
const HashMap = std.AutoHashMap;
var gpa = std.heap.GeneralPurposeAllocator(.{}){};
const allocator = gpa.allocator();

const input = @embedFile("./inputs/day1.txt");

pub fn main() !void {
    try part1();
    try part2();
}

fn part1() !void {
    const left, const right = try parse_input();

    std.mem.sort(i64, left.items, {}, comptime std.sort.asc(i64));
    std.mem.sort(i64, right.items, {}, comptime std.sort.asc(i64));

    var sum: u64 = 0;

    for (0..left.items.len) |idx| {
        const l_num = left.items[idx];
        const r_num = right.items[idx];
        sum += @abs(l_num - r_num);
    }

    std.debug.print("part 1: {d}\n", .{sum});
}

fn part2() !void {
    const left, const right = try parse_input();

    var freq = HashMap(i64, i64).init(allocator);
    for (right.items) |num| {
        const count = freq.get(num) orelse 0;
        try freq.put(num, count + 1);
    }

    var sum: i64 = 0;
    for (left.items) |num| {
        sum += num * (freq.get(num) orelse 0);
    }

    std.debug.print("part 2: {d}\n", .{sum});
}

fn parse_input() ![2]ArrayList(i64) {
    var line_iter = std.mem.tokenizeScalar(u8, input, '\n');

    var left = ArrayList(i64).init(allocator);
    var right = ArrayList(i64).init(allocator);

    while (line_iter.next()) |line| {
        var iter = std.mem.tokenizeScalar(u8, line, ' ');
        const left_num = try std.fmt.parseInt(i64, iter.next().?, 10);
        const right_num = try std.fmt.parseInt(i64, iter.next().?, 10);

        try left.append(left_num);
        try right.append(right_num);
    }

    return .{ left, right };
}
