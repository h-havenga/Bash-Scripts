#!/bin/bash

# There are some datasources that limit the number of files to download.
# The easiest for me is to make a embed the python loop inside bash and download
# the data recursively

year=( 2017 2018 )
month=( 01 02 03 04 05 06 07 08 09 10 11 12 )
day=( 01 02 03 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23
24 25 26 27 28 29 30 31 )

for y in ${year[@]}
do
	for m in ${month[@]}
	do
		for d in ${day[@]}
		do
	python3 - << EOF
import cdsapi
	
c = cdsapi.Client()

c.retrieve(
    'sis-agrometeorological-indicators',
    {
        'variable': '2m_temperature',
        'statistic': [
            '24_hour_maximum', '24_hour_minimum',
        ],
        'year':  '$y',
        'month': '$m',
        'day':   '$d',
        'format': 'zip',
    },
    'AGRITemperature_$y$m$d.zip')
EOF
done
done
done

exit
