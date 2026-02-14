// SPDX-License-Identifier: MIT
// Copyright (c) 2026 Tommi Rantala <tt.rantala@gmail.com>

#include <stdio.h>
#include <string.h>

int main(int argc, char **argv)
{
	char buf[64];
	if (argc < 2) return 1;
	strncpy(buf, argv[1], sizeof buf);
	return 0;
}
