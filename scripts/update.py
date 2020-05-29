#!/bin/env python3
# Copyright 2019 Red Hat
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.

""" Update schemas and defaults """

import os
from pathlib import Path
from textwrap import dedent
from typing import Any, Iterator, List


def write(dest: Path, content: str) -> None:
    if content[-1] != "\n":
        content += "\n"
    if (dest.exists() and dest.read_text() != content) or not dest.exists():
        dest.parent.mkdir(parents=True, exist_ok=True)
        dest.write_text(content)
        print(f"{dest}: updated!")


def package(types: List[Path]) -> None:
    packages = list(sorted(map(lambda type: "%s = ./%s" % (
        ''.join(map(str.capitalize, type.name.replace('.dhall', '').split('_'))),
        str(type).replace('types/', 'schemas/')), types)))
    write(Path('package.dhall'), "{ %s\n}" % "\n, ".join(packages))


all_files: List[Path] = []
for dir, _, files in os.walk('types/'):
    for file in filter(lambda f: f != "map_text.dhall", files):
        file_path = Path(dir) / file
        all_files.append(file_path)
package(all_files)
