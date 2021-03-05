cd ~/Desktop/Github/IP2019/data-shell/molecules

for filename in *.pdb # Loop on everything ending with .pdb
do 
echo $filename # Print the name of the current file
head -n 15 $filename | tail -n 5 # display the last 5 of the first 15
done # end the loop
