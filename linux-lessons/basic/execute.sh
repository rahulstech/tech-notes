declare -A dic
dic=( [name]="Rahul" [age]=25 [sex]="Male" [height]=165 )

# for x in ${!dic[*]}
# do
# echo $x
# done

height=${dic[height]}
(( heightInch = height * 100 / 254 ))
echo "you hieght is $height cm so you are $heightInch inch tall"