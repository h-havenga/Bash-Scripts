#!/bin/bash
# This is quite a complicated script to keep track off.
# Do sudo apt install cdo gmt\* axel wget ncl-ncarg for good measure

gfs=http://www.ftp.ncep.noaa.gov/data/nccf/com/gfs/prod/gfs

# Since June this is needed to work with gfs data. There are two
# identical variables in the data (I think ACPCP or something like
# that)
export CDI_INVENTORY_MODE=time

# Define what data you need
#date=$(date +"%Y%m%d" -d "yesterday")
date=$(date +"%Y%m%d")
#initial=06
forecast=06
initial=06
#forecast=00


# Loop through the specified forecast times wanted and grab GFS data
for i in $forecast
do
    axel -a $gfs.$date/$initial/atmos/gfs.t$initial\z.pgrb2.0p25.f0$i
done

echo "
#######################################################################
                                Starting Plots
#######################################################################"

# For archive purposes we clip the data to South-Africa with cdo
# and convert GFS files to workable netcdf files
for i in "${forecast[@]}"  
do 
    cdo -sellonlatbox,-180,180,-95,0 gfs.t$initial\z.pgrb2.0p25.f0$i gfs.$date.$i &
done

wait

for i in "${forecast[@]}"  
do 
    cdo -f nc4c copy gfs.$date.$i ncfile$i.nc & 
done

wait

# Move clipped GFS files to an archive directory 
mkdir -p "gfs_archive/gfs_$date/00h"
mv gfs.* gfs_archive/gfs_$date/00h

# Extract variables from the NC files for easy use in GMT
for i in "${forecast[@]}" 
do
    cdo selname,gh ncfile$i.nc geopotential$i.nc & 
done

wait

for i in "${forecast[@]}" 
do
    cdo splitlevel geopotential$i.nc geopotential$i- & 
done

wait

for i in "${forecast[@]}" 
do
    mv geopotential$i-050000* zg500$i.nc 
    rm geopotential$i*
done

# To plot the files in GMT we need to get the variables from the newly 
# created netcdf files by extracting only the variable we want.
for i in "${forecast[@]}" 
do
    gmt grdconvert ncfile$i.nc\?prmsl -Gmslp_nrm$i.nc &
    gmt grdconvert zg500$i.nc\?gh     -Gzg500_nrm$i.nc &
    gmt grdconvert ncfile$i.nc\?cape  -Gcape$i.nc &
    gmt grdconvert ncfile$i.nc\?aptmp -Gaptmp$i.nc &
    gmt grdconvert ncfile$i.nc\?pwat  -Gpwat$i.nc &
    gmt grdconvert ncfile$i.nc\?refc  -Grefc$i.nc &
done

wait

# Do some math
# We standardize the pressure and convert Kelvin to Celsius
# Make CAPE values below 200 NAN
# Make radar reflectivity below 10dbz NAN
for i in "${forecast[@]}" 
do
    gmt grdmath mslp_nrm$i.nc 100 DIV = mslp_nrm$i     &
    gmt grdmath zg500_nrm$i.nc 10 DIV = zg500_nrm$i.nc &    
    gmt grdmath aptmp$i.nc 273.15 SUB = aptmp$i.nc     &
    gmt grdclip cape$i.nc -Sb200/NaN -Gcape$i.nc       &
    gmt grdclip refc$i.nc -Sb10/NaN -Grefc$i.nc        &
done

wait 

for i in "${forecast[@]}" 
do
    gmt grdfilter mslp_nrm$i -Gmslp_nrm$i.nc -D0.50 -Fc3 &
done

wait

echo "
#######################################################################
                                Be Patient
#######################################################################"

            ######################################
            #        Synoptic Plots              #
            ######################################

# Coordinates (actually lower left and upper right not E S W N) 
# Projection (Lambert Azimuthal Equal-Area)
coord=(-20/-46/60/-12r)
width=25.5

# Make all the colormaps
    gmt makecpt    -Cviridis -T0/75/5        > radar.cpt
    gmt makecpt    -Cabyss -T0/80/5 -I -Z    > precip.cpt
    gmt makecpt    -Chot -T250/2750/50 -Z -I > cape.cpt
    gmt makecpt    -Cjet -T-8/43/1 -Z 	     > aptmp.cpt
    gmt makecpt    -Cabyss -T0/80/5 -I -Z    > precip.cpt

