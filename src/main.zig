const std = @import("std");

const argsParcer = @import("fancy_args.zig");

pub fn main() !void {
    const gpa = std.heap.c_allocator;

    const proc_args = try std.process.argsAlloc(gpa);
    const args = proc_args[1..];

    var exec_info = try argsParcer.getExecutionInfo(args);
    try argsParcer.printExecutionInfo(exec_info);
}
