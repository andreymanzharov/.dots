#!/usr/bin/env python3
import os
import os.path


HOME = os.path.expanduser('~')


def configs():
    sub_roots = []
    for name in os.listdir():
        if name.startswith('.'):
            continue
        if os.path.isfile(name):
            yield os.path.relpath(name)
        elif os.path.isdir(name):
            sub_roots.append(name)
    for sub_root in sub_roots:
        yield from (
            os.path.relpath(os.path.join(sub_root, name))
            for name in os.listdir(sub_root)
            if not name.startswith('.')
        )

def update_symlink(name):
    link = os.path.join(HOME, '.' + name)
    if (os.path.isfile(link) or os.path.isdir(link)) and not os.path.islink(link):
        os.rename(link, link + '.old')
    elif os.path.lexists(link):
        os.unlink(link)
    config = os.path.abspath(name)
    os.symlink(config, link)
    print('symlink', link, 'to', config, 'created')


if __name__ == '__main__':
    for name in configs():
        update_symlink(name)

