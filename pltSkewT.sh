#!/bin/bash
# This script goes with the WRF one
# There is a python skewt module that needs to be installed

cd WRF/run/

################################
# Use the skewt python package to plot skewt's
# This loop might crash in parallel, rather do it in sections.
################################
wrf=$(ls wrfout_d01_????-??-??_??:00:00*)

################################
# South-Africa
################################
mfk="--lat -25.7830 --lon 25.3300"
pta="--lat -25.7330 --lon 28.1830"
irn="--lat -25.9100 --lon 28.2111"
alx="--lat -28.5670 --lon 16.5330"
upt="--lat -28.4136 --lon 21.2597"
blm="--lat -29.1000 --lon 26.3000"
bet="--lat -28.2500 --lon 28.3333"
spr="--lat -29.6719 --lon 17.8875"
dea="--lat -30.6747 --lon 23.9992"
pol="--lat -23.8962 --lon 29.4486"
dur="--lat -29.6017 --lon 31.1300"
cpt="--lat -33.9700 --lon 18.6000"
peb="--lat -33.9844 --lon 25.6108"
sul="--lat -32.4101 --lon 20.6705"
mata="--lat -25.7615 --lon 20.0113"
################################

for i in $wrf
do
  /usr/bin/python /home/henno/.local/bin/skewt wrf skd_irn_$i.png ${irn} -f $i &
done

wait

for i in $wrf
do
  /usr/bin/python /home/henno/.local/bin/skewt wrf skd_mfk_$i.png ${mfk} -f $i &
  /usr/bin/python /home/henno/.local/bin/skewt wrf skd_irn_$i.png ${irn} -f $i &
done

wait

for i in $wrf
do
  /usr/bin/python /home/henno/.local/bin/skewt wrf skd_alx_$i.png ${alx} -f $i &
  /usr/bin/python /home/henno/.local/bin/skewt wrf skd_upt_$i.png ${upt} -f $i &
done

wait

for i in $wrf
do
  /usr/bin/python /home/henno/.local/bin/skewt wrf skd_blm_$i.png ${blm} -f $i &
  /usr/bin/python /home/henno/.local/bin/skewt wrf skd_mat_$i.png ${mata} -f $i &
done

wait

for i in $wrf
do
  /usr/bin/python /home/henno/.local/bin/skewt wrf skd_bet_$i.png ${bet} -f $i &
  /usr/bin/python /home/henno/.local/bin/skewt wrf skd_spr_$i.png ${spr} -f $i &
done

wait

for i in $wrf
do
  /usr/bin/python /home/henno/.local/bin/skewt wrf skd_dea_$i.png ${dea} -f $i &
  /usr/bin/python /home/henno/.local/bin/skewt wrf skd_pol_$i.png ${pol} -f $i &
done

wait

for i in $wrf
do
  /usr/bin/python /home/henno/.local/bin/skewt wrf skd_dur_$i.png ${dur} -f $i &
  /usr/bin/python /home/henno/.local/bin/skewt wrf skd_cpt_$i.png ${cpt} -f $i &
done

wait

for i in $wrf
do
  /usr/bin/python /home/henno/.local/bin/skewt wrf skd_peb_$i.png ${peb} -f $i &
  /usr/bin/python /home/henno/.local/bin/skewt wrf skd_sul_$i.png ${sul} -f $i &
done

wait

################################
## International
################################
# Namibia
luderitz="--lat -26.6475 --lon 15.1536"
windhoek="--lat -22.5609 --lon 17.0657"
rundu="--lat -17.9146 --lon 19.7838"
goageb="--lat -23.5603 --lon 15.0404"
sesfontein="--lat -19.1243 --lon 13.6175"
################################

for i in $wrf
do
  /usr/bin/python /home/henno/.local/bin/skewt wrf skd_luderitz_$i.png ${luderitz} -f $i &
  /usr/bin/python /home/henno/.local/bin/skewt wrf skd_windhoek_$i.png ${windhoek} -f $i &
  /usr/bin/python /home/henno/.local/bin/skewt wrf skd_rundu_$i.png ${rundu} -f $i &
done

wait

for i in $wrf
do
  /usr/bin/python /home/henno/.local/bin/skewt wrf skd_goageb_$i.png ${goageb} -f $i &
  /usr/bin/python /home/henno/.local/bin/skewt wrf skd_sesfontein_$i.png ${sesfontein} -f $i &
done

wait

################################
# Botswana
################################
gaberone="--lat -24.6282 --lon 25.9231"
ghanzi="--lat -21.6939 --lon 21.6491"
francistown="--lat -21.1661 --lon 27.5144"
maun="--lat -19.9953 --lon 23.4181"
################################

for i in $wrf
do
  /usr/bin/python /home/henno/.local/bin/skewt wrf skd_gaberone_$i.png ${gaberone} -f $i &
  /usr/bin/python /home/henno/.local/bin/skewt wrf skd_ghanzi_$i.png ${ghanzi} -f $i &
done

wait

for i in $wrf
do
  /usr/bin/python /home/henno/.local/bin/skewt wrf skd_francistown_$i.png ${francistown} -f $i &
  /usr/bin/python /home/henno/.local/bin/skewt wrf skd_maun_$i.png ${maun} -f $i &
done

wait

################################
# Zambia
################################
lusaka="--lat -15.4196 --lon 28.2831"
livingstone="--lat -17.8250 --lon 25.8285"
################################

for i in $wrf
do
  /usr/bin/python /home/henno/.local/bin/skewt wrf skd_lusaka_$i.png ${lusaka} -f $i &
  /usr/bin/python /home/henno/.local/bin/skewt wrf skd_livingstone_$i.png ${livingstone} -f $i &
done

wait

################################
# Zimbabwe
################################
harare="--lat -17.8252 --lon 31.0335"
bulawayo="--lat -20.1325 --lon 28.6265"
################################

for i in $wrf
do
  /usr/bin/python /home/henno/.local/bin/skewt wrf skd_harare_$i.png ${harare} -f $i &
  /usr/bin/python /home/henno/.local/bin/skewt wrf skd_bulawayo_$i.png ${bulawayo} -f $i &
