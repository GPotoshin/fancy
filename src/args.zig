const std = @import("std");

const version = "v0.0.0-alpha";
const help_header =
    \\OVERVIEW: fancy parcer
    \\
    \\USAGE: fancy [options] file...
    \\
    \\OPTIONS:
;

const flags_names = [_][]const u8{ "--help", "--version", "-o" };
const flags_arguments = [_][]const u8{ "", "", "<file>" };
const flags_descriptions = [_][]const u8{ "Display available options", "Display version", "Write output to <file>" };

const file_line = "<file>         Input file";

const Flags = enum(u8) {
    HELP,
    VERSION,
    OUT,
    EMPTY,
};

pub const ExecutionInfo = struct {
    help: bool,
    version: bool,

    input_file_name: []const u8,
    output_file_name: []const u8,
};

fn showDescription() !void {
    const stdout = std.io.getStdOut().writer();
    const offset = 16;

    for (flags_names, flags_arguments, flags_descriptions) |name, argument, description| {
        try stdout.print("{s} ", .{name});
        try stdout.print("{s}", .{argument});
        for (1..(offset - name.len - argument.len - 1)) |_| {
            try stdout.print(" ", .{});
        }
        try stdout.print("{s}\n", .{description});
    }
    try stdout.print("{s}\n", .{file_line});
}

// That function allocates structer on stack as it's not that big
pub fn getExecutionInfo(args: [][:0]const u8) !ExecutionInfo {
    var exec_info: ExecutionInfo = ExecutionInfo{ .help = false, .version = false, .input_file_name = "", .output_file_name = "" };

    var inheritence = Flags.EMPTY;
    for (args) |item| {
        if (inheritence == Flags.EMPTY) {
            if (std.mem.eql(u8, item, flags_names[@intFromEnum(Flags.HELP)])) {
                exec_info.help = true;
            } else if (std.mem.eql(u8, item, flags_names[@intFromEnum(Flags.VERSION)])) {
                exec_info.version = true;
            } else if (std.mem.eql(u8, item, flags_names[@intFromEnum(Flags.OUT)])) {
                inheritence = Flags.OUT;
            } else {
                exec_info.input_file_name = item;
            }
        } else if (inheritence == Flags.OUT) {
            exec_info.output_file_name = item;
        }
    }
    return exec_info;
}

pub fn printExecutionInfo(exec_info: ExecutionInfo) !void {
    const stdout = std.io.getStdOut().writer();
    if (exec_info.version) {
        try stdout.print("{s}", .{version});
        std.os.exit(0);
    }
    if (exec_info.help) {
        try showDescription();
        std.os.exit(0);
    }
}
