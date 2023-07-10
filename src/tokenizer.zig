const std = @import("std");
const dyn = @import("dyn.zig");

const Token = enum {
    eof,
    unknown,
    dot,
    type,

    function
};

const FuncValence = enum {
    niladic,
    monadic,
    dyadic,
    polyadic
};

const Func = struct {
    valence: FuncValence,
    type: []const u8,
    token_pos: i32
};

pub fn tokenizeFile (file: std.fs.File)
    (dyn.Vec([]u8), dyn.Vec(Func), dyn.Vec((Token, []u8))) {
    var type_vec = dyn.Vec(i32).new();
    var func_vec = dyn.Vec(Func).new();
    var token_vec = dyn.Vec((Token, []u8)).new(); 

}
