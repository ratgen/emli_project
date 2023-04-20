#!/bin/bash

sudo df -H | grep "$1" | awk '{ print $5}'
