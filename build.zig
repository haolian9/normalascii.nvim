const std = @import("std");

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});
    const target = b.standardTargetOptions(.{});

    const lib = b.addSharedLibrary(.{
        .name = "normalascii",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });
    lib.linkLibC();
    lib.linkSystemLibrary("dbus-1");
    b.installArtifact(lib);

    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(blk: {
        const tests = b.addTest(.{
            .root_source_file = .{ .path = "src/main.zig" },
            .target = target,
            .optimize = optimize,
        });
        tests.linkLibC();
        tests.linkSystemLibrary("dbus-1");
        break :blk &tests.step;
    });

    const run_step = b.step("run", "Run the main");
    run_step.dependOn(blk: {
        var exe = b.addExecutable(.{
            .name = "normalascii",
            .root_source_file = .{ .path = "src/main.zig" },
            .target = target,
            .optimize = optimize,
        });
        exe.linkLibC();
        exe.linkSystemLibrary("dbus-1");
        break :blk &b.addRunArtifact(exe).step;
    });
}
