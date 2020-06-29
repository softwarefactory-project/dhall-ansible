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

from generate import attr2name


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
    if type_name == 'task.dhall':
        task_lines = list(filter(lambda x: 'Optional ./modules/' not in x, type.read_text().split('\n')[:-2]))
        for module in sorted(os.listdir('types/modules')):
            task_lines.append(', %s : Optional ./modules/%s' % (attr2name(module.replace('.dhall', '')), module))
        task_lines.append('}')
        type.write_text('\n'.join(task_lines) + '\n')

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

    type_def = type.read_text()[1:-1].strip('{').strip('}').split(',')
    defaults = list(map(
        mk_optional, sorted(filter(is_optional, map(read_type, type_def)))))
    if not defaults:
        default = "{=}"
    else:
        default = "{ %s%s}" % (
            "\n, ".join(defaults), "\n" if len(defaults) > 1 else "")
    write(Path('defaults') / type_name, default)


def package(types: List[Path]) -> None:
    packages = list(sorted(map(lambda type: "%s = ./%s" % (
        ''.join(map(str.capitalize, type.name.replace('.dhall', '').split('_'))),
        str(type).replace('types/', 'schemas/')), types)))
    write(Path('package.dhall'), "{ %s\n}" % "\n, ".join(packages))


all_files: List[Path] = []
for dir, _, files in os.walk('types/'):
    for file in filter(lambda f: f != "map_text.dhall", files):
        file_path = Path(dir) / file
        type(file_path)
        all_files.append(file_path)
package(all_files)