done

wait

################################
# Mozambique
################################
maseru="--lat -29.3151 --lon 27.4869"
beira="--lat -19.8305 --lon 34.8430"
################################

for i in $wrf
do
  /usr/bin/python /home/henno/.local/bin/skewt wrf skd_maseru_$i.png ${maseru} -f $i &
  /usr/bin/python /home/henno/.local/bin/skewt wrf skd_beira_$i.png ${beira} -f $i &
done

wait

################################
# Lesotho and Swaziland
################################
mbabane="--lat -26.3261 --lon 31.1461"
maputu="--lat -25.9732 --lon 32.5720"
################################

for i in $wrf
do
  /usr/bin/python /home/henno/.local/bin/skewt wrf skd_mbabane_$i.png ${mbabane} -f $i &
  /usr/bin/python /home/henno/.local/bin/skewt wrf skd_maputu_$i.png ${maputu} -f $i &
done

wait

for i in $wrf
do
    mogrify -density 150 -format png skd_[a-e]*pdf &
    mogrify -density 150 -format png skd_[f-j]*pdf &
done

wait

for i in $wrf
do
    mogrify -density 150 -format png skd_[k-o]*pdf &
    mogrify -density 150 -format png skd_[p-t]*pdf &
    mogrify -density 150 -format png skd_[u-z]*pdf &
done

wait

#rm -rf skewtpng/
rm *pdf
mkdir skewtpng
mv skd*png skewtpng/

