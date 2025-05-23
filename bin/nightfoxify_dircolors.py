#!/usr/bin/env python3

"""
draculize_dircolors.py -- modify existing .dircolors to appease Dracula.

For example:
curl -fSsL https://raw.githubusercontent.com/coreutils/coreutils/master/src/dircolors.hin | ./draculize_dircolors.py >.dircolors

Copyright (C) Ville Skyttä
SPDX-License-Identifier: MIT
"""

import fileinput
import re
import sys
from typing import Match


# https://spec.draculatheme.com/#sec-ANSI
# https://en.wikipedia.org/wiki/ANSI_escape_code#3-bit_and_4-bit
# https://en.wikipedia.org/wiki/ANSI_escape_code#24-bit
FG_MAP = {
    k: "38;2;%d;%d;%d" % tuple(int(v[i : i + 2], 16) for i in range(1, len(v), 2))
    for k, v in {
        "30": "#192330", # "#21222C",
        "31": "#212e3f", # "#FF5555",
        "32": "#29394f", # "#50FA7B",
        "33": "#575860", # "#F1FA8C",
        "34": "#71839b", # "#BD93F9",
        "35": "#cdcecf", # "#FF79C6",
        "36": "#aeafb0", # "#8BE9FD",
        "37": "#e4e4e5", # "#F8F8F2",
        "90": "#c94f6d", # "#6272A4",
        "91": "#f4a261", # "#FF6E6E",
        "92": "#dbc074", # "#69FF94",
        "93": "#81b29a", # "#FFFFA5",
        "94": "#63cdcf", # "#D6ACFF",
        "95": "#719cd6", # "#FF92DF",
        "96": "#9d79d6", # "#A4FFFF",
        "97": "#d67ad2", # "#FFFFFF",
    }.items()
}


BG_MAP = {str(int(k) + 10): f"4{v[1:]}" for k, v in FG_MAP.items()}


def map_color(match: Match[str]) -> str:
    """Map basic ANSI color to 24-bit Dracula."""
    match_str = match.group(0)
    return FG_MAP.get(match_str, BG_MAP.get(match_str, match_str))


def main() -> None:
    """Run the tool."""
    for line in fileinput.input():
        sys.stdout.write(re.sub(r"\d+", map_color, line))


if __name__ == "__main__":
    main()
