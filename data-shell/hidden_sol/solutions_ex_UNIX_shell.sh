
############################################################

############################################################

## -- CMS27 - Intro to programming 2020 - Sessions 2-3
## -- Solutions to Ex: 1-8

# - Credit: Clément Mazet-Sonilhac (SciencesPo, BdF) / website: https://cms27.github.io

############################################################

############################################################



# Exercise 1: solution inside the slides

############################################################

# Exercise 2: in north-pacific-gyre/2012-07-03/, list all the text files
# ending with A or B (i.e. exclude those ending with Z)

ls *[AB].txt # list all file ending with A.txt or B.txt

############################################################

# Exercise 2 bis: Go back to folder molecule and let’s find which of these .txt
# files is the shortest !

# First option (poor style):

wc -l *.pdb > size.txt # Save the number of lines of each file in a new file called "size.txt"
sort -n size.txt > sorted-size.txt # Sort the values in "size.txt" and save the result in "sorted-size.txt"
head -n 1 sorted-size.txt # display the first line of this last file.

# Second option (better style / Aurélien's solution):
wc -l *.pdb | sort -n | head -n 1 # Combine all commands in one line ! 

############################################################

# Exercise 3: solution inside the slides

############################################################

# Exercise 4: for each files in the creatures directory, print the name of the
# file (may want to check the echo command), and the last 20 lines of the
# file (have a look at the tail command)

for filename in *.pdb # For all files ending with .pdb
do # start the loop
echo $filename # print the name of the file (easier then to understand the output)
tail -n 5 $filename # print the last 5 lines of each .pdb file
done # end the loop

############################################################

# Exercise 5: same as Ex4 but with a little add-on (write another loop 
# to show that your previous code indeed printed only 20 lines per file)

for filename in *.pdb # For all files ending with .pdb
do 
echo $filename
tail -n 5 $filename | wc -l # print number of selected lines 
done

############################################################

# Exercise "Goostats": Use a loop on every .pdb file 

for datafile in NENE*[AB].txt # For all files ending with A.txt or B.txt
do 
    echo $datafile 
    bash goostats $datafile stats-$datafile # Compute statistics in a XXX.txt file and storing results inside a stats-XXX.txt file

done

############################################################

# Exercise 7: select the 15 first lines of the file octane.pdb a
# and only display the last 5:

head -n 15 octane.pdb | tail -n 5

############################################################

# Exercise 8: Use a loop on every .pdb file 

for filename in *.pdb # Loop on everything ending with .pdb
do 
echo $filename # Print the name of the current file
head -n 15 $filename | tail -n 5 # display the last 5 of the first 15
done # end the loop

