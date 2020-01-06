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


def type(type: Path) -> None:
    type_name = str(type).replace('types/', '')
    depth = len(type_name.split('/'))
    root = "../" * depth

    schema = "Type = {root}/types/{name}, default = {root}/defaults/{name}".format(
        root=root[:-1], name=type_name)
    write(Path('schemas') / type_name, "{ " + schema + " }")

    def mk_optional(n: List[str]) -> str:
        name, value = n[0], n[1]
        value = value.replace('Optional ', '').replace('./', root + 'types' + '/')
        return f"{name} = None {value}"

    def is_optional(n: List[str]) -> Any:
        return n[1].startswith('Optional')

    def read_type(s: str) -> List[str]:
        return list(map(str.strip, s.split(':')))

    type_def = type.read_text()[1:-2].split(',')
    defaults = list(map(
        mk_optional, filter(is_optional, map(read_type, type_def))))
    if not defaults:
        default = "{=}"
    else:
        default = "{ %s%s}" % (
            "\n, ".join(defaults), "\n" if len(defaults) > 1 else "")
    write(Path('defaults') / type_name, default)


def package(types: List[Path]) -> None:
    packages = list(map(lambda type: "%s = ./%s" % (
        type.name.replace('.dhall', '').capitalize(),
        str(type).replace('types/', 'schemas/')), types))
    write(Path('package.dhall'), "{ %s\n}" % "\n, ".join(packages))


all_files: List[Path] = []
for dir, _, files in os.walk('types/'):
    for file in files:
        file_path = Path(dir) / file
        type(file_path)
        all_files.append(file_path)
package(all_files)
