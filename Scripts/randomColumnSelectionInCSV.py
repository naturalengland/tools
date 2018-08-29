# This script selects a random column from a set of columns (based on certain conditions)
# and removes entries in the other columns. Used as part of MENE statistical analysis.
import csv
import random

inputCSV = open('<filepath>','rb')
outputCSV = open('<filepath>','wb')

writer = csv.writer(outputCSV)

for row in csv.reader(inputCSV):

	# All columns included in the process
	includedColumns = [8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28]
	# Create a dictionary of columns
	content = {i: row[i] for i in includedColumns}
	# Remove certain columns based on a criteria - in this example, if they are not equal to one
	for key, value in content.items():
		if value != '1':
			del content[key]
	
	# Select random object (key, pair) from dictionary only if dictionary isn't empty
	if any(content):
		column, value = random.choice(list(content.items()))
		# Remove selected column from dictionary
		includedColumns.remove(column)

		# For values left in the dictionary, make these equal to zero in the row
		for values in includedColumns:
			row[values] = 0

		# Write the row
		writer.writerow(row)
	else:
		writer.writerow(row)

#close all csv's
inputCSV.close()
outputCSV.close()