# Radar Reflectivity, zg500 and mslp
for i in "${forecast[@]}" 
do
    gmt psbasemap  -R$coord -JA25/-30/$width -Xc -Yc -Ba0 -K                                                     > radar_map$i.ps
    gmt pscoast    -R -JA -Df -N1 -G200 -W -O -K                                                                >> radar_map$i.ps
    gmt grdimage   -R refc$i.nc -Cradar.cpt -J -O -Q -K                                                         >> radar_map$i.ps  
    gmt grdcontour -R -JA -Wthick,-- mslp_nrm$i.nc -C2 -A2+f10 -T+lLH -O -K                                     >> radar_map$i.ps
    gmt grdcontour -R -JA -Wthickest,black zg500_nrm$i.nc -S150 -C10 -A20+f14 -Gn1 -T+lLH -O -K                 >> radar_map$i.ps
    gmt psxy        ZAF_adm1.gmt -R -JA -O -Wfaint -V -K                                                        >> radar_map$i.ps
    gmt psscale    -Cradar.cpt -R -J -Dx12.25c/-1c+w12c/0.5c+jTC+h -Bx5+l"Composite reflectivity" -By+ldB -O -K >> radar_map$i.ps
    echo "65 -45 Valid $date 0600z" | gmt pstext -R -JA -O -F+jTR+f16 -T -Gwhite -W1p -Dj0.1                    >> radar_map$i.ps
done

# Pwat, zg500 and mslp
for i in "${forecast[@]}" 
do
    gmt psbasemap  -R$coord -JA25/-30/$width -Xc -Yc -Ba0 -K    		  > pwat_map$i.ps
    gmt grdimage   -R pwat$i.nc -Cprecip.cpt -J -O -Q -K        		 >> pwat_map$i.ps  
    gmt pscoast    -R -JA -Df -N1 -W -O -K                      		 >> pwat_map$i.ps
    gmt grdcontour -R -JA -Wthick,-- mslp_nrm$i.nc -C2 -A2+f10 -T+lLH -O -K      >> pwat_map$i.ps
    gmt grdcontour -R -JA -Wthickest,black zg500_nrm$i.nc -S150 -C10 -A20+f14 -Gn1 -T+lLH -O -K >> pwat_map$i.ps
    gmt psxy        ZAF_adm1.gmt -R -JA -O -Wfaint -V -K >> pwat_map$i.ps
    gmt psscale    -Cprecip.cpt -R -J -Dx12.25c/-1c+w12c/0.5c+jTC+h -Bx10+l"Precipitable Water" -By+l'kg m**-2' -O -K >> pwat_map$i.ps
    echo "65 -45 Valid $date 0600z" | gmt pstext -R -JA -O -F+jTR+f16 -T -Gwhite -W1p -Dj0.1 >> pwat_map$i.ps
done

# CAPE, zg500 and mslp
for i in "${forecast[@]}" 
do
    gmt psbasemap  -R$coord -JA25/-30/$width -Xc -Yc -Ba0 -K                    > cape_map$i.ps
    gmt pscoast    -R -JA -Df -N1 -G200 -W -O -K                                                   >> cape_map$i.ps
    gmt grdimage   -R cape$i.nc -Ccape.cpt -J -O -Q -K                                             >> cape_map$i.ps  
    gmt grdcontour -R -JA -Wthick,-- mslp_nrm$i.nc -C2 -A2+f10 -T+lLH -O -K    			   >> cape_map$i.ps
    gmt grdcontour -R -JA -Wthickest,black zg500_nrm$i.nc -S150 -C10 -A20+f14 -Gn1 -T+lLH -O -K    >> cape_map$i.ps
    gmt psxy        ZAF_adm1.gmt -R -JA -O -Wfaint -V -K 					   >> cape_map$i.ps
    gmt psscale    -Ccape.cpt -R -J -Dx12.25c/-1c+w12c/0.5c+jTC+h -Bx250+l"CAPE J/Kg" -By+lJ/kg -K -O >> cape_map$i.ps
    echo "65 -45 Valid $date 0600z" | gmt pstext -R -JA -O -F+jTR+f16 -T -Gwhite -W1p -Dj0.1       >> cape_map$i.ps
done

# Temperature, zg500 and mslp
for i in "${forecast[@]}" 
do
    gmt psbasemap  -R$coord -JA25/-30/$width -Xc -Yc -Ba0 -K > aptmp_map$i.ps
    gmt grdimage   -R aptmp$i.nc -Captmp.cpt -J -O -Q -K >> aptmp_map$i.ps  
    gmt pscoast    -R -JA -Df -N1 -W -O -K >> aptmp_map$i.ps
    gmt grdcontour -R -JA -Wthick,-- mslp_nrm$i.nc -C2 -A2+f10 -T+lLH -O -K >> aptmp_map$i.ps
    gmt grdcontour -R -JA -Wthickest,black zg500_nrm$i.nc -S150 -C10 -A20+f14 -Gn1 -T+lLH -O -K >> aptmp_map$i.ps
    gmt psxy        ZAF_adm1.gmt -R -JA -O -Wfaint -V -K >> aptmp_map$i.ps
    gmt psscale    -Captmp.cpt -R -J -Dx12.25c/-1c+w12c/0.5c+jTC+h -Bx5+l"Temperature" -By+lCelcius -O -K >> aptmp_map$i.ps
    echo "65 -45 Valid $date 0600z" | gmt pstext -R -JA -O -F+jTR+f16 -T -Gwhite -W1p -Dj0.1 >> aptmp_map$i.ps
done

