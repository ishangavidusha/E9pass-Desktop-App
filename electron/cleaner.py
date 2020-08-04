#!/usr/bin/env python3
import os
import sys
import shutil


RM_PATHS = ['build', 'dist-python', 'E9pass Manager-cache', 'installer']
files = ['fileApi.spec']

def main():
    for path in RM_PATHS:
        if os.path.isdir(path):
            shutil.rmtree(path)
        else:
            pass
    for item in files:
        if os.path.isfile(item):
            os.remove(item)
        else:
            pass


if __name__ == '__main__':
    main()