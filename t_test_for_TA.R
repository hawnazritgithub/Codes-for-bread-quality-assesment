# t-tests to know the bread quality changes between day 0 and day 10 

library(dplyr)
library(ggplot2)
library(ggpubr)
library(rstatix)



x <- read.csv(file.choose(), header=T)
x %>% data.frame
# x %>% View     # to view the df
adt <- as.data.frame(x)  # the dataFrame 

#View(adt)


# Calculate means:

# yeast variable day 1 and 10

yst_0  <- adt$X.1 %>% as.numeric %>% na.omit %>% mean   # mean of day 0 yeast variable
yst_10 <- adt$X.2 %>% as.numeric %>% na.omit %>% mean   # mean of day 10 yeast variable

# Control1 variables (day1 and 10) 
ctrl1_d0  <- adt$X.5 %>% as.numeric %>% na.omit %>% mean
ctrl1_d10 <- adt$X.6 %>% as.numeric %>% na.omit %>% mean


# yst 2%
yst_2_d0  <- adt$X.9 %>% as.numeric %>% na.omit %>% mean
yst_2_d10 <- adt$X.10 %>% as.numeric %>% na.omit %>% mean


# Control2 variables (day1 and 10) 
ctrl2_d0  <- adt$X.13 %>% as.numeric %>% na.omit %>% mean
ctrl2_d10 <- adt$X.14 %>% as.numeric %>% na.omit %>% mean


# yst 4%
yst_4_d0   <- adt$X.17 %>% as.numeric %>% na.omit %>% mean
yst_4_d10  <- adt$X.18 %>% as.numeric %>% na.omit %>% mean

# Control3 variables (day1 and 10) 
ctrl3_d0  <- adt$X.21 %>% as.numeric %>% na.omit %>% mean
ctrl3_d10 <- adt$X.22 %>% as.numeric %>% na.omit %>% mean


yst_Means <- c(yst_0, yst_10, ctrl1_d0,
               ctrl1_d10,yst_2_d0,
               yst_2_d10,ctrl2_d0, 
               ctrl2_d10, yst_4_d0, 
               yst_4_d10, ctrl3_d0, 
               ctrl3_d10
               )  # all means


# Calculate SEM
plotrix::std.error(adt) %>% as.data.frame -> stdErors
SEM <- stdErors %>% na.omit 
colnames(SEM) <- c('SEM')   # defines a name for the column

Names  <- c('yst_0', 'yst_10', 'ctrl1_d0',
            'ctrl1_d10','yst_2_d0',
            'yst_2_d10','ctrl2_d0', 
            'ctrl2_d10', 'yst_4_d0', 
            'yst_4_d10', 'ctrl3_d0', 
            'ctrl3_d10')

# generate a df for the plotting:
df <- data.frame(x = as.factor(c(Names)), 
                 y = yst_Means,
                 e = SEM$SEM)

library("ggpattern")

# Section4:  Output Plot ----
Title <- c('Mean and +/- SEM  ')    # title of the plot, can be changed here.
plt <- ggplot2::ggplot(df, 
                       ggplot2::aes(x = x, y = y))+
  ggplot2::geom_col(colour= df$x, fill = "bisque4")+
  ggplot2::geom_errorbar(ggplot2::aes(ymin=yst_Means-e, ymax=yst_Means+e), width=.2)+
  ggplot2::ggtitle(Title)+
  labs(x = "Treatments and controls", y = "Hardness")#
plt <- plt + geom_col_pattern(aes(pattern = x, fill = x))

print(plt)













