library(tidyverse)
library(corrr)
library(igraph)
library(ggraph)

#create data frame of correlations
cors <- mtcars %>% correlate()

#Corellogram
corrr::rplot(cors)
#Network Plot
network_plot(cors)
network_plot(cors, min_cor = 0.7)


#For more formatting options use igraph and ggraph:

# Create a tidy data frame of correlations
tidy_cors <- mtcars %>% 
  correlate() %>% 
  stretch()

# Convert correlations stronger than some threshold to an undirected graph object
corr_threshold <- 0.8  #between 0 and 1
graph_cors <- tidy_cors %>%
  filter(abs(r) > corr_threshold) %>%
  graph_from_data_frame(directed = FALSE)

#plot
ggraph(graph_cors) +
  geom_edge_link() +
  geom_node_point() +
  geom_node_text(aes(label = name))

#plot nicer
ggraph(graph_cors) +
  geom_edge_link(aes(edge_alpha = abs(r), edge_width = abs(r), color = r)) +
  guides(edge_alpha = "none", edge_width = "none") +
  scale_edge_colour_gradientn(limits = c(-1, 1), 
                              colors = c("firebrick2", "dodgerblue2")) +
  geom_node_point(color = "white", size = 5) +
  geom_node_text(aes(label = name), repel = TRUE) +
  theme_graph() +
  labs(title = "Correlations between car variables")
