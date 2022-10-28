normalascii
---

set rime to ascii mode after you left nvim's insert mode through dbus lib.

## status: experimental
it may crash nvim

## prerequisites
* linux
* dbus 1.14.4
* fcitx5
* rime
* nvim 0.8.0
* zig 0.10.0 (for compiling)

## setup
* add it to your nvim plugin manager
* `zig build -Drelease-safe`

## usage
* manually: `require'normalascii'.goto_ascii()`
* automatically: `require'normalascii'.auto_ascii()`