###################################################################
# Now we need to get the wrf png to the webserver
###################################################################
for i in 13 14 15 16 17 19 20 21 22 23 01 02 03 04 05 07 08 09 10 11
do
	rm skewtpng/*$i:??:??.png
done

rm /home/henno/wrf/wrf/* 
rm /home/henno/wrf/skwt/* 

mkdir /home/henno/wrf 
mkdir /home/henno/wrf/wrf /home/henno/wrf/skwt

cp wrfpng/*png /home/henno/wrf/wrf/
cp skewtpng/*png /home/henno/wrf/skwt/ 

cd /home/henno/wrf/

wrf=$(ls wrf/*)
wrfnr=$(ls wrf/cp_* | wc -l)

rm *lst
rm *html *md

for i in $wrf
do
    echo "'http://<ip>/wrf/$i'," | sed 's/\.\.//g' | grep "w_wrfout" >> wrfwind.lst
    echo "'http://<ip>/wrf/$i'," | sed 's/\.\.//g' | grep "t_wrfout" >> wrftemp.lst
    echo "'http://<ip>/wrf/$i'," | sed 's/\.\.//g' | grep "r_wrfout" >> wrfrainfall.lst
    echo "'http://<ip>/wrf/$i'," | sed 's/\.\.//g' | grep "rf_wrfout" >> wrfradar.lst
    echo "'http://<ip>/wrf/$i'," | sed 's/\.\.//g' | grep "cp_wrfout" >> wrfcape.lst
    echo "'http://<ip>/wrf/$i'," | sed 's/\.\.//g' | grep "lc_wrfout" >> wrflfc.lst
    echo "'http://<ip>/wrf/$i'," | sed 's/\.\.//g' | grep "cf_wrfout" >> wrfcf.lst
done

rainpng=$(cat wrfrainfall.lst)
temppng=$(cat wrftemp.lst)
capepng=$(cat wrfcape.lst)
radarpng=$(cat wrfradar.lst)
windpng=$(cat wrfwind.lst)
lfcpng=$(cat wrflfc.lst)
cfpng=$(cat wrfcf.lst)

########################################################
cat > wrfcf.html << EOF
<h1>WRF CLoud Fraction </h1>
<p>Drag the slider to change the time</p>

<div class="slidecontainer">
<input oninput='setImage(this)' class="slider" type="range" min="0" max="$wrfnr" value="0" step="1" />
<br>
<br>
<img id='img' width="500" height="500"/>
</div>

<script>
var img = document.getElementById('img');
var img_array = [$cfpng];
function setImage(obj)
{
        var value = obj.value;
        img.src = img_array[value];

}
</script>
EOF

########################################################
cat > wrflfc.html << EOF
<h1>WRF Level of Free Convection (LFC)</h1>
<p>Drag the slider to change the time</p>

<div class="slidecontainer">
<input oninput='setImage(this)' class="slider" type="range" min="0" max="$wrfnr" value="0" step="1" />
<br>
<br>
<img id='img' width="500" height="500"/>
</div>

<script>
var img = document.getElementById('img');
var img_array = [$lfcpng];
function setImage(obj)
{
        var value = obj.value;
        img.src = img_array[value];

}
</script>
EOF

####################################################
cat > wrfrainfall.html << EOF
<h1>WRF Accumulated Precipitation</h1>
<p>Drag the slider to change the time</p>

<div class="slidecontainer">
<input oninput='setImage(this)' class="slider" type="range" min="0" max="$wrfnr" value="0" step="1" />
<br>
<br>
<br>
<img id='img' width="500" height="500"/>
</div>

<script>
var img = document.getElementById('img');
var img_array = [$rainpng];
function setImage(obj)
{
        var value = obj.value;
        img.src = img_array[value];

}
</script>
EOF

####################################################
cat > wrfradar.html << EOF
<h1>WRF Simulated Radar</h1>
<p>Drag the slider to change the time</p>

<div class="slidecontainer">
<input oninput='setImage(this)' class="slider" type="range" min="0" max="$wrfnr" value="0" step="1" />
<br>
<br>
<br>
<img id='img' width="500" height="500"/>
</div>

<script>
var img = document.getElementById('img');
var img_array = [$radarpng];
function setImage(obj)
{
        var value = obj.value;
        img.src = img_array[value];

}
</script>
EOF

####################################################
cat > wrfcape.html << EOF
<h1>WRF Simulated CAPE</h1>
<p>Drag the slider to change the time</p>

<div class="slidecontainer">
<input oninput='setImage(this)' class="slider" type="range" min="0" max="$wrfnr" value="0" step="1" />
<br>
<br>
<br>
<img id='img' width="500" height="500"/>
</div>

<script>
var img = document.getElementById('img');
var img_array = [$capepng];
function setImage(obj)
{
        var value = obj.value;
        img.src = img_array[value];

}
</script>
EOF

####################################################
cat > wrfwindspeed.html << EOF
<h1>WRF Simulated Max Wind Gust</h1>
<p>Drag the slider to change the time</p>

<div class="slidecontainer">
<input oninput='setImage(this)' class="slider" type="range" min="0" max="$wrfnr" value="0" step="1" />
<br>
<br>
<br>
<img id='img' width="500" height="500"/>
</div>

<script>
var img = document.getElementById('img');
var img_array = [$windpng];
function setImage(obj)
{
        var value = obj.value;
        img.src = img_array[value];

}
</script>
EOF

####################################################
cat > wrftemp.html << EOF
<h1>WRF Simulated Temperature</h1>
<p>Drag the slider to change the time</p>

<div class="slidecontainer">
<input oninput='setImage(this)' class="slider" type="range" min="0" max="$wrfnr" value="0" step="1" />
<br>
<br>
<br>
<img id='img' width="500" height="500"/>
</div>

<script>
var img = document.getElementById('img');
var img_array = [$temppng];
function setImage(obj)
{
        var value = obj.value;
        img.src = img_array[value];

}
</script>
EOF

#########################################################
# Skewt's
#########################################################
skwt=$(ls skwt/*)
skwtnr=$(ls skwt/skd_alx* | wc -l)

#########################################################
# South Africa
#########################################################
for i in $skwt
do
    echo "'http://<ip>/wrf/$i'," | sed 's/\.\.//g' | grep "skd_irn" >> irene.lst
    echo "'http://<ip>/wrf/$i'," | sed 's/\.\.//g' | grep "skd_cpt" >> cpt.lst
    echo "'http://<ip>/wrf/$i'," | sed 's/\.\.//g' | grep "skd_dur" >> dur.lst
    echo "'http://<ip>/wrf/$i'," | sed 's/\.\.//g' | grep "skd_upt" >> upt.lst
    echo "'http://<ip>/wrf/$i'," | sed 's/\.\.//g' | grep "skd_blm" >> blm.lst
    echo "'http://<ip>/wrf/$i'," | sed 's/\.\.//g' | grep "skd_mfk" >> mafikeng.lst
    echo "'http://<ip>/wrf/$i'," | sed 's/\.\.//g' | grep "skd_alx" >> alexander.lst
    echo "'http://<ip>/wrf/$i'," | sed 's/\.\.//g' | grep "skd_pol" >> polokwane.lst
    echo "'http://<ip>/wrf/$i'," | sed 's/\.\.//g' | grep "skd_bet" >> bethlehem.lst
    echo "'http://<ip>/wrf/$i'," | sed 's/\.\.//g' | grep "skd_spr" >> springbok.lst
    echo "'http://<ip>/wrf/$i'," | sed 's/\.\.//g' | grep "skd_peb" >> portelizabeth.lst
    echo "'http://<ip>/wrf/$i'," | sed 's/\.\.//g' | grep "skd_dea" >> deaar.lst
    echo "'http://<ip>/wrf/$i'," | sed 's/\.\.//g' | grep "skd_sul" >> sutherland.lst
    echo "'http://<ip>/wrf/$i'," | sed 's/\.\.//g' | grep "skd_mat" >> mata.lst
done

irene=$(cat irene.lst)
cpt=$(cat cpt.lst)
dur=$(cat dur.lst)
upt=$(cat upt.lst)
blm=$(cat blm.lst)
mafikeng=$(cat mafikeng.lst)
alexander=$(cat alexander.lst)
polokwane=$(cat polokwane.lst)
bethlehem=$(cat bethlehem.lst)
springbok=$(cat springbok.lst)
portelizabeth=$(cat portelizabeth.lst)
deaar=$(cat deaar.lst) 
sutherland=$(cat sutherland.lst) 
mata=$(cat mata.lst) 

########################################################
cat > wrfskwt_mata.html << EOF
<h1>Mata-Mata Sounding</h1>
<p>Drag the slider to change the time</p>

<div class="slidecontainer">
<input oninput='setImage(this)' class="slider" type="range" min="0" max="$skwtnr" value="0" step="1" />
<br>
<br>
<br>
<img id='img' width="500" height="500"/>
</div>

<script>
var img = document.getElementById('img');
var img_array = [$mata];
function setImage(obj)
{
        var value = obj.value;
        img.src = img_array[value];

}
</script>
EOF

########################################################
cat > wrfskwt_sutherland.html << EOF
<h1>Sutherland Sounding</h1>
<p>Drag the slider to change the time</p>

<div class="slidecontainer">
<input oninput='setImage(this)' class="slider" type="range" min="0" max="$skwtnr" value="0" step="1" />
<br>
<br>
<br>
<img id='img' width="500" height="500"/>
</div>

<script>
var img = document.getElementById('img');
var img_array = [$sutherland];
function setImage(obj)
{
        var value = obj.value;
        img.src = img_array[value];

}
</script>
EOF

########################################################
cat > wrfskwt_portelizabeth.html << EOF
<h1>Port-Elizabeth Sounding</h1>
<p>Drag the slider to change the time</p>

<div class="slidecontainer">
<input oninput='setImage(this)' class="slider" type="range" min="0" max="$skwtnr" value="0" step="1" />
<br>
<br>
<br>
<img id='img' width="500" height="500"/>
</div>

<script>
var img = document.getElementById('img');
var img_array = [$portelizabeth];
function setImage(obj)
{
        var value = obj.value;
        img.src = img_array[value];

}
</script>
EOF
########################################################
cat > wrfskwt_bethlehem.html << EOF
<h1>Bethlehem Sounding</h1>
<p>Drag the slider to change the time</p>

<div class="slidecontainer">
<input oninput='setImage(this)' class="slider" type="range" min="0" max="$skwtnr" value="0" step="1" />
<br>
<br>
<br>
<img id='img' width="500" height="500"/>
</div>

<script>
var img = document.getElementById('img');
var img_array = [$bethlehem];
function setImage(obj)
{
        var value = obj.value;
        img.src = img_array[value];

}
</script>
EOF

########################################################
cat > wrfskwt_polokwane.html << EOF
<h1>Polokwane Sounding</h1>
<p>Drag the slider to change the time</p>

<div class="slidecontainer">
<input oninput='setImage(this)' class="slider" type="range" min="0" max="$skwtnr" value="0" step="1" />
<br>
<br>
<br>
<img id='img' width="500" height="500"/>
</div>

<script>
var img = document.getElementById('img');
var img_array = [$polokwane];
function setImage(obj)
{
        var value = obj.value;
        img.src = img_array[value];

}
</script>
EOF

########################################################
cat > wrfskwt_alexander.html << EOF
<h1>Alexander Sounding</h1>
<p>Drag the slider to change the time</p>

<div class="slidecontainer">
<input oninput='setImage(this)' class="slider" type="range" min="0" max="$skwtnr" value="0" step="1" />
<br>
<br>
<br>
<img id='img' width="500" height="500"/>
</div>

<script>
var img = document.getElementById('img');
var img_array = [$alexander];
function setImage(obj)
{
        var value = obj.value;
        img.src = img_array[value];

}
</script>
EOF

########################################################
cat > wrfskwt_deaar.html << EOF
<h1>De-Aar Sounding</h1>
<p>Drag the slider to change the time</p>

<div class="slidecontainer">
<input oninput='setImage(this)' class="slider" type="range" min="0" max="$skwtnr" value="0" step="1" />
<br>
<br>
<br>
<img id='img' width="500" height="500"/>
</div>

<script>
var img = document.getElementById('img');
var img_array = [$deaar];
function setImage(obj)
{
        var value = obj.value;
        img.src = img_array[value];

}
</script>
EOF

########################################################
cat > wrfskwt_springbok.html << EOF
<h1>Springbok Sounding</h1>
<p>Drag the slider to change the time</p>

<div class="slidecontainer">
<input oninput='setImage(this)' class="slider" type="range" min="0" max="$skwtnr" value="0" step="1" />
<br>
<br>
<br>
<img id='img' width="500" height="500"/>
</div>

<script>
var img = document.getElementById('img');
var img_array = [$springbok];
function setImage(obj)
{
        var value = obj.value;
        img.src = img_array[value];

}
</script>
EOF

########################################################
cat > wrfskwt_mafikeng.html << EOF
<h1>Mafikeng Sounding</h1>
<p>Drag the slider to change the time</p>

<div class="slidecontainer">
<input oninput='setImage(this)' class="slider" type="range" min="0" max="$skwtnr" value="0" step="1" />
<br>
<br>
<br>
<img id='img' width="500" height="500"/>
</div>

<script>
var img = document.getElementById('img');
var img_array = [$mafikeng];
function setImage(obj)
{
        var value = obj.value;
        img.src = img_array[value];

}
</script>
EOF

########################################################
cat > wrfskwt_irene.html << EOF
<h1>Irene Sounding</h1>
<p>Drag the slider to change the time</p>

<div class="slidecontainer">
<input oninput='setImage(this)' class="slider" type="range" min="0" max="$skwtnr" value="0" step="1" />
<br>
<br>
<br>
<img id='img' width="500" height="500"/>
</div>

<script>
var img = document.getElementById('img');
var img_array = [$irene];
function setImage(obj)
{
        var value = obj.value;
        img.src = img_array[value];

}
</script>
EOF
#########################################
cat > wrfskwt_cpt.html << EOF
<h1>Cape Town Sounding</h1>
<p>Drag the slider to change the time</p>

<div class="slidecontainer">
<input oninput='setImage(this)' class="slider" type="range" min="0" max="$skwtnr" value="0" step="1" />
<br>
<br>
<br>
<img id='img' width="500" height="500"/>
</div>

<script>
var img = document.getElementById('img');
var img_array = [$cpt];
function setImage(obj)
{
        var value = obj.value;
        img.src = img_array[value];

}
</script>
EOF
#########################################
cat > wrfskwt_durban.html << EOF
<h1>Durban Sounding</h1>
<p>Drag the slider to change the time</p>

<div class="slidecontainer">
<input oninput='setImage(this)' class="slider" type="range" min="0" max="$skwtnr" value="0" step="1" />
<br>
<br>
<br>
<img id='img' width="500" height="500"/>
</div>

<script>
var img = document.getElementById('img');
var img_array = [$dur];
function setImage(obj)
{
        var value = obj.value;
        img.src = img_array[value];

}
</script>
EOF
#########################################
cat > wrfskwt_upington.html << EOF
<h1>Upington Sounding</h1>
<p>Drag the slider to change the time</p>

<div class="slidecontainer">
<input oninput='setImage(this)' class="slider" type="range" min="0" max="$skwtnr" value="0" step="1" />
<br>
<br>
<br>
<img id='img' width="500" height="500"/>
</div>

<script>
var img = document.getElementById('img');
var img_array = [$upt];
function setImage(obj)
{
        var value = obj.value;
        img.src = img_array[value];

}
</script>
EOF
#########################################
cat > wrfskwt_bloemfontein.html << EOF
<h1>Bloemfontein Sounding</h1>
<p>Drag the slider to change the time</p>

<div class="slidecontainer">
<input oninput='setImage(this)' class="slider" type="range" min="0" max="$skwtnr" value="0" step="1" />
<br>
<br>
<br>
<img id='img' width="500" height="500"/>
</div>

<script>
var img = document.getElementById('img');
var img_array = [$blm];
function setImage(obj)
{
        var value = obj.value;
        img.src = img_array[value];

}
</script>
EOF

#########################################################
# Botswana
#########################################################

for i in $skwt
do
    echo "'http://<ip>/wrf/$i'," | sed 's/\.\.//g' | grep "skd_ghanzi" >> ghanzi.lst
    echo "'http://<ip>/wrf/$i'," | sed 's/\.\.//g' | grep "skd_gaberone" >> gaberone.lst
    echo "'http://<ip>/wrf/$i'," | sed 's/\.\.//g' | grep "skd_maun" >> maun.lst
    echo "'http://<ip>/wrf/$i'," | sed 's/\.\.//g' | grep "skd_francistown" >> francistown.lst
done

gaberone=$(cat gaberone.lst)
ghanzi=$(cat ghanzi.lst)
maun=$(cat maun.lst)
francistown=$(cat francistown.lst)

cat > wrfskwt_francistown.html << EOF
<h1>Francistown Sounding</h1>
<p>Drag the slider to change the time</p>

<div class="slidecontainer">
<input oninput='setImage(this)' class="slider" type="range" min="0" max="$skwtnr" value="0" step="1" />
<br>
<br>
<br>
<img id='img' width="500" height="500"/>
</div>

<script>
var img = document.getElementById('img');
var img_array = [$francistown];
function setImage(obj)
{
        var value = obj.value;
        img.src = img_array[value];

}
</script>
EOF
##################################################
cat > wrfskwt_maun.html << EOF
<h1>Maun Sounding</h1>
<p>Drag the slider to change the time</p>

<div class="slidecontainer">
<input oninput='setImage(this)' class="slider" type="range" min="0" max="$skwtnr" value="0" step="1" />
<br>
<br>
<br>
<img id='img' width="500" height="500"/>
</div>

<script>
var img = document.getElementById('img');
var img_array = [$maun];
function setImage(obj)
{
        var value = obj.value;
        img.src = img_array[value];

}
</script>
EOF
##################################################
cat > wrfskwt_ghanzi.html << EOF
<h1>Ghanzi Sounding</h1>
<p>Drag the slider to change the time</p>

<div class="slidecontainer">
<input oninput='setImage(this)' class="slider" type="range" min="0" max="$skwtnr" value="0" step="1" />
<br>
<br>
<br>
<img id='img' width="500" height="500"/>
</div>

<script>
var img = document.getElementById('img');
var img_array = [$ghanzi];
function setImage(obj)
{
        var value = obj.value;
        img.src = img_array[value];

}
</script>
EOF
##################################################
cat > wrfskwt_gaberone.html << EOF
<h1>Gaberone Sounding</h1>
<p>Drag the slider to change the time</p>

<div class="slidecontainer">
<input oninput='setImage(this)' class="slider" type="range" min="0" max="$skwtnr" value="0" step="1" />
<br>
<br>
<br>
<img id='img' width="500" height="500"/>
</div>

<script>
var img = document.getElementById('img');
var img_array = [$gaberone];
function setImage(obj)
{
        var value = obj.value;
        img.src = img_array[value];

}
</script>
EOF

#########################################################
# Namibia
#########################################################

for i in $skwt
do
    echo "'http://<ip>/wrf/$i'," | sed 's/\.\.//g' | grep "skd_windhoek" >> windhoek.lst
    echo "'http://<ip>/wrf/$i'," | sed 's/\.\.//g' | grep "skd_luderitz" >> luderitz.lst
    echo "'http://<ip>/wrf/$i'," | sed 's/\.\.//g' | grep "skd_rundu" >> rundu.lst
    echo "'http://<ip>/wrf/$i'," | sed 's/\.\.//g' | grep "skd_goageb" >> goageb.lst
    echo "'http://<ip>/wrf/$i'," | sed 's/\.\.//g' | grep "skd_sesfontein" >> sesfontein.lst
done

windhoek=$(cat windhoek.lst)
luderitz=$(cat luderitz.lst)
rundu=$(cat rundu.lst)
goageb=$(cat goageb.lst)
sesfontein=$(cat sesfontein.lst)

cat > wrfskwt_sesfontein.html << EOF
<h1>Sesfontein Sounding</h1>
<p>Drag the slider to change the time</p>

<div class="slidecontainer">
<input oninput='setImage(this)' class="slider" type="range" min="0" max="$skwtnr" value="0" step="1" />
<br>
<br>
<br>
<img id='img' width="500" height="500"/>
</div>

<script>
var img = document.getElementById('img');
var img_array = [$sesfontein];
function setImage(obj)
{
        var value = obj.value;
        img.src = img_array[value];

}
</script>
EOF
##################################################
cat > wrfskwt_windhoek.html << EOF
<h1>Windhoek Sounding</h1>
<p>Drag the slider to change the time</p>

<div class="slidecontainer">
<input oninput='setImage(this)' class="slider" type="range" min="0" max="$skwtnr" value="0" step="1" />
<br>
<br>
<br>
<img id='img' width="500" height="500"/>
</div>

<script>
var img = document.getElementById('img');
var img_array = [$windhoek];
function setImage(obj)
{
        var value = obj.value;
        img.src = img_array[value];

}
</script>
EOF
##################################################
cat > wrfskwt_luderitz.html << EOF
<h1>Luderitz Sounding</h1>
<p>Drag the slider to change the time</p>

<div class="slidecontainer">
<input oninput='setImage(this)' class="slider" type="range" min="0" max="$skwtnr" value="0" step="1" />
<br>
<br>
<br>
<img id='img' width="500" height="500"/>
</div>

<script>
var img = document.getElementById('img');
var img_array = [$luderitz];
function setImage(obj)
{
        var value = obj.value;
        img.src = img_array[value];

}
</script>
EOF
##################################################
cat > wrfskwt_goageb.html << EOF
<h1>Goageb Sounding</h1>
<p>Drag the slider to change the time</p>

<div class="slidecontainer">
<input oninput='setImage(this)' class="slider" type="range" min="0" max="$skwtnr" value="0" step="1" />
<br>
<br>
<br>
<img id='img' width="500" height="500"/>
</div>

<script>
var img = document.getElementById('img');
var img_array = [$goageb];
function setImage(obj)
{
        var value = obj.value;
        img.src = img_array[value];

}
</script>
EOF
##################################################
cat > wrfskwt_rundu.html << EOF
<h1>Rundu Sounding</h1>
<p>Drag the slider to change the time</p>

<div class="slidecontainer">
<input oninput='setImage(this)' class="slider" type="range" min="0" max="$skwtnr" value="0" step="1" />
<br>
<br>
<br>
<img id='img' width="500" height="500"/>
</div>

<script>
var img = document.getElementById('img');
var img_array = [$rundu];
function setImage(obj)
{
        var value = obj.value;
        img.src = img_array[value];

}
</script>
EOF

#########################################################
# Zimbabwe
#########################################################

for i in $skwt
do
    echo "'http://<ip>/wrf/$i'," | sed 's/\.\.//g' | grep "skd_harare" >> harare.lst
    echo "'http://<ip>/wrf/$i'," | sed 's/\.\.//g' | grep "skd_bulawayo" >> bulawayo.lst
done

bulawayo=$(cat bulawayo.lst)
harare=$(cat harare.lst)

cat > wrfskwt_harare.html << EOF
<h1>Harare Sounding</h1>
<p>Drag the slider to change the time</p>

<div class="slidecontainer">
<input oninput='setImage(this)' class="slider" type="range" min="0" max="$skwtnr" value="0" step="1" />
<br>
<br>
<br>
<img id='img' width="500" height="500"/>
</div>

<script>
var img = document.getElementById('img');
var img_array = [$harare];
function setImage(obj)
{
        var value = obj.value;
        img.src = img_array[value];

}
</script>
EOF
##################################################
cat > wrfskwt_bulawayo.html << EOF
<h1>Bulawayo Sounding</h1>
<p>Drag the slider to change the time</p>

<div class="slidecontainer">
<input oninput='setImage(this)' class="slider" type="range" min="0" max="$skwtnr" value="0" step="1" />
<br>
<br>
<br>
<img id='img' width="500" height="500"/>
</div>

<script>
var img = document.getElementById('img');
var img_array = [$bulawayo];
function setImage(obj)
{
        var value = obj.value;
        img.src = img_array[value];

}
</script>
EOF

#########################################################
# Mozambique
#########################################################
for i in $skwt
do
    echo "'http://<ip>/wrf/$i'," | sed 's/\.\.//g' | grep "skd_maputu" >> maputu.lst
    echo "'http://<ip>/wrf/$i'," | sed 's/\.\.//g' | grep "skd_beira" >> beira.lst
done

beira=$(cat beira.lst)
maputu=$(cat maputu.lst)

cat > wrfskwt_maputu.html << EOF
<h1>Maputu Sounding</h1>
<p>Drag the slider to change the time</p>

<div class="slidecontainer">
<input oninput='setImage(this)' class="slider" type="range" min="0" max="$skwtnr" value="0" step="1" />
<br>
<br>
<br>
<img id='img' width="500" height="500"/>
</div>

<script>
var img = document.getElementById('img');
var img_array = [$maputu];
function setImage(obj)
{
        var value = obj.value;
        img.src = img_array[value];

}
</script>
EOF
##################################################
cat > wrfskwt_beira.html << EOF
<h1>Beira Sounding</h1>
<p>Drag the slider to change the time</p>

<div class="slidecontainer">
<input oninput='setImage(this)' class="slider" type="range" min="0" max="$skwtnr" value="0" step="1" />
<br>
<br>
<br>
<img id='img' width="500" height="500"/>
</div>

<script>
var img = document.getElementById('img');
var img_array = [$beira];
function setImage(obj)
{
        var value = obj.value;
        img.src = img_array[value];

}
</script>
EOF

#########################################################
# Zambia
#########################################################
for i in $skwt
do
    echo "'http://<ip>/wrf/$i'," | sed 's/\.\.//g' | grep "skd_lusaka" >> lusaka.lst
    echo "'http://<ip>/wrf/$i'," | sed 's/\.\.//g' | grep "skd_livingstone" >> livingstone.lst
done

lusaka=$(cat lusaka.lst)
livingstone=$(cat livingstone.lst)

cat > wrfskwt_livingstone.html << EOF
<h1>Livingstone Sounding</h1>
<p>Drag the slider to change the time</p>

<div class="slidecontainer">
<input oninput='setImage(this)' class="slider" type="range" min="0" max="$skwtnr" value="0" step="1" />
<br>
<br>
<br>
<img id='img' width="500" height="500"/>
</div>

<script>
var img = document.getElementById('img');
var img_array = [$livingstone];
function setImage(obj)
{
        var value = obj.value;
        img.src = img_array[value];

}
</script>
EOF
#########################################################
cat > wrfskwt_lusaka.html << EOF
<h1>Lusaka Sounding</h1>
<p>Drag the slider to change the time</p>

<div class="slidecontainer">
<input oninput='setImage(this)' class="slider" type="range" min="0" max="$skwtnr" value="0" step="1" />
<br>
<br>
<br>
<img id='img' width="500" height="500"/>
</div>

<script>
var img = document.getElementById('img');
var img_array = [$lusaka];
function setImage(obj)
{
        var value = obj.value;
        img.src = img_array[value];

}
</script>
EOF
#########################################################
# Lesotho and Swaziland
#########################################################
for i in $skwt
do
    echo "'http://<ip>/wrf/$i'," | sed 's/\.\.//g' | grep "skd_mbabane" >> mbabane.lst
    echo "'http://<ip>/wrf/$i'," | sed 's/\.\.//g' | grep "skd_maseru" >> maseru.lst
done

maseru=$(cat maseru.lst)
mbabane=$(cat mbabane.lst)

cat > wrfskwt_mbabane.html << EOF
<h1>Mbabane Sounding</h1>
<p>Drag the slider to change the time</p>

<div class="slidecontainer">
<input oninput='setImage(this)' class="slider" type="range" min="0" max="$skwtnr" value="0" step="1" />
<br>
<br>
<br>
<img id='img' width="500" height="500"/>
</div>

<script>
var img = document.getElementById('img');
var img_array = [$mbabane];
function setImage(obj)
{
        var value = obj.value;
        img.src = img_array[value];

}
</script>
EOF
##################################################
cat > wrfskwt_maseru.html << EOF
<h1>Maseru Sounding</h1>
<p>Drag the slider to change the time</p>

<div class="slidecontainer">
<input oninput='setImage(this)' class="slider" type="range" min="0" max="$skwtnr" value="0" step="1" />
<br>
<br>
<br>
<img id='img' width="500" height="500"/>
</div>

<script>
var img = document.getElementById('img');
var img_array = [$maseru];
function setImage(obj)
{
        var value = obj.value;
        img.src = img_array[value];

}
</script>
EOF

#####################################################################
cat > wrf.md << EOF
---
layout: page
title: NWU-WRF
tagline: North-West University Operational WRF
permalink: <ip>/wrf/wrf.html
---

**The Weather Research and Forecasting Model Version (WRFV) 4.0**,
Microphysics=New Thompson, *et.al* (8),
Longwave Radiation=RRTMG scheme (4),
Shortwave Radiation=RRTMG scheme (4),
Land Surface=Noah Land Surface Model (2),
Planetary Boundary layer=Yonsei University scheme (1),
Cumulus Parameterization=Grell-Freitas (3),
Model Vertical Levels=34

#### Initialization Strategy
![forecast_strat]({{ "/assets/images/wrf_forecast.png" | absolute_url }})

---

<html>
<head>
<script>
function startTime() {
  var today = new Date();
  var h = today.getUTCHours();
  var m = today.getUTCMinutes();
  var s = today.getUTCSeconds();
  m = checkTime(m);
  s = checkTime(s);
  document.getElementById('txt').innerHTML =
  h + ":" + m + ":" + s;
  var t = setTimeout(startTime, 500);
}
function checkTime(i) {
  if (i < 10) {i = "0" + i};  // add zero in front of numbers < 10
  return i;
}
</script>
</head>

<body onload="startTime()">
The current UTC time is:
<div id="txt"></div>
</body>

</html>

---

## Forecasts 
Click links to expand

[Precipitation]({{ "http://<ip>/wrf/wrfrainfall.html" | absolute_url }}) ||
[Radar]({{ "http://<ip>/wrf/wrfradar.html" | absolute_url }}) ||
[Maximum Wind Gust]({{ "http://<ip>/wrf/wrfwindspeed.html" | absolute_url }}) ||
[CAPE]({{ "http://<ip>/wrf/wrfcape.html" | absolute_url }}) ||
[LFC]({{ "http://<ip>/wrf/wrflfc.html" | absolute_url }}) ||
[Cloud Fraction]({{ "http://<ip>/wrf/wrfcf.html" | absolute_url }}) ||
[Temperature]({{ "http://<ip>/wrf/wrftemp.html" | absolute_url }})

### Soundings 
Click city names to expand

<img src="/assets/images/sounding_locations_2.png" alt="" usemap="#map" />
<map name="map">
    <area shape="rect" coords="397, 278, 450, 292" href="http://<ip>/wrf/wrfskwt_mafikeng.html" alt="mafikeng" title="Mafikeng" />
    <area shape="rect" coords="410, 247, 468, 260" href="http://<ip>/wrf/wrfskwt_gaberone.html" alt="gaberone" title="Gaberone" />
    <area shape="rect" coords="496, 225, 556, 241" href="http://<ip>/wrf/wrfskwt_polokwane.html" alt="polokwane" title="Polokwane" />
    <area shape="rect" coords="624, 122, 661, 139" href="http://<ip>/wrf/wrfskwt_beira.html" alt="beira" title="Beira" />
    <area shape="rect" coords="469, 13, 514, 28"   href="http://<ip>/wrf/wrfskwt_lusaka.html" alt="lusaka" title="Lusaka" />
    <area shape="rect" coords="532, 72, 576, 88"   href="http://<ip>/wrf/wrfskwt_harare.html" alt="harare" title="Harare" />
    <area shape="rect" coords="476, 130, 532, 145" href="http://<ip>/wrf/wrfskwt_bulawayo.html" alt="bulawayo" title="Bulawayo" />
    <area shape="rect" coords="577, 280, 621, 296" href="http://<ip>/wrf/wrfskwt_maputu.html" alt="maputu" title="Maputu" />
    <area shape="rect" coords="537, 290, 568, 307" href="http://<ip>/wrf/wrfskwt_mbabane.html" alt="mbabane" title="Mbabane" />
    <area shape="rect" coords="459, 277, 514, 303" href="http://<ip>/wrf/wrfskwt_irene.html" alt="irene" title="Irene" />
    <area shape="rect" coords="466, 342, 532, 358" href="http://<ip>/wrf/wrfskwt_bethlehem.html" alt="bethlehem" title="Bethlehem" />
    <area shape="rect" coords="459, 373, 490, 388" href="http://<ip>/wrf/wrfskwt_maseru.html" alt="maseru" title="Maseru" />
    <area shape="rect" coords="419, 365, 445, 381" href="http://<ip>/wrf/wrfskwt_bloemfontein.html" alt="bloemfontein" title="Bloemfontein" />
    <area shape="rect" coords="297, 347, 352, 361" href="http://<ip>/wrf/wrfskwt_upington.html" alt="upington" title="Upington" />
    <area shape="rect" coords="536, 379, 581, 394" href="http://<ip>/wrf/wrfskwt_durban.html" alt="durban" title="Durban" />
    <area shape="rect" coords="364, 409, 411, 426" href="http://<ip>/wrf/wrfskwt_deaar.html" alt="deaar" title="De-Aar" />
    <area shape="rect" coords="404, 502, 480, 518" href="http://<ip>/wrf/wrfskwt_portelizabeth.html" alt="portelizabeth" title="Port-Elizabeth" />
    <area shape="rect" coords="235, 502, 298, 518" href="http://<ip>/wrf/wrfskwt_cpt.html" alt="capetown" title="Cape-Town" />
    <area shape="rect" coords="217, 382, 276, 396" href="http://<ip>/wrf/wrfskwt_springbok.html" alt="springbok" title="Springbok" />
    <area shape="rect" coords="184, 351, 245, 367" href="http://<ip>/wrf/wrfskwt_alexander.html" alt="alexander" title="Alexander" />
    <area shape="rect" coords="306, 170, 352, 186" href="http://<ip>/wrf/wrfskwt_ghanzi.html" alt="ghanzi" title="Ghanzi" />
    <area shape="rect" coords="151, 298, 200, 315" href="http://<ip>/wrf/wrfskwt_luderitz.html" alt="luderitz" title="Luderitz" />
    <area shape="rect" coords="148, 218, 199, 235" href="http://<ip>/wrf/wrfskwt_goageb.html" alt="goageb" title="Goageb" />
    <area shape="rect" coords="195, 192, 257, 207" href="http://<ip>/wrf/wrfskwt_windhoek.html" alt="windhoek" title="Windhoek" />
    <area shape="rect" coords="258, 72, 309, 89"   href="http://<ip>/wrf/wrfskwt_rundu.html" alt="rundu" title="Rundu" />
    <area shape="rect" coords="281, 454, 348, 475" href="http://<ip>/wrf/wrfskwt_sutherland.html" alt="sutherland" title="Sutherland" />
    <area shape="rect" coords="264, 271, 331, 296" href="http://<ip>/wrf/wrfskwt_mata.html" alt="matamata" title="Mata-Mata" />
    <area shape="rect" coords="444, 153, 517, 174" href="http://<ip>/wrf/wrfskwt_francistown.html" alt="francistown" title="Francistown" />
    <area shape="rect" coords="347, 123, 390, 145" href="http://<ip>/wrf/wrfskwt_maun.html" alt="maun" title="Maun" />
    <area shape="rect" coords="402, 68, 476, 90"   href="http://<ip>/wrf/wrfskwt_livingstone.html" alt="livingstone" title="Livingstone" />
    <area shape="rect" coords="112, 100, 178, 121" href="http://<ip>/wrf/wrfskwt_sesfontein.html" alt="sesfontein" title="Sesfontein" />
</map>

#### South-Africa
[Alexandria]({{ "http://<ip>/wrf/wrfskwt_alexandria.html" | absolute_url }}) ||
[Bethlehem]({{ "http://<ip>/wrf/wrfskwt_bethlehem.html" | absolute_url }}) ||
[Bloemfontein]({{ "http://<ip>/wrf/wrfskwt_bloemfontein.html" | absolute_url }}) || 
[Cape Town]({{ "http://<ip>/wrf/wrfskwt_cpt.html" | absolute_url }}) ||
[De-Aar]({{ "http://<ip>/wrf/wrfskwt_deaar.html" | absolute_url }}) ||
[Durban]({{ "http://<ip>/wrf/wrfskwt_durban.html" | absolute_url }}) ||
[Irene]({{ "http://<ip>/wrf/wrfskwt_irene.html" | absolute_url }}) ||
[Upington]({{ "http://<ip>/wrf/wrfskwt_upington.html" | absolute_url }}) ||
[Mafikeng]({{ "http://<ip>/wrf/wrfskwt_mafikeng.html" | absolute_url }}) ||
[Polokwane]({{ "http://<ip>/wrf/wrfskwt_polokwane.html" | absolute_url }}) ||
[Port Elizabeth]({{ "http://<ip>/wrf/wrfskwt_portelizabeth.html" | absolute_url }}) ||
[Springbok]({{ "http://<ip>/wrf/wrfskwt_springbok.html" | absolute_url }}) ||
[Sutherland]({{ "http://<ip>/wrf/wrfskwt_sutherland.html" | absolute_url }}) ||
[Mata-Mata]({{ "http://<ip>/wrf/wrfskwt_mata.html" | absolute_url }})

#### Namibia
[Windhoek]({{ "http://<ip>/wrf/wrfskwt_windhoek.html" | absolute_url }}) ||
[Rundu]({{ "http://<ip>/wrf/wrfskwt_windhoek.html" | absolute_url }}) ||
[Luderitz]({{ "http://<ip>/wrf/wrfskwt_luderitz.html" | absolute_url }}) ||
[Goageb]({{ "http://<ip>/wrf/wrfskwt_goageb.html" | absolute_url }}) ||
[Rundu]({{ "http://<ip>/wrf/wrfskwt_Rundu.html" | absolute_url }}) || 
[Sesfontein]({{ "http://<ip>/wrf/wrfskwt_sesfontein.html" | absolute_url }}) 

#### Botswana
[Gaberone]({{ "http://<ip>/wrf/wrfskwt_gaberone.html" | absolute_url }}) ||
[Ghanzi]({{ "http://<ip>/wrf/wrfskwt_ghanzi.html" | absolute_url }}) ||
[Francistown]({{ "http://<ip>/wrf/wrfskwt_francistown.html" | absolute_url }}) ||
[Maun]({{ "http://<ip>/wrf/wrfskwt_muan.html" | absolute_url }})

#### Zimbabwe
[Harare]({{ "http://<ip>/wrf/wrfskwt_harare.html" | absolute_url }}) ||
[Bulawayo]({{ "http://<ip>/wrf/wrfskwt_bulawayo.html" | absolute_url }})

#### Mozambique
[Maputu]({{ "http://<ip>/wrf/wrfskwt_maputu.html" | absolute_url }}) ||
[Beira]({{ "http://<ip>/wrf/wrfskwt_beira.html" | absolute_url }})

#### Zambia
[Lusaka]({{ "http://<ip>/wrf/wrfskwt_lusaka.html" | absolute_url }}) ||
[Livingstone]({{ "http://<ip>/wrf/wrfskwt_livingstone.html" | absolute_url }}) 

#### Lesotho and Swaziland
[Maseru]({{ "http://<ip>/wrf/wrfskwt_maseru.html" | absolute_url }}) ||
[Mbabane]({{ "http://<ip>/wrf/wrfskwt_mbabane.html" | absolute_url }}) 

#### Practical considerations and limitations
+ The model is initialized using publicly available GFS data. The GFS forecasts are also viewable [here](http://www.lekwenaradar.co.za/forecast.html)
+ The model requires *spin-up* time to become numerically stable, the first hour of the forecast should be discarded
+ For observed Skew-T diagrams please visit the [University of Wyoming Upper-Air Database](http://weather.uwyo.edu/upperair/sounding.html)
+ Customized forecast products is available on request
+ Please note that SAWS is the only entity in South-Africa which can issue weather related warnings
EOF

rsync -azv * titan5@<ip>:/home/titan5/wrf
#mv wrf.md ../

exit 0
