#!/bin/bash

set -x

sudo groupadd msr
sudo chgrp msr /dev/cpu/*/msr
sudo ls -l /dev/cpu/*/msr
sudo chmod g+rw /dev/cpu/*/msr
sudo usermod -aG msr hand32
sudo newgrp msr

