echo "16" > /sys/class/gpio/export 
sleep 0.05
echo "in" > /sys/class/gpio/gpio16/direction

cat /sys/class/gpio/gpio16/value

echo "16" > /sys/class/gpio/unexport
