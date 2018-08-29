# This script selects a random subset of attribute data

import arcpy
import random

inputLayer = r'<filepath>'

# Create feature layer
featureLayer = arcpy.MakeFeatureLayer_management(inputLayer)

# Store unique IDs
objectIds = [r[0] for r in arcpy.da.SearchCursor(inputLayer, ['FID'])]

# Randomly subset list based on sample size
sampleSize = int(len(objectIds) * 0.8)
randomIds = random.sample(objectIds, sampleSize)

# Create selection query
# The NULL section takes into account zero or one length lists.
selectionQuery = '"FID" IN ({0})'.format(', '.join(map(str, randomIds)) or 'NULL')

# Run selection query
arcpy.SelectLayerByAttribute_management(featureLayer, "NEW_SELECTION", selectionQuery)
