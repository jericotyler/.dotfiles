#!/bin/bash

B='#000000dd'  # blank
C='#000000dd'  # clear ish
D='#B31B1Bcc'  # default
T='#B31B1Bee'  # text
W='#4CE4E4bb'  # wrong
V='#4CE4E4bb'  # verifying

date=$(date +%s)
dir='/.config/i3/'
png='.png'
icon=$HOME/.config/i3/icon.png
icon2=$HOME/.config/i3/icon2.png
icon3=$HOME/.config/i3/icon3.png
tmpbg=$HOME$dir$date$png
rm $tmpbg
##maim  $tmpbg
scrot $tmpbg
convert $tmpbg -scale 5% -scale 2000% $tmpbg
convert -composite -gravity SouthEast $tmpbg $icon $tmpbg
convert -composite -gravity SouthWest $tmpbg $icon2 $tmpbg
convert -composite -gravity SouthWest $tmpbg $icon3 $tmpbg
#i3lock -k -i $tmpbg

i3lock              \
--insidevercolor=$C   \
--ringvercolor=$V     \
\
--insidewrongcolor=$C \
--ringwrongcolor=$W   \
\
--insidecolor=$B      \
--ringcolor=$D        \
--linecolor=$B        \
--separatorcolor=$D   \
\
--textcolor=$T        \
--timecolor=$T        \
--datecolor=$T        \
--keyhlcolor=$W       \
--bshlcolor=$W        \
\
--screen 0            \
--clock               \
--indicator           \
--timestr="%H:%M:%S"  \
--datestr="%A, %m %Y" \
\
-i $tmpbg \
--timepos="(x+800)-(cw/2):(y+420)-(ch/2)" \
--datepos="tx:ty+75" \
--datesize=70 \
--timesize=125 \
--veriftext="Diddling The Bits..." \
--textsize=40 \
--modsize=10 \
--radius=200 \
--timefont="FuckYouv2" \
--datefont="FuckYouv2" \
--wrongtext="Fuck Off" \

#scrot

rm $tmpbg
