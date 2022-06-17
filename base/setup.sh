device="/dev/ttyACM0" 
protocol=27
enabled_constellations="GPS"
disabled_constellations="GLONASS BEIDOU GALILEO SBAS" 

ubx=ubxtool --device=$device -P $protocol 








