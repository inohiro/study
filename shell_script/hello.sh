#!/bin/sh

echo "Hello, World"

<<EOF
THIS IS COMMENT
EOF

<<EOF
read -p "Please input your name: " name
echo "Hi, $name"
EOF

string="This is string"
echo string
echo 'string'
echo "string"
echo $string
echo '================'
echo '$string'
echo "$string"
echo ${string}

name=$string
num=10
age=$num

echo num
echo $num

echo
echo

# echo "$name is $age yeas old\n"

# name=hoge
num=30

printf "%s is yeas old\n" $string
