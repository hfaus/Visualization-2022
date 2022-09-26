# pull in the readr library to read our csv file
library(readr)
# assigns the data frame to a variable named penquins_size
# penguins_size <- read_csv("~/Downloads/penguins_size.csv")
# take a look at the data to see that everything came in ok
view(penguins_size)

# summary gives basic statistics on the numeric data field
summary(penguins_size)
mean(penguins_size$culmen_length_mm, na.rm =TRUE)

# command return runs a line

#? in front of any function to get the help page
?summary

# table to get some summary info on text fields
table(penguins_size$species)
table(penguins_size$island)

# aggregate
aggregate(penguins_size$body_mass_g, list(penguins_size$species), mean, 
         na.rm=TRUE)

# is.na returns vector with same dimensions as the data frame
is.na(penguins_size$culmen_depth_mm)
which(is.na(penguins_size$culmen_depth_mm))
depth_nas <- is.na(penguins_size$culmen_depth_mm)
which(depth_nas)

plot(penguins_size$culmen_length_mm, penguins_size$culmen_depth_mm)

library(ggplot2)
library(plotly)
# we can make a variable for our plot and add to it
myplot <- ggplot(penguins_size)
myplot <- myplot + geom_point(aes(x=culmen_length_mm, y=culmen_depth_mm, color=species, shape=species))
myplot <- myplot + xlab("Culmen Length mm")
myplot <- myplot + ylab("Culmen Depth mm")
myplot <- myplot + labs(title="Penguins")
# plotly will take a ggplot and make it interactive
ggplotly(myplot)

# alpha is the transparency - a number between 0 and 1
# position = identity instead of stacked makes each bar start at 0
ggplotly(
  ggplot(penguins_size) + geom_histogram(aes(body_mass_g, fill = species),
                                         binwidth=300, color="white",
                                         position="identity", alpha=0.5)
)

# density graph
ggplotly(
  ggplot(penguins_size) + geom_density(aes(body_mass_g, fill = species),
                                         position="identity", alpha=0.5)
)


