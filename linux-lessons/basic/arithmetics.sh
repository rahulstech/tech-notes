read -p "enter first number: " a
read -p "enter second number: " b

# expression after let is evaluated as arithmatic express
# Note: there is no space between = and + it is important other an error will occure
let add=a+b

# (()) is used to evaluate arithmatic exepression. here there is not space restriction
(( sub = a-b ))
((div=$a/b)) 
((mul=a*b))

# Note: in all of the cases $ is not madetory while evaluting the arithmatic expression using the variable
#       using it or not will produce same result

echo "$a + $b = $add"
echo "$a - $b = $sub"
echo "$a * $b = $mul"
echo "$a / $b = $div"
echo "$a % $b = $((a % b))"

