const std = @import("std");

fn returnTuple() .{i32, f64, bool} {
    return .{42, 3.14, true};
}

pub fn main() !void {
    const .{value1:i32, value2:f64, value3:bool} = returnTuple();
    std.debug.print("Value 1: {}\n", .{value1});
    std.debug.print("Value 2: {}\n", .{value2});
    std.debug.print("Value 3: {}\n", .{value3});
}
