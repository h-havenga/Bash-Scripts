#!/bin/bash

#########################################
#           Get GFS Data                #
#########################################
# Copy the newest gfsdata from the gfsruns under ~/gfsforecast here
echo "
############################
##     Getting GFS data    #
############################"

echo

# Remove any old GFS files
rm GFS/*

# Copy new files 
# Sometimes GFS scripts stops before moving files to the correct path
#cp -v ~/gfs_forecast/gfs.t00z.pgrb2.0p25* GFS/ &
#cp -v ~/gfs_forecast/gfs_archive/gfs_$today/00h/gfs.t00z.pgrb2.0p25* GFS/ &

today=$(date +"%Y%m%d")
gfs=https://ftp.ncep.noaa.gov/data/nccf/com/gfs/prod/gfs
forecast=(00 02 04 06 08 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40 42 44 46 48 50 52 54 56 58 60)
for i in "${forecast[@]}" 
do 
    axel -a $gfs.$today/00/atmos/gfs.t00z.pgrb2.0p25.f0$i & 
done

wait

mv gfs.t00z.pgrb2.0p25* GFS/

# Remove all incomplete GFS files
rm GFS/*st

#########################################
#           Edit namelists              #
#########################################
# Edit the WPS file and get the newest dates
today=$(date +"%Y-%m-%d")
tomorrow=$(date --date="2 days" +"%Y-%m-%d")

echo "&share
 wrf_core = 'ARW',
 max_dom = 1,
 start_date = '${today}_12:00:00', 
 end_date   = '${tomorrow}_12:00:00', 
 interval_seconds = 7200,
 io_form_geogrid = 2,
 debug_level = 0,
/

&geogrid
 parent_id         = 1,
 parent_grid_ratio = 1,
 i_parent_start    = 1,
 j_parent_start    = 1,
 e_we          = 100,
 e_sn          = 91,
 geog_data_res = 'default',
 dx = 33000,
 dy = 33000,
 map_proj =  'mercator',
 ref_lat   = -28.344,
 ref_lon   = 25.064,
 truelat1  = -28.344,
 truelat2  = 0,
 stand_lon = 25.064,
 geog_data_path = '../WPS_GEOG'
 ref_x = 50.0,
 ref_y = 45.5,
/

&ungrib
 out_format = 'WPS',
 prefix = 'FILE',
/

&metgrid
 fg_name = 'FILE'
 io_form_metgrid = 2,
/
" > WPS/namelist.wps

# Next change the namelist in WRF
year=$(date   +"%Y")
month=$(date  +"%m")
today=$(date  +"%d")

tyear=$(date  --date="2 days" +"%Y")
tmonth=$(date --date="2 days" +"%m")
tday=$(date   --date="2 days" +"%d")

echo "&time_control
 run_days                            = 0,
 run_hours                           = 48,
 run_minutes                         = 0,
 run_seconds                         = 0,
 start_year                          = $year,
 start_month                         = $month,
 start_day                           = $today,
 start_hour                          = 12,
 start_minute                        = 00,
 start_second                        = 00,
 end_year                            = $tyear,
 end_month                           = $tmonth,
 end_day                             = $tday,
 end_hour                            = 12,
 end_minute                          = 00,
 end_second                          = 00,
 interval_seconds                    = 7200,
 input_from_file                     = .true.,
 history_interval                    = 5,
 frames_per_outfile                  = 1,
 restart                             = .false.,
 restart_interval                    = 120,
 io_form_history                     = 2
 io_form_restart                     = 2
 io_form_input                       = 2
 io_form_boundary                    = 2
 nwp_diagnostics                     = 1
 debug_level                         = 0
/

&domains
 time_step                           = 180,
 time_step_fract_num                 = 0,
 time_step_fract_den                 = 1,
 max_dom                             = 1,
 e_we                                = 100,
 e_sn                                = 91,
 e_vert                              = 36,
 p_top_requested                     = 5000,
 num_metgrid_levels                  = 34,
 num_metgrid_soil_levels             = 4,
 dx                                  = 33000,
 dy                                  = 33000,
 grid_id                             = 1,
 parent_id                           = 0,
 i_parent_start                      = 1,
 j_parent_start                      = 1,
 parent_grid_ratio                   = 1,
 parent_time_step_ratio              = 1,
 feedback                            = 1,
 smooth_option                       = 0
/

&physics
 mp_physics                          = 6,    -1,    -1,
 cu_physics                          = 1,    -1,     0,
 ra_lw_physics                       = 3,    -1,    -1,
 ra_sw_physics                       = 3,    -1,    -1,
 bl_pbl_physics                      = 1,    -1,    -1,
 sf_sfclay_physics                   = 1,    -1,    -1,
 sf_surface_physics                  = 2,    -1,    -1,
 radt                                = 30,    30,    30,
 bldt                                = 0,     0,     0,
 cudt                                = 5,     5,     5,
 icloud                              = 1,
 num_land_cat                        = 21,
 sf_urban_physics                    = 0,     0,     0,
 do_radar_ref                        = 1,

/

&fdda
/

&afwa
 afwa_diag_opt			 = 1,
 afwa_ptype_opt  		 = 1,
 afwa_severe_opt    	   	 = 1,
 afwa_vil_opt       	   	 = 1,
 afwa_radar_opt     	   	 = 1,
 afwa_icing_opt     	   	 = 1,
 afwa_vis_opt       	   	 = 1,
 afwa_cloud_opt     	   	 = 1,
 afwa_therm_opt     	   	 = 1,
 afwa_turb_opt      	   	 = 1,
 afwa_buoy_opt      	   	 = 1,
 afwa_ptype_ccn_tmp 		 = 268.15,
 afwa_ptype_tot_melt         = 25,
/

&dynamics
 hybrid_opt                  = 2,
 w_damping                   = 1,
 diff_opt                    = 12      1,      1,
 km_opt                      = 4,      4,      4,
 diff_6th_opt                = 0,      0,      0,
 diff_6th_factor             = 0.12,   0.12,   0.12,
 base_temp                   = 290.
 damp_opt                    = 3,
 zdamp                       = 5000.,  5000.,  5000.,
 dampcoef                    = 0.2,    0.2,    0.2
 khdif                       = 0,      0,      0,
 kvdif                       = 0,      0,      0,
 non_hydrostatic             = .true., .true., .true.,
 moist_adv_opt               = 1,      1,      1,
 scalar_adv_opt              = 1,      1,      1,
 gwd_opt                     = 1,
/

&bdy_control
 spec_bdy_width              = 5,
 specified                   = .true.
/

 &grib2
/

&namelist_quilt
 nio_tasks_per_group = 0,
 nio_groups = 1,
/
" > WRF/run/namelist.input

###################################################
# Now run WPS first
echo "
###########################
#	Running WPS       #
###########################"

echo

# Go to the WPS directory
cd WPS

# Remove old files
rm PFILE:* FILE:* met_em* geo_em* 

# Link to the GFS archive where the GFS data lies
# And explicitly say which data we use (Vtable)
./link_grib.csh ../GFS/
ln -sf ungrib/Variable_Tables/Vtable.GFS Vtable

# First run geogrid to define the landuse
# Run this once. Once the geom_em file is created you
# do not need to run it again, unless you delete it
if [ -e geo_em.d01.nc ]; then
    echo "File exists"
else 
    ./geogrid.exe
fi 

# Now run ungrib.exe
./ungrib.exe

# Now run metgrid.exe
./metgrid.exe

# Remove reduntant files
rm PFILE:* FILE:*  
rm ../GFS/*
####################################################
####################################################
# Now we run can run WRF if WPS was a sucess
echo "
###########################
#	Running WRF       #
###########################"

echo

# Go to run directory
cd ../WRF/run

# Remove old wrf runs
rm wrfinput_d01 wrfbdy_01 met_em* wrfout_d01_* wrfrst_d01*

# First link to the new met_em files
ln -sf ../../WPS/met_em.d0* .

# Now run real.exe
./real.exe

# Now run wrf.exe using 36 processors
mpirun -n 36 ./wrf.exe

echo "
###########################
#	WRF Done          #
###########################"

echo

echo "
###########################
#	Plotting          #
###########################"

echo

wrf=$(ls wrfout_d01_????-??-??_??:00:00*)

################################
# Get the data ready for plotting in GMT. We have to convert the data
# using CDO as GMT as troubles with WRF's native grid. The data is
# converted to a Cartesian system, which is actually very convenient
# and means we can even use R later for plotting.
################################
for i in $wrf
do
    cdo selname,TSK       $i k_$i &
    cdo selname,WSPD10MAX $i w_$i &
    cdo selname,AFWA_CAPE $i cp_$i &
    cdo selname,REFD_COM  $i rf_$i &
    cdo selname,RAINC     $i rn_$i &
    cdo selname,RAINNC    $i rnc_$i &
    cdo selname,AFWA_ZLFC $i lc_$i &
    cdo selname,AFWA_MSLP $i ps_$i &
    cdo selname,AFWA_CLOUD $i frac_$i &
done

wait

for i in $wrf
do
    cdo -addc,-273.15 k_$i c_$i &
    cdo add rn_$i rnc_$i r_$i &
    cdo divc,100 ps_$i sfcp_$i &
    cdo divc,25 frac_$i cf_$i &
done

wait

for i in $wrf
do
    cdo gmtxyz c_$i  > c_$i.gmt &
    cdo gmtxyz w_$i  > w_$i.gmt &
    cdo gmtxyz cp_$i > cp_$i.gmt &
    cdo gmtxyz rf_$i > rf_$i.gmt &
    cdo gmtxyz r_$i  > r_$i.gmt &
    cdo gmtxyz lc_$i  > lc_$i.gmt &
    cdo gmtxyz sfcp_$i  > sfcp_$i.gmt &
    cdo gmtxyz cf_$i  > cf_$i.gmt &
done

wait

#########################################
# Use GMT to plot the data on the Mercator projection. In WRF
# namelist.input we use the Mercator projection as well
#########################################
coord=(9/40/-40/-15)

#for i in $wrf
#do
#    gmt xyz2grd -R$coord -I28m -D+zDbZ rf_$i.gmt -Gnew.nc
#    gmt surface rf_$i.gmt -R$coord -I28m -Ggrd.nc 
#done

# Make the color scales
gmt makecpt    -Cplasma -T0/70/7          > refd.cpt
gmt makecpt    -Cplasma -T0/80/8          > rain.cpt
gmt makecpt    -Cplasma -T0/2000/250      > cape.cpt
gmt makecpt    -Cplasma -T-10/65/2.5      > tmp.cpt
gmt makecpt    -Cplasma -T0/20/0.8        > wspd.cpt
gmt makecpt    -Cplasma -T-10/7000/250    > lfc.cpt
gmt makecpt    -Cplasma -T0/1/0.05        > cf.cpt

# Plot temperature (TSK)
for i in $wrf
do
    gmt psbasemap  -R$coord -JM18 -Xc -Yc -Ba0 -K                         > t_$i.ps
    gmt pscontour  -R -J -I -Ctmp.cpt c_$i.gmt -O -K                     >> t_$i.ps
    gmt pscoast    -R -J -Df -Sskyblue -N1/white -Wfaint -B5g0 -O -K     >> t_$i.ps
    gmt pscontour  -R -J -Wthinnest,-- sfcp_$i.gmt -C2 -A2+f8 -T+d10+lLH -O -K  >> t_$i.ps
    gmt psxy       ZAF_adm1.gmt -R -J -W0.15,white -V -O -K              >> t_$i.ps
    gmt psxy       -R -J towns.dat -W -Sc0.1 -Gred -O -K                 >> t_$i.ps
    gmt pstext     -R -J towns.dat -X0.10 -Y0 -O -F+fwhite -K            >> t_$i.ps
    echo "$i" | gmt pstext -R -J -F+cTR+f18p,Bold -Gwhite -Wthick -D-7.95/-0.25 -O -K >> t_$i.ps
    gmt psscale    -Ctmp.cpt -R -J -G-10/45 -Dx1.25c/6c+w5c/0.5c+jTC -Bx5+l"Temperature" -By+lc -O >> t_$i.ps
done

# Plot windspeed max (WSPD10MAX)
for i in $wrf
do
    gmt psbasemap  -R$coord -JM18 -Xc -Yc -Ba0 -K                         > w_$i.ps
    gmt pscontour  -R -J -I -Cwspd.cpt w_$i.gmt -O -K                    >> w_$i.ps
    gmt pscoast    -R -J -Df -Sskyblue -N1/white -Wfaint -B5g0 -O -K     >> w_$i.ps
    gmt pscontour  -R -J -Wthinnest,-- sfcp_$i.gmt -C2 -A2+f8 -T+d10+lLH -O -K  >> w_$i.ps
    gmt psxy       ZAF_adm1.gmt -R -J -W0.15,white -V -O -K              >> w_$i.ps
    gmt psxy       -R -J towns.dat -W -Sc0.1 -Gred -O -K                 >> w_$i.ps
    gmt pstext     -R -J towns.dat -X0.10 -Y0 -F+fwhite -O -K            >> w_$i.ps
    echo "$i" | gmt pstext -R -J -F+cTR+f18p,Bold -Gwhite -Wthick -D-7.95/-0.25 -O -K >> w_$i.ps
    gmt psscale    -Cwspd.cpt -R -J -Dx1.25c/6c+w5c/0.5c+jTC -Bx1.5+l"Windspeed" -By+lm/s -O >> w_$i.ps
done

# Plot radar composite ref (REFD_COM)
for i in $wrf
do
    gmt psbasemap  -R$coord -JM18 -Xc -Yc -Ba0 -K                         > rf_$i.ps
    gmt pscontour  -R -J -I -Crefd.cpt rf_$i.gmt -O -K                   >> rf_$i.ps
    gmt pscoast    -R -J -Df -Sskyblue -N1/white -Wfaint -B5g0 -O -K     >> rf_$i.ps
    gmt pscontour  -R -J -Wthinnest,-- sfcp_$i.gmt -C2 -A2+f8 -T+d10+lLH -O -K  >> rf_$i.ps
    gmt psxy       ZAF_adm1.gmt -R -J -W0.15,white -V -O -K              >> rf_$i.ps
    gmt psxy       -R -J towns.dat -W -Sc0.1 -Gred -O -K                 >> rf_$i.ps
    gmt pstext     -R -J towns.dat -X0.10 -Y0 -F+fwhite -O -K            >> rf_$i.ps
    echo "$i" | gmt pstext -R -J -F+cTR+f18p,Bold -Gwhite -Wthick -D-7.95/-0.25 -O -K >> rf_$i.ps
    gmt psscale    -Crefd.cpt -R -J -Dx1.25c/6c+w5c/0.5c+jTC -Bx8+l"Reflectivity" -By+ldBz -O >> rf_$i.ps
done

# Plot rainfall (AFWA_RAIN)
for i in $wrf
do
    gmt psbasemap  -R$coord -JM18 -Xc -Yc -Ba0 -K                         > r_$i.ps
    gmt pscontour  -R -J -I -Crain.cpt r_$i.gmt -O -K                    >> r_$i.ps
    gmt pscoast    -R -J -Df -Sskyblue -N1/white -Wfaint -B5g0 -O -K     >> r_$i.ps
    gmt pscontour  -R -J -Wthinnest,-- sfcp_$i.gmt -C2 -A2+f8 -T+d10+lLH -O -K  >> r_$i.ps
    gmt psxy       ZAF_adm1.gmt -R -J -W0.15,white -V -O -K              >> r_$i.ps
    gmt psxy       -R -J towns.dat -W -Sc0.1 -Gred -O -K                 >> r_$i.ps
    gmt pstext     -R -J towns.dat -X0.10 -Y0 -F+fwhite -O -K            >> r_$i.ps
    echo "$i" | gmt pstext -R -J -F+cTR+f18p,Bold -Gwhite -Wthick -D-7.95/-0.25 -O -K >> r_$i.ps
    gmt psscale    -Crain.cpt -R -J -Dx1.25c/6c+w5c/0.5c+jTC -Bx10+l"Rainfall" -By+lmm -O >> r_$i.ps
done

# Plot LFC (AFWA_LFC)
for i in $wrf
do
    gmt psbasemap  -R$coord -JM18 -Xc -Yc -Ba0 -K                     > lc_$i.ps
    gmt pscontour  -R -J -I -Clfc.cpt lc_$i.gmt -O -K                >> lc_$i.ps
    gmt pscoast    -R -J -Df -Sskyblue -N1/white -Wfaint -B5g0 -O -K >> lc_$i.ps
    gmt pscontour  -R -J -Wthinnest,-- sfcp_$i.gmt -C2 -A2+f8 -T+d10+lLH -O -K  >> lc_$i.ps
    gmt psxy       ZAF_adm1.gmt -R -J -W0.15,white -V -O -K         >> lc_$i.ps
    gmt psxy       -R -J towns.dat -W -Sc0.1 -Gred -O -K            >> lc_$i.ps
    gmt pstext     -R -J towns.dat -X0.10 -Y0 -F+fwhite -O -K       >> lc_$i.ps
    echo "$i" | gmt pstext -R -J -F+cTR+f18p,Bold -Gwhite -Wthick -D-7.95/-0.25 -O -K >> lc_$i.ps
    gmt psscale    -Clfc.cpt -R -J -Dx1.25c/6c+w5c/0.5c+jTC -Bx1000+l"LFC" -By+lm -O >> lc_$i.ps
done

# Plot Cloud Fraction (AFWA_CLOUD)
for i in $wrf
do
    gmt psbasemap  -R$coord -JM18 -Xc -Yc -Ba0 -K                     > cf_$i.ps
    gmt pscontour  -R -J -I -Ccf.cpt cf_$i.gmt -O -K                 >> cf_$i.ps
    gmt pscoast    -R -J -Df -Sskyblue -N1/white -Wfaint -B5g0 -O -K >> cf_$i.ps
    gmt pscontour  -R -J -Wthinnest,-- sfcp_$i.gmt -C2 -A2+f8 -T+d10+lLH -O -K  >> cf_$i.ps
    gmt psxy       ZAF_adm1.gmt -R -J -W0.15,white -V -O -K         >> cf_$i.ps
    gmt psxy       -R -J towns.dat -W -Sc0.1 -Gred -O -K            >> cf_$i.ps
    gmt pstext     -R -J towns.dat -X0.10 -Y0 -F+fwhite -O -K       >> cf_$i.ps
    echo "$i" | gmt pstext -R -J -F+cTR+f18p,Bold -Gwhite -Wthick -D-7.95/-0.25 -O -K >> cf_$i.ps
    gmt psscale    -Ccf.cpt -R -J -G0/1 -Dx1.25c/6c+w5c/0.5c+jTC -Bx0.1+l"Cloud Fraction" -O >> cf_$i.ps
done


# Plot cape (AFWA_CAPE)
for i in $wrf
do
    gmt psbasemap  -R$coord -JM18 -Xc -Yc -Ba0 -K                         > cp_$i.ps
    gmt pscontour  -R -J -I -Ccape.cpt cp_$i.gmt -di100 -do200 -O -K     >> cp_$i.ps
    gmt pscoast    -R -J -Df -Sskyblue -N1/white -Wfaint -B5g0 -O -K     >> cp_$i.ps
    gmt pscontour  -R -J -Wthinnest,-- sfcp_$i.gmt -C2 -A2+f8 -T+d10+lLH -O -K  >> cp_$i.ps
    gmt psxy       ZAF_adm1.gmt -R -J -W0.15,white -V -O -K              >> cp_$i.ps
    gmt psxy       -R -J towns.dat -W -Sc0.1 -Gred -O -K                 >> cp_$i.ps
    gmt pstext     -R -J towns.dat -X0.10 -Y0 -F+fwhite -O -K            >> cp_$i.ps
    echo "$i" | gmt pstext -R -J -F+cTR+f18p,Bold -Gwhite -Wthick -D-7.95/-0.25 -O -K >> cp_$i.ps
    gmt psscale    -Ccape.cpt -R -J -Dx1.25c/6c+w5c/0.5c+jTC -Bx250+l"CAPE" -By+lj/kg -O >> cp_$i.ps
done

# Convert all the data to a png
for i in $wrf
do
    gmt psconvert   t_${i}.ps -A -P -Tg &
    gmt psconvert   w_${i}.ps -A -P -Tg &
    gmt psconvert   r_${i}.ps -A -P -Tg &
    gmt psconvert   rf_${i}.ps -A -P -Tg &
    gmt psconvert   cp_${i}.ps -A -P -Tg &
    gmt psconvert   lc_${i}.ps -A -P -Tg &
    gmt psconvert   cf_${i}.ps -A -P -Tg &
done

wait

# Do some quick cleaning  
rm -rf wrfpng/ skewtpng/
mkdir wrfpng
mv *wrfout*png wrfpng/
rm rnc_* rn_* ps_* sfcp_* k_wrf* w_w*  c_w* cp_w* r_w* rf_w* t_w*
rm cf_w* frac_w* lc_w* *ps *cnv *wrfout*gmt *nc skd*png

exit 0
