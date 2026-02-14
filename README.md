# strncpy-bpftrace

A [bpftrace](https://github.com/bpftrace/bpftrace) script to detect and trace
`strncpy()` padding behavior in running programs.

## Overview

`strncpy()` has a well-known performance issue: when the source string is
shorter than the buffer size `n`, it zero-pads the destination buffer for all
remaining bytes. This can cause significant performance degradation, especially
with large buffers.

This tool uses bpftrace to hook into libc's `__strncpy_avx2` implementation and
reports when padding occurs, helping you identify potential performance issues
in your code.

## Requirements

- Linux system with eBPF support
- [bpftrace](https://github.com/bpftrace/bpftrace) installed
- Root privileges (required for bpftrace)

## Usage

Run the bpftrace script with root privileges. The script will monitor all
`strncpy()` calls system-wide and print information when padding is detected:
```bash
sudo bpftrace trace.bt
```

Example output:
```
test pid=12345 dst=0x7ffc12345678 src=0x7ffc12345680 n=64 srclen=5 padding=59
```

Output fields:
- **comm**: Process name
- **pid**: Process ID
- **dst**: Destination buffer address
- **src**: Source string address
- **n**: Destination buffer size passed to strncpy
- **srclen**: Source string length (max `n`)
- **padding**: Number of null bytes written

## Test Program

A simple test program is included to demonstrate the tracing:
```bash
make demo
```

## Why This Matters

Using `strncpy()` with large buffers can cause unexpected performance problems:

```c
char buf[4096];
strncpy(buf, short_string, sizeof(buf));  // Will zero-fill ~4KB!
```

Consider alternatives:
- `strlcpy()` (if available)
- `snprintf(buf, sizeof(buf), "%s", src)`
- Manual copy with explicit null termination

## License

MIT License - see [LICENSE](LICENSE) for details.

## Author

Tommi Rantala <tt.rantala@gmail.com>
