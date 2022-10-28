const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    // Standard release options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall.
    const mode = b.standardReleaseOptions();

    const lib = b.addSharedLibrary("normalascii", "src/main.zig", .unversioned);
    lib.setBuildMode(mode);
    lib.linkLibC();
    lib.linkSystemLibrary("dbus-1");
    lib.install();

    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(blk: {
        const tests = b.addTest("src/main.zig");
        tests.setBuildMode(mode);
        break :blk &tests.step;
    });

    const run_step = b.step("run", "Run the main");
    run_step.dependOn(blk: {
        const exe = b.addExecutable("normalascii", "src/main.zig");
        exe.linkLibC();
        exe.linkSystemLibrary("dbus-1");
        break :blk &exe.run().step;
    });
}
