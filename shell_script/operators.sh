#!/bin/sh

x=5
y=10
z=$(( y ** x ))

echo $x
echo $y
echo $z

echo $(( x == y ))
echo $(( x < y ))

[ 5 -eq  5 ] && echo "True"
[ $(( 5 == 5 )) ] && echo "True"

echo

[ 5 -gt 4 ] && echo "True"
[ 4 -gt 5 ] || echo "False"

echo

test 'hoge' == 'fuga' || echo "hoge"
# $(('hoge' == 'hoge')) && echo "true"
