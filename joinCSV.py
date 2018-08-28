# This script performs an outer join between two CSVs
import pandas as pd

# define filepaths
input1 = "<filepath>"
input2 = "<filepath>"

#read CSVs to panda
df1 = pd.read_csv(input1)
df2 = pd.read_csv(input2)

#perform outer join
df3 = df1.merge(df2, on=["<Fieldname>"], how='outer')

#write back to CSV
df3.to_csv("<filepath>",index=False)