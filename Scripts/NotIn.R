#Not-in function 

#converse of %in%
#given a vector and a table, returns values that do not match values in the vector

'%not in%' <- function(x, table) is.na(match(x, table, nomatch=NA_integer_))
