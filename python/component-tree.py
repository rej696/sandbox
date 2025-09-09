from pathlib import Path
import subprocess
from pprint import pprint as pp
import sys
import os
import re
import copy
from dataclasses import dataclass


def get_tree(deployment):
    root = os.getcwd()
    init = deployment / "inc" / "init"
    os.chdir(deployment / "inc" / "init")
    # print(root)
    # print(init)
    result = subprocess.run(
        # ["tree", "|", "sed", "'s/_Init.h//'", "|", "grep", "-v", "'\\.h'"],
        ["tree"],
        capture_output=True,
        text=True,
    )
    os.chdir(root)
    if result.returncode == 0:
        # print(result.stdout)
        return result.stdout
    print(f"Failed to run tree (status: {result.returncode}) (stdout: {result.stdout}) (stderr: {result.stderr})")
    sys.exit(-1)
    return tree


def get_paths(base: str = "."):
    base = str(base)
    basename = base if base[-1] == "/" else base + "/"
    for root, dirs, files in os.walk(base):
        rel_root = root.replace(f"{base}/", "")
        root_path = rel_root.split("/")[:]
        for file in files:
            if not re.search(r"_Init.h$", file):
                continue

            name = re.sub(r"_Init\.h", r"", file)
            path = copy.deepcopy(root_path)
            path.append(name)

            yield path


def paths2names(paths):
    for path in paths:
        yield ".".join(path)


@dataclass
class Component:
    name: str
    type: str


class PartialMatchException(Exception):
    pass


def match_components(deployment_file):
    with open(deployment_file, "r") as f:
        for line in f.readlines():
            name_match = re.search(r'name="([\w\.]*?)"', line)
            type_match = re.search(r'type="([\w\.]*?)"', line)
            if name_match and type_match:
                yield Component(name=name_match.group(1), type=type_match.group(1))
            elif (
                "<Component " in line
                and (not re.search(r'component="[\w\.]*?"', line))
                and (name_match or type_match)
            ):
                print(f"Partial Match: {line}", file=sys.stderr)

def components2dict(components):
    return


def update_tree(tree, components):
    map = {c.name.split('.')[-1]: c.type for c in components}

    for line in tree.split('\n'):
        match = re.search(r"(\w+)_Init\.h", line)
        if match:
            name = match.group(1)
            new_line = line.replace("_Init.h", "")
            yield f"{new_line}: {map[name]}"
            continue
        yield line


if __name__ == "__main__":
    if len(sys.argv) != 2:
        sys.exit(-1)

    deployment = Path(sys.argv[1])
    tree = get_tree(deployment)
    components = match_components(deployment / "deployment.xml")
    new_tree = update_tree(tree, components)
    for line in new_tree:
        print(line)
