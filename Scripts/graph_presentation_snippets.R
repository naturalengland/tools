#Useful scripts for graph presentation



#select variables and include them in subtitle or caption ----
library(tidyverse)
data(mtcars)
rownames(mtcars)

data_tidy <- mtcars %>%
  mutate(model = row.names(.)) %>%
  mutate(am = as.factor(am)) %>% 
  mutate(am = recode_factor(am, `0` = "manual", `1` = "automatic")) %>% 
  gather(key = "measure", value = "value", mpg, cyl, disp, hp, drat, wt, qsec)

selected.measure <- c("mpg", "disp")

graphdata <- data_tidy %>% #must be in long/tidy format
  filter(measure %in% selected.measure)

subtitle <- paste0(selected.measure, collapse = ", ")

ggplot(graphdata, aes(x = value)) +
  geom_histogram() +
  facet_grid(am~measure, scales = "free") +
  labs(title = "Automatic v Manual fuel efficiency",
       subtitle = subtitle)

