#!/bin/env python3
# Copyright 2020 Red Hat
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

# Keep README.md updated
import subprocess
doc = open('README.md').read().split('\n')
dhallstart = doc.index('```dhall')
dhallend = doc[dhallstart:].index('```') + dhallstart
demostart = doc.index('```yaml')
demoend = doc[demostart:].index('```') + demostart
demo = subprocess.Popen(['dhall-to-yaml', '--omit-empty', '--file', './examples/demo.dhall'], stdout=subprocess.PIPE)
newdoc = doc[:dhallstart + 2] + open('examples/demo.dhall').read().split('\n') + \
    doc[dhallend:demostart + 2] + demo.communicate()[0].decode('utf-8').split('\n')[1:] + doc[demoend:]
exit(0) if newdoc == doc else open('README.md', 'w').write('\n'.join(newdoc)); print('README.md updated!')
