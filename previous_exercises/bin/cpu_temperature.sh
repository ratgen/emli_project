#!/bin/bash

echo $(vcgencmd measure_temp | grep --only-matching -e '[0-9]*\.[0-9]*')
