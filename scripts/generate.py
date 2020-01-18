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

# First download: https://raw.githubusercontent.com/shaded-enmity/ansible-schema-generator/master/examples/ansible.json
import json

ansible = json.loads(open("ansible.json").read())['items']['anyOf'][-1]['properties']

# Then update the list from https://docs.ansible.com/ansible/latest/modules/core_maintained.html
module_list = (
    # Amazon

    "aws_s3",
    "cloudformation",
    "ec2",
    "ec2_group",
    "ec2_snapshot",
    "ec2_vol",
    "ec2_vpc_net",
    "ec2_vpc_subnet",
    "s3_bucket",

    # Files

    "acl",
    "assemble",
    "blockinfile",
    "copy",
    "fetch",
    "file",
    "find",
    "lineinfile",
    "stat",
    "synchronize",
    "template",
    "unarchive",

    # Inventory

    "add_host",
    "group_by",

    # Net_Tools

    "get_url",
    "slurp",
    "uri",

    # Language

    "pip",

    # Os

    "apt",
    "apt_key",
    "apt_repository",
    "dnf",
    "package",
    "rpm_key",
    "yum",
    "yum_repository",

    # Source_Control

    "git",
    "subversion",

    # System

    "at",
    "authorized_key",
    "debconf",
    "getent",
    "group",
    "iptables",
    "mount",
    "ping",
    "seboolean",
    "selinux",
    "service",
    "setup",
    "sysctl",
    "systemd",
    "user",

    # Logic

    "assert",
    "async_status",
    "debug",
    "fail",
    "import_playbook",
    "import_role",
    "import_tasks",
    "include",
    "include_role",
    "include_tasks",
    "include_vars",
    "pause",
    "set_fact",
    "wait_for",
    "wait_for_connection",
)

def json2dhall(json_type: str, items_type: str) -> str:
    dhall_type = 'Text'
    if json_type == 'integer':
        dhall_type = 'Natural'
    if json_type == 'boolean':
        dhall_type = 'Bool'
    if json_type == 'array':
        dhall_type = '(List ' + json2dhall(items_type, '') + ')'
    return dhall_type

types = set()
for module_name in module_list:
    module = ansible[module_name]
    module_type = []
    for attr, attr_type in module['properties'].items():
        types.add(attr_type['type'])
        optional = 'Optional ' if attr not in module['required'] else ''
        module_type.append(attr + ' : ' + optional +
                           json2dhall(attr_type['type'], attr_type.get('items', {}).get('type', '')))
    with(open('types/modules/' + module_name + '.dhall', 'w')) as of:
        if not module_type and module_name == 'ping':
            # fix empty def
            module_type = ['data: Optional Text']
        of.write("{" + ', '.join(module_type) + "}")

#    print(ansible[module])

print(types)
