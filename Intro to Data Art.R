#============Intro to Data Art Examples Code============#

# Library Load-in====
library(tidyverse)

# Seed Setting for reproducibility====
set.seed(1379)

# Example 1: A Single Point====

## Example 1: Data Frame====
single_point <- tibble(x=0, y=0)

## Example 1 ggplot====
Example1 <- single_point %>%
  ggplot(aes(x = x, y = y))+
  geom_point()

# Example 2: Randomized Lines====

## Example 2: Data Frame====
random_lines <- tibble(x = sample(1:500, 50),
                       y = 1:50)

## Example 2: ggplot====
Example2 <- random_lines %>% 
  ggplot(aes(x=x, y=y, xend = median(x), yend = median(y)))+
  geom_segment()

# Example 3: Square====

## Example 3: Data Frame====
square <- tibble(x = c(0,5,5,0), 
                 y = c(0,0,5,5),
                 labels = 1:4)

## Example 3: Geom_line() ggplot====
Example3_1 <- square %>%
  ggplot(aes(x = x,
             y = y,
             label = labels))+
  geom_line()+
  geom_label()+
  coord_equal()

## Example 3: Geom_path() ggplot====
Example3_2 <- square %>%
  ggplot(aes(x = x, y = y, label = labels))+
  geom_path()+
  geom_label()+
  coord_equal()

# Example 4: Geom_polygon ggplot====
Example4 <- square %>%
  ggplot(aes(x = x,
             y = y,
             label = labels))+
  geom_polygon()+
  geom_label()+
  coord_equal()

# Example 5: Geom_Polygon ggplot with no fill====
Example5 <- square %>%
  ggplot(aes(x = x,
             y = y,
             label = labels))+
  geom_polygon(fill = NA, color = "black")+
  geom_label()+
  coord_equal()

# Example 6: Geom_Polygon ggplot with colored points====

## Example 6: Data Frame====
square_color_points <- tibble(x = c(0,5,5,0),
                 y = c(0,0,5,5),
                 colors = c("#c0d943","#027337","#d12017","#000a96"))

## Example 6: Geom_Polygon ggplot with colored points====
Example6 <- square_color_points %>%
  ggplot(aes(x = x,
             y = y))+
  geom_polygon(fill = "#4b1980")+
  geom_point(color = square_color_points$colors)+
  coord_equal()

# Example 7: Geom_Polygon ggplot with colored points and Random Sizes====
Example7 <- square_color_points %>%
  ggplot(aes(x = x,
             y = y))+
  geom_polygon(fill = "#4b1980")+
  geom_point(color = square_color_points$colors,
             size = sample(1:20, nrow(square_color_points)))+
  coord_equal()

# Example 8: Randomized Points====

## Example 8: Data Frame====
random_points <- tibble(x = 1:100,
                        y = sample(1:100))

## Example 8: ggplot of randomized points====
Example8_1 <- random_points %>%
  ggplot(aes(x=x, y=y))+
  geom_point()

## Example 8: ggplot of randomized points with randomized colors====
Example8_2 <- random_points %>%
  ggplot(aes(x=x, y=y))+
  geom_point(color = sample(RColorBrewer::brewer.pal(5,"PRGn"), nrow(random_points), replace = TRUE))

# Example 9: ggplot of randomized points with randomized colors and logic applied====
Example9 <- random_points %>%
  ggplot(aes(x=x, y=y))+
  geom_point(color = ifelse(random_points$y < 50,
                            sample(RColorBrewer::brewer.pal(5,"PRGn"), nrow(random_points), replace = TRUE),
                            "black"))

# Example 10: Layering different data sets together====

## Example 10: Lines_data Data Frame====
Lines_data <-  tibble(x = rep(1, 4),
                      xend = rep(5, 4),
                      y = seq(0,6, by = 2),
                      yend = y )

## Example 10: Circles_data Data Frame====
Circles_data <- tibble(x = 3,
                       y = unique(abs(seq(0,6, by = 2) - 1)),
                       size = 1:3)

##Logic Check: Do these dataframes have the same number of row?##
nrow(Lines_data) == nrow(Circles_data)

## Example 10: Attempting to add Lines_data and Circles_data together in geom WITHOUT inherit.aes====
Lines_data %>%
  ggplot(aes(x=x, y=y, xend = xend, yend = yend))+
  geom_segment(size = 15)+
  geom_point(data = Circles_data, aes(x=x, y=y, size = size)) # Will throw an error #

## Example 10: Adding Lines_data and Circles_data together with inherit.aes in geom====
Example10 <- Lines_data %>%
  ggplot(aes(x=x, y=y, xend = xend, yend = yend))+
  geom_segment(size = 15)+
  geom_point(data = Circles_data, aes(x=x, y=y, size = size), inherit.aes = FALSE)

# Example 11: Adding Lines_data and Circles_data together with layer function====
Example11_1 <- Lines_data %>%
  ggplot(aes(x=x, y=y, xend = xend, yend = yend))+
  geom_segment(size = 15)+
  layer(geom = "point",
        data = Circles_data,
        stat = "identity",
        position = "identity",
        mapping = aes(x=x, y=y, size = size),
        inherit.aes = FALSE)

# Example 11: Adding Lines_data and Circles_data together with annotate function====
Example11_2 <- Lines_data %>%
  ggplot(aes(x=x, y=y, xend = xend, yend = yend))+
  geom_segment(size = 15)+
  annotate(geom = "point",
           x= Circles_data$x, 
           y= Circles_data$y, 
           size = Circles_data$size)


