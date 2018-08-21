# This scripts converts an attribute table within ArcGIS to a CSV, allowing you to slect the fields of interest.
# Very useful for large attribute tables.

#import modules
import arcpy  
import csv  
import os  
  
# Environment variables  
inputTable =r'<filepath>'
# Need to create a blank CSV before the tool is run (NEED TO CREATE IN LOOP).
outputCSV = '<filepath>'

with open(outputCSV, "w") as csvfile:  
    csvwriter = csv.writer(csvfile, delimiter=',', lineterminator='\n')  
    # Select fields you would like to write to the CSV
    fields = ['PCODE_TRIM','lad17cd', 'lad17nm'] 
    csvwriter.writerow(fields)  
    # Write data from row
    with arcpy.da.SearchCursor(inputTable, fields) as s_cursor:  
        for row in s_cursor:  
            csvwriter.writerow(row)  
