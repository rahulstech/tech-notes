read -p "enter first number: " a
read -p "enter second number: " b

let add=a+b
((sub=a-b))
((div=a/b))
((mul=a*b))

echo "$a + $b = $add"
echo "$a - $b = $sub"
echo "$a * $b = $mul"
echo "$a / $b = $div"
echo "$a % $b = $((a % b))"

