#!/usr/local/bin/python
import sys
import os


def log(*args, **kwargs):
    print(*args, **kwargs, file=sys.stderr)
    sys.stderr.flush()


env = {}

while 1:
    line = sys.stdin.readline().strip()

    if line == '':
        break
    key, data = line.split(':')
    if key[:4] != 'agi_':
        sys.stderr.write("Did not work!\n")
        sys.stderr.flush()
        continue
    key = key.strip()
    data = data.strip()
    if key != '':
        env[key] = data

log('------ENV\'S---------')
for k, v in env.items():
    log(k, '=', v)
log('---------------')


def play_file(file_name):
    log('Play file')
    sys.stdout.write("STREAM FILE rec \"\"\n")
    sys.stdout.flush()
    result = sys.stdin.readline().strip()
    log('CMD_RESULT <<', result)


play_file('rec')

log('-----END-----')
