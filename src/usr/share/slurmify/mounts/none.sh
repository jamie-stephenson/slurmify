#!/bin/bash

fs="$1"

apt-get update
echo Filesystem type "none" given. Assuimg that filesystem is alread mounted at ${fs[mount]}.