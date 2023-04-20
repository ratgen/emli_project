#/bin/bash 

echo $(ifconfig $1 | grep "TX packets" | grep --only-matching -e "(.*)" | sed -e 's/(//g' | sed -e 's/)//g' )
