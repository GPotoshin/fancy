const std = @import("std");

pub fn Vec(comptime T: type) type {
    return struct {
        len: i32,
        data: []T,
        allocator: *std.mem.Allocator,
        _buf_size: i32,
        
        pub fn new () Vec(T) {
            return Vec(T) {
                .len = 0,
                .data = &[_]T{},
                .allocator = std.heap.page_allocator,
                ._buf_size = 0,
            };
        }

        pub fn with_allocator (allocator: *std.mem.Allocator) Vec(T) {
            return Vec(T) {
                .len = 0,
                .data = &[_]T{},
                .allocator = allocator,
                ._buf_size = 0,
            };
        }
        
        pub fn with_capacity (capacity: i32) !Vec(T) {
            const new_buf = std.heap.page_allocator.alloc(T, capacity);
            if (new_buf == null) {
                return error.InsufficientMemory;
            }

            return Vec(T) {
                .len = capacity,
                .data = new_buf,
                .allocator = std.heap.page_allocator,
                ._buf_size = 0,
            };
        }

        pub fn push (self: *Vec(T), x: T) !void {
            if (self.len == self._buf_size) {
                const new_buf_size = self._buf_size + 16;
                const new_buf = self.allocator.alloc(T, new_buf_size);
                if (new_buf == null) {
                    return error.InsufficientMemory;
                }
                self.data = new_buf;
                self._buf_size = new_buf_size;
            }
            self.data[self.len] = x;
            self.len += 1;
        }
    };
}

