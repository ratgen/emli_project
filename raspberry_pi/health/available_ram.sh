#!/bin/bash

echo $(free | grep "Mem" | awk '{ print $7/$2 * 100 }' | cut -c -5 | sed -e 's/,/./g')
