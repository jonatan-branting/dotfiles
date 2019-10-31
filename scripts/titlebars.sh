#!/bin/bash
pids=/tmp/barpids
new_pids=/tmp/newpids

python ~/scripts/titlebars.py | \
while read line; do
    read -a vars <<< $line

    SHOWN=${vars[0]}
    FLOATING=${vars[1]}
    FOCUS=${vars[2]}
    COLOR=${vars[3]}
    X=${vars[4]}
    Y=${vars[5]}
    W=${vars[6]}
    H=${vars[7]}

    if [ "$SHOWN" == "True" ] && [ "$FLOATING" != "True" ]; then
        GEOMETRY=$(echo $W $H $X $Y | awk '{print $1"x"4"+"$3"+"1080-$4}')
        echo $GEOMETRY
        echo "%{c}%{r}" | lemonbar -bp -g $GEOMETRY -F "#00000000" -B $COLOR &
        echo $! >> $new_pids
    fi
done

# Clean up old bars
touch $pids
kill $(cat $pids)
rm $pids
cp $new_pids $pids
