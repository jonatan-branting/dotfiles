#! /bin/bash

len=13

num_spaces=$(yabai -m query --spaces | jq -r '. | length')
focused_space=$(yabai -m query --spaces | jq 'map(select(."focused" == 1))[0].index')

if [[ $num_spaces -lt $1 ]]; then
    result=""
    exit 0
fi

title=$(yabai -m query --windows --space $1 | jq -r 'map(select(."role" == "AXWindow"))[-1].title')


if [[ "$title" == "null" ]]; then
    title="---"
fi
shortened_title=$(echo $title | cut -c1-$len)

if [[ "$title" != "$shortened_title" ]]; then
    shortened_title=$shortened_title...
fi

return_json () {
    python -c "import json; print(json.dumps({'text':'$1', 'background_color':'$2', 'font_color':'$3', 'font_size':'$4'}))"
}


text="$1: $shortened_title"
background_color="70,70,70,255"
font_color="240,240,240,255"
font_size=13

if [ $focused_space -eq $1 ]; then
    background_color="70,70,120,255"
fi

# echo "{\"text\":\"test text\", \"font_color\": \"100,200,100,255\"}"

echo $(return_json "$text" "$background_color" "$font_color" $font_size)


