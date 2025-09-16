# loop from given number upto 40
# read -p "enter a number: " steps
# while [[ steps -le 40 ]] # or (( steps  < 40 ))
# do
# echo "step no $steps"
# (( steps=steps+1 )) # or (( it++ ))
# done


for x in "$PWD"/*
do
name=$(basename $x)
echo ${name^^}
done 