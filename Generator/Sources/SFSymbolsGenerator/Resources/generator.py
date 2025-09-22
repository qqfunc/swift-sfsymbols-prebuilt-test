#!/usr/bin/env python

"""Update SF Symbols."""

from __future__ import annotations

import plistlib
import sys
from argparse import ArgumentParser
from pathlib import Path
from typing import TypedDict

SF_SYMBOLS_PATH = Path("/Applications/SF Symbols.app")
SF_SYMBOLS_METADATA_PATH = SF_SYMBOLS_PATH / "Contents/Resources/Metadata"
SF_SYMBOLS_NAME_AVAILABILITY_PATH = (
    SF_SYMBOLS_METADATA_PATH / "name_availability.plist"
)

FILE_HEADER = "// This file is generated automatically. Do not edit."


class SFSymbolsGenerator:
    """Generate SFSymbols Swift package files."""

    def __init__(self, path: Path) -> None:
        """Initialize self."""
        self.path = path

        # Load name_availability.json
        with SF_SYMBOLS_NAME_AVAILABILITY_PATH.open("rb") as plist_file:
            self.name_availability = plistlib.load(plist_file)

        self.generate_availability_attributes()
        self.generate_symbol_definitions()

    path: Path
    """Path to the plugin working directory."""

    name_availability: NameAvailabilityDict
    """Contents of ``name_availability.json``."""

    def generate_availability_attributes(self) -> None:
        """Generate availability attributes."""
        self.availabilities: dict[str, str] = {}
        for year, release in self.name_availability["year_to_release"].items():
            releases = ", ".join(f"{os} {ver}" for os, ver in release.items())
            self.availabilities[year] = f"@available({releases}, *)"

    def generate_symbol_definitions(self) -> None:
        """Generate symbol definitions."""
        self.symbols: dict[str, str] = {}
        for name, year in self.name_availability["symbols"].items():
            availability = self.availabilities[year]
            self.symbols[name] = (
                f"    {availability}\n"
                f'    static let `{name}` = SFSymbol(name: "{name}")'
            )

    def write_symbols_file(self) -> None:
        """Write ``SFSymbol+Symbols.swift`` file."""
        (self.path / "SFSymbol+Symbols.swift").write_text(
            f"""{FILE_HEADER}

public extension SFSymbol {{

{"\n\n".join(self.symbols.values())}

}}
""",
        )


class NameAvailabilityDict(TypedDict):
    """Typed dictionary for ``name_avaialability.json``."""

    symbols: dict[str, str]
    """``symbols`` table in the JSON file."""

    year_to_release: dict[str, dict[str, str]]
    """``year_to_release`` table in the JSON file."""


class Arguments:
    """Command line arguments."""

    path: Path
    """Path to the plugin working directory."""


def main() -> None:
    """Update SF Symbols."""
    if not SF_SYMBOLS_PATH.is_dir():
        sys.exit("ERROR: SF Symbols is not installed.")

    parser = ArgumentParser(description="Update SF Symbols")
    parser.add_argument(
        "path",
        type=Path,
        help="Path to the plugin working directory",
    )
    args = parser.parse_args(namespace=Arguments())

    generator = SFSymbolsGenerator(args.path)
    generator.write_symbols_file()


if __name__ == "__main__":
            main()
