#!/bin/bash
# Download the Global in-siute land surface atmospheric variables in a loop. 

year=$(echo {1860..2022})
month=$(echo {01..12})

for y in $year
do
        for m in $month
        do
        python3 << EOF 
import cdsapi
c = cdsapi.Client()

c.retrieve(
    'insitu-observations-surface-land',
    {
        'format': 'zip',
        'time_aggregation': 'daily',
        'variable': [
            'accumulated_precipitation', 'air_temperature', 'fresh_snow',
            'snow_depth', 'snow_water_equivalent', 'wind_from_direction',
            'wind_speed',
        ],
        'usage_restrictions': [
            'restricted', 'unrestricted',
        ],
        'data_quality': 'passed',
        'year': '$y',
        'month':'$m',
        'day': [
            '01', '02', '03',
            '04', '05', '06',
            '07', '08', '09',
            '10', '11', '12',
            '13', '14', '15',
            '16', '17', '18',
            '19', '20', '21',
            '22', '23', '24',
            '25', '26', '27',
            '28', '29', '30',
            '31',
        ],
        'area': [
            -10, 15, -35,
            45,
        ],
    },
    '$y\_$m.zip')
EOF
done
done

year=$(echo {1860..2022})
month=$(echo {01..12})


for y in $year
do
        for m in $month
        do
	    unzip $y\\_$m.zip
        done
done

rm *data-policy*
cat surface-land_daily_1979-01-01_1979-01-31_subset_csv-obs_34368365_v1.csv | head -1 > SA_ECMWFOPS.csv
less surface-land_daily_*.csv | grep "SF" >> SA_ECMWFOPS.csv
rm surface-land_daily*csv 

exit 0