# Zg500 and mslp (Traditional Synoptic Map)
for i in "${forecast[@]}" 
do
    gmt psbasemap  -R$coord -JA25/-30/$width -Xc -Yc -Ba0 -K > synoptic$i.ps
    gmt pscoast    -R -JA -Df -N1 -G200 -W -O -K >> synoptic$i.ps
    gmt grdcontour -R -JA -Wthick,-- mslp_nrm$i.nc -C2 -A2+f10 -T+lLH -O -K >> synoptic$i.ps
    gmt grdcontour -R -JA -Wthickest,black zg500_nrm$i.nc -S150 -C10 -A20+f14 -Gn1 -T+lLH -O -K >> synoptic$i.ps
    gmt psxy        ZAF_adm1.gmt -R -JA -O -Wfaint -V -K >> synoptic$i.ps
    echo "65 -45 Valid $date 0600z" | gmt pstext -R -JA -O -F+jTR+f16 -T -Gwhite -W1p -Dj0.1 >> synoptic$i.ps
done

            ######################################
            #        General Circulation          #
            ######################################

# Southern Hemisphere mslp
for i in "${forecast[@]}" 
do
    gmt psbasemap  -R-180/180/-90/-15 -Js0/-90/6.8/-30 -Xc -Y0.8 -Baf30 -B+t"Mean Sea Level Pressure" -K > sohemp$i.ps
    gmt pscoast    -R -Js -Df -N1 -G200 -W -O -K >> sohemp$i.ps
    gmt grdcontour -R -Js -Wthick mslp_nrm$i.nc -C4 -A4+f6 -T+lLH -O >> sohemp$i.ps
done

# Southern Hemisphere zg500
for i in "${forecast[@]}" 
do
    gmt psbasemap  -R-180/180/-90/-15 -Js0/-90/6.8/-30 -Xc -Y0.8 -Baf30 -B+t"Geopotential at 500hPa" -K > zg500_sohemp$i.ps
    gmt pscoast    -R -Js -Df -N1 -G200 -W -O -K >> zg500_sohemp$i.ps
    gmt grdcontour -R -Js -Wthickest,black zg500_nrm$i.nc -S150 -C10 -A20+f4 -Gn1 -T+lLH -O >> zg500_sohemp$i.ps
done

# Southern Hemisphere Precipitable water
for i in "${forecast[@]}" 
do
    gmt psbasemap  -R-180/180/-90/-15 -Js0/-90/6.7/-30 -Xc -Y0.8 -Baf30 -B+t"Precipitable Water" -K > pwat_sohemp$i.ps
    gmt grdimage   -R -Js pwat$i.nc -Cprecip.cpt -Q -O -K >> pwat_sohemp$i.ps  
    gmt pscoast    -R -Js -Df -N1 -G -W -O -K >> pwat_sohemp$i.ps
    gmt psscale    -Cprecip.cpt -R -J -D19c/9c/12c/1c -Bx10+l"Precipitable Water" -By+l'kg m**-2' -O >> pwat_sohemp$i.ps
done

# convert ps to png
for i in "${forecast[@]}" 
do
    gmt psconvert   radar_map$i.ps -A -P -Tg &
    gmt psconvert   pwat_map$i.ps -A -P -Tg &
    gmt psconvert   cape_map$i.ps -A -P -Tg &
    gmt psconvert   aptmp_map$i.ps -A -P -Tg &
    gmt psconvert   synoptic$i.ps -A -P -Tg &
    gmt psconvert   pwat_sohemp$i.ps -A -P -Tg &
    gmt psconvert   zg500_sohemp$i.ps -A -P -Tg &
    gmt psconvert   sohemp$i.ps -A -P -Tg &
done

wait

echo "
#######################################################################
                              Getting SAWS
#######################################################################"

today=$(date +"%Y%m%d_%H")

echo "
#######################################################################
A simple command line utility to download the most current SAWS
synoptic map. SAWS does not have a readily available archive.
Also note that the map downloaded is only what is on the SAWS server
currently, it might be outdated.
#######################################################################"

echo

wget https://www.weathersa.co.za/images/data/specialised/ma_sy.gif
mv ma_sy.gif saws_$today.gif

echo "
#######################################################################
                              Getting EUMETSAT
#######################################################################"
echo

wget https://eumetview.eumetsat.int/static-images/latestImages/EUMETSAT_MSG_RGBNatColourEnhncd_SouthernAfrica.jpg
mv EUMETSAT_MSG_RGBNatColourEnhncd_SouthernAfrica.jpg EUMETSAT_$today.jpg

# Move ps, gif and update site 
mkdir -p "png/$date"
mogrify -strip -resize 50% -alpha remove *.png
mv *png *gif *jpg png/$date
rm *ps 

# The data is quite big, because the netcdf files are a product of the
# gfs files you can remove all netcdf files and compress the gfs
# file for archive purposes.
rm *.nc

rsync /home/

echo "
#######################################################################
                              Done
#######################################################################"
echo

exit 0
