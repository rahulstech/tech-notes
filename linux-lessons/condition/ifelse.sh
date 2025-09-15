# observe the space inside before and after "3 -gt 5" inside the [[ ]]
# without this space it will throw a sytax error.
# wrong sytaxes are
# [[3 -gt 5 ]]: no space before 3
# [[ 3 -gt 5]]: no space after 5
# [[3 -gt 5]]: not space before 3 and after 5
#
# adding spaces before and after the main condition is the general syntax of if statement
# also "then" should be in next line

if [[ 7 -gt 5 ]]
then
    echo "7 is more than 5"
else 
    echo "7 is not more than 5"
fi

echo "======================================="

# (()) can be used. in this case sapces are the requires, adding spaces is not sytax error here
# NOTE: here i used > instead of -gt. in case of (()) i need to use < > >= <= == etc types of operators
#       but for [[]] i need to use -gt -lt -le -ge -eq.
# NOTE: -eq is string comparison operator 
#        == is numeric comparion operator
if ((3 > 5))
then 
    echo "8 is more than 5"
else 
    echo "8 is not more than 5"
fi

echo "======================================="

