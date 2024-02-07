#!/usr/bin/env python3

import sys

author_info = "   * @author Guilherme Ramos (guilherme.ramos@compasso.com.br)"
lines = sys.stdin.readlines()
current_line_number = int(lines[0])
lines[current_line_number - 1] = author_info

for line in lines:
    print(line, end='')
