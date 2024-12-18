#!/bin/bash

mount="$1"

apt-get update
echo Filesystem type \"none\" given. Assuming that filesystem is already mounted at $mount.