# This script removes entries from a CSV. Works alot quicker than search
# and replace in Excel. particulalrly useful for very large files.
import csv

# A dictionary with the value we want to find and what we want to replace it with.
# In this example we search for #NULL! and replace it with a blank cell
reps = {
    '#NULL!' : '',
}

# Function to replace values
def replace_all(text, dic):
    for i, j in dic.items():
        text = text.replace(i, j)
    return text

# Read CSV
with open('<filepath>','r') as f:
    readCSV = f.read()
    edited_text = replace_all(readCSV, reps)

# Write CSV
with open('<filepath>', 'w') as w:
    w.write(edited_text)

