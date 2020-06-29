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

# First download: https://raw.githubusercontent.com/SchemaStore/schemastore/master/src/schemas/json//ansible-stable-2.9.json
import json
import typing

ansible = json.loads(open("ansible-stable-2.9.json").read())['items']['anyOf'][-1]['properties']

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

    # Openstack

    "os_keypair",
    "os_network",
    "os_router",
    "os_security_group",
    "os_security_group_rule",
    "os_server",
    "os_server_volume",
    "os_subnet",
    "os_volume",

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
    "cron",
    "dnf",
    "package",
    "pacman",
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
    "luks_device",
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
    "pause",
    "wait_for",
    "wait_for_connection",
)

# Unfortunate workarounds because the json schemas are incomplete
Workarounds = dict(
    aws_s3=dict(required=["bucket", "mode"]),
    ec2=dict(required=["image", "instance_type"]),
    ec2_vpc_net=dict(required=["cidr_block", "name"]),
    ec2_vpc_subnet=dict(required=["vpc_id"]),
    copy=dict(required=["dest"]),
    get_url=dict(required=["dest", "url"]),
    git=dict(required=["dest", "repo"]),
    mount=dict(required=["state", "path"]),
    os_server=dict(required=["image", "name"]),
    rpm_key=dict(required=["key"]),
    s3_bucket=dict(required=["name"]),
    seboolean=dict(required=["name", "state"]),
    selinux=dict(required=["state"]),
    service=dict(required=["name"]),
    stat=dict(required=["path"]),
    subversion=dict(required=["dest", "repo"]),
    uri=dict(required=["url"]),
    yum_repository=dict(required=["name"]),
    yum=dict(
        required=["name"],
        types=dict(name='List Text')),
    dnf=dict(
        types=dict(name='List Text')),
    ping=dict(
        props=[('data', {})],
        types=dict(data='Text')),
)
Workarounds["assert"] = dict(required=["that"])

def json2dhall(json_type: str, items_type: str) -> str:
    dhall_type = 'Text'
    if json_type == 'integer':
        dhall_type = 'Natural'
    if json_type == 'boolean':
        dhall_type = 'Bool'
    if json_type == 'array':
        dhall_type = '(List ' + json2dhall(items_type, '') + ')'
    return dhall_type


def ref2json(ref_name: str) -> typing.Dict[str, typing.Any]:
    if ref_name == '#/definitions/ansible_truth':
        return dict(type='boolean')
    elif ref_name == '#/definitions/ansible_number':
        return dict(type='integer')
    elif ref_name == '#/definitions/ansible_array':
        return dict(type='array', items=dict(type='text'))
    raise Exception('unknown ref: ' + ref_name)


def object2require(object : typing.Dict[str, typing.Any]) -> typing.List[str]:
    for one_of in object.get('oneOf', []):
        if one_of.get('required'):
            return one_of['required']
        sub_one_of = object2require(one_of)
        if sub_one_of:
            return sub_one_of
    for all_of in object.get("allOf", []):
        sub_all_of = object2require(all_of)
        if sub_all_of:
            return sub_all_of
    return []


def attr2name(attr: str) -> str:
    # TODO: add all reserved keywords
    reservedKeywords = {"assert", "as"}
    if attr in reservedKeywords:
        return "`%s`" % attr
    return attr


if __name__ == "__main__":
    for module_name in module_list:
        module = ansible[module_name]
        module_type = []
        if module_name in Workarounds and Workarounds[module_name].get('required'):
            module_requires = Workarounds[module_name]['required']
        elif module.get('required'):
            module_requires = module['required']
        elif module.get('allOf'):
            module_requires = object2require(module)
        else:
            module_requires = []
        attr_workarounds = Workarounds.get(module_name, {}).get('types', {})
        for attr, attr_type in Workarounds.get(module_name, {}).get('props', module['properties'].items()):
            if attr_type.get('$ref'):
                attr_type = ref2json(attr_type['$ref'])
            if attr in attr_workarounds:
                attr_value = attr_workarounds[attr]
            else:
                attr_value = json2dhall(attr_type['type'], attr_type.get('items', {}).get('type', ''))
            optional = 'Optional ' if attr not in module_requires else ''
            module_type.append(attr2name(attr) + ' : ' + optional + attr_value)
        with(open('types/modules/' + module_name + '.dhall', 'w')) as of:
            of.write("{" + ', '.join(sorted(module_type)) + "}")
