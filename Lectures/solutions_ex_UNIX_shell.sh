
############################################################
############################################################


## -- CMS27 - Intro to programming 2019 - S2-3
## -- Solutions to Ex 7, 8 and Nelle's problem


############################################################
############################################################

# Exercice 2: 

ls *[AB].txt

# Exercise 2:

wc -l *.pdb
wc -l *.pdb > size.txt
sort -n lengths.txt > sorted-size.txt
head -n 1 sorted-size.txt

# 

wc -l *.pdb | sort -n | head -n 1

# Exercise 4:

for filename in *.pdb
do 
echo $filename
tail -n 5 $filename
done

for filename in *.pdb
do 
echo $filename
tail -n 5 $filename | wc -l
done

# Exercise 7: select the 15 first lines of the file octane.pdb a
# and only display the last 5:

cd ~/Dropbox/IP/data-shell/molecules
head -n 15 octane.pdb | tail -n 5


############################################################
############################################################

# Exercise 8: Use a loop on every .pdb file 

for filename in *.pdb # Loop on everything ending with .pdb
do 
echo $filename # Print the name of the current file
head -n 15 $filename | tail -n 5 # display the last 5 of the first 15
done # end the loop

############################################################
############################################################

# Exercise "Goostats": Use a loop on every .pdb file 

for datafile in NENE*[AB].txt
do 
    echo $datafile 
    bash goostats $datafile stats-$datafile

done