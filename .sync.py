#!/usr/bin/env python3
import os
from os.path import \
    isdir, isfile, islink, lexists, \
    abspath, relpath, join


HOME = os.path.expanduser('~')


def configs():
    sub_roots = []
    for name in os.listdir():
        if name.startswith('.'):
            continue
        if isfile(name):
            yield relpath(name)
        elif isdir(name):
            sub_roots.append(name)
    for sub_root in sub_roots:
        yield from (
            relpath(join(sub_root, name))
            for name in os.listdir(sub_root)
            if not name.startswith('.')
        )


def update_symlink(name):
    link = join(HOME, '.' + name)
    config = abspath(name)
    if (isfile(link) or isdir(link)) and not islink(link):
        os.rename(link, link + '.old')
    elif lexists(link):
        if os.readlink(link) == config:
            return
        os.unlink(link)
    os.symlink(config, link)
    print('symlink', link, 'to', config, 'created')


if __name__ == '__main__':
    for name in configs():
        update_symlink(name)
