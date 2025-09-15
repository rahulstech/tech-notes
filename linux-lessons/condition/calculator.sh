read -p "enter first number: " a
read -p "enter second number: " b

echo "choose arithmetic operation"
echo "ADD - addition"
echo "SUB - subtraction"
echo "MUL - multiplication"
echo "DIV - division"

read operation

case $operation in
	"ADD") ((res=a+b));;
	"SUB") ((res=a-b));;
	"MUL") ((res=a*b));;
	"DIV") ((res=a/b));;
	*) echo "invalid operation $operation" | exit ;;
esac

echo "$operation $a and $b = $res"

