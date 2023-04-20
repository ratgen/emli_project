curl -s https://kjen.dk/courses/emli/co2/ | jq '.[] | .co2' | sed -z 's/\n/,/g;s/,$/\n/' | ./graph.py
