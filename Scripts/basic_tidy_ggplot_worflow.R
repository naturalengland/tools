#Basic graphing worflow with dplyr and ggplot


#create sample data----
watertemp <- data.frame(
  date = as.Date('2019-01-01') + 0:19,
  oxford_am = rnorm(20, 8, 1),
  westminster_am = rnorm(20, 7, 2),
  gravesend_am = rnorm(20, 6, 4),
  oxford_pm = rnorm(20, 9, 1),
  westminster_pm = rnorm(20, 8, 2),
  gravesend_pm = rnorm(20, 7, 4)
)
  #this is just made up data!


#make tidy format data----

  #We want to make every row have only one observation and every column 
  #only one variable.  At the moment we have six observations in each row, 
  #so we need to move each observation into its own row.  For that we need two new 
  #variables: location and time of day.  The value for each date/location/time is the temperature. 

tidydata <- watertemp %>% 
  gather(key = location, value = temperature, -date) %>% #gathers the data into 3 columns
  separate(col = location, #splits the time element off the location column
           into = c("location", "time"), 
           sep = "_")

  #now we have four variables: date, location, time, temperature

#graph it----

#a simple dot plot showing all the data:
graphdata <- tidydata #not really necessary yet, but I find it useful
ggplot(data = graphdata, 
       mapping = aes(x = date, 
                     y = temperature, 
                     colour = location)) +
  geom_point() +
  labs(title = "Water temperature at three locations", 
       y = "degrees C")

  #the same code but simpler: 
ggplot(graphdata, aes(x = date, y = temperature, colour = location)) + 
  geom_point()+
  labs(title = "Water temperature at three locations", 
       y = "degrees C")


#the same but just for oxford:
graphdata <- filter(tidydata, location == "oxford")
ggplot(graphdata, aes(x = date, y = temperature, colour = time)) + 
  geom_point()+
  labs(title = "Water temperature in Oxford", 
       y = "degrees C")

#lets do lines
graphdata <- filter(tidydata, location == "oxford")
ggplot(graphdata, aes(x = date, y = temperature, colour = time)) + 
  geom_line()+
  labs(title = "Water temperature in Oxford", 
       y = "degrees C")

#lines for all sites
graphdata <- filter(tidydata, time == "am") #just look at morning temp 
ggplot(graphdata, aes(x = date, y = temperature, colour = location)) + 
  geom_line()+
  labs(title = "Water temperature at three locations", 
       subtitle = "morning temperature only",
       y = "degrees C")

#lets look at am/pm mean temp
graphdata <- tidydata %>% 
  group_by(date, location) %>% 
  summarise(dailymean = mean(temperature))

ggplot(graphdata, aes(x = date, 
                      y = dailymean, #note different y axis
                      colour = location)) + 
  geom_line()+
  labs(title = "Water temperature at three locations", 
       subtitle = "daily mean",
       y = "degrees C")


#lets look at am/pm temp difference
graphdata <- tidydata %>% 
  spread(key = time, value = temperature) %>% #makes new columns for am & pm
  mutate(tempdiff = pm - am)

ggplot(graphdata, aes(x = date, 
                      y = tempdiff, #note different y axis
                      colour = location)) + 
  geom_line()+
  labs(title = "Water temperature at three locations", 
       subtitle = "daily tempearature change",
       y = "degrees C")


#put each location in it's own facet
graphdata <- tidydata 
ggplot(graphdata, aes(x = date, y = temperature, colour = time)) + 
  geom_line()+
  facet_grid(location~.)+
  labs(title = "Water temperature at three locations", 
       y = "degrees C")

#and boxplots
graphdata <- tidydata 
ggplot(graphdata, aes(y = temperature, x = location)) + 
  geom_boxplot()+
  labs(title = "Water temperature at three locations", 
       y = "degrees C")


#or a smoothed regression
graphdata <- filter(tidydata, location == "oxford")
ggplot(graphdata, aes(x = date, y = temperature)) + 
  geom_smooth()+
  labs(title = "Water temperature in Oxford", 
       y = "degrees C")
