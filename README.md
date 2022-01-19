# Codes-for-bread-quality-assesment
## The following codes were written for investigating the difference among different treatments in both day 0 and 10.
# Walkthrough the code files
This repository contains R code to plot various bread quality assessment types. To start working on it first load your dataset and convert it to a dataframe using: 
## Select file 1 and file 2 for comparisons
```
File_1 <- read.csv(file.choose(), header=T);   df1 <- data.frame(File_1); day1_df <- df1[1:6] %>% na.omit  
File_2 <- read.csv(file.choose(), header=T);   df2 <- data.frame(File_2) ; day2_df <- df2[1:6] %>% na.omit 
```
## function to generate a dataframe to be used for plotting 
```
dataFrames <- function(df){
  # calculate means
  {yst_1  <- df$Yeast%>% as.numeric %>% na.omit %>% mean 
  Ctr_l   <- df$Ctrl_1 %>% as.numeric %>% na.omit %>% mean 
  yst_2   <- df$Yeast.2. %>% as.numeric %>% na.omit %>% mean
  Ctrl_2  <- df$Ctrl_2 %>% as.numeric %>% na.omit %>% mean
  yst_3   <- df$Yeast.4. %>% as.numeric %>% na.omit %>% mean
  Ctrl_3  <- df$Ctrl_3 %>% as.numeric %>% na.omit %>% mean}
```
## Bind means
```
as.numeric(c(yst_1, Ctr_l, yst_2, Ctrl_2,yst_3,Ctrl_3)) ->> Means
```
## Generate Standard Errors from the means.
``` plotrix::std.error(df) %>% as.data.frame -> stdErors
  Names <- df %>% names
  df <- data.frame(X = as.factor(c(Names)), 
                   Y = Means,
                   e = stdErors$.[1:6])
  
  
  
  }
```
## generate two dataFrames then bind them to prepare for faceted plots
```
file1_df <- dataFrames(df = day1_df); file1_df$day = "day_0"
file2_df <- dataFrames(df = day2_df) ; file2_df$day = "day_10"
```
## Write desirable combinations for comparisons
```
my_comparisons <-list(c("Yeast", "Ctrl_1"),
                      c("Yeast.2.", "Ctrl_2"),
                      c("Yeast.4.", "Ctrl_3"),
                      c("Yeast", "Ctrl_2"),
                      c("Ctrl_1","Ctrl_2"),
                      c("Ctrl_1","Ctrl_3"),
                      c("Ctrl_2","Ctrl_3")
                      )

```
## make a dataFrame from the two dataFrames
```
boundDf <- rbind(file1_df, file2_df)
```
## make the day number as factor to make facetting possible
```
boundDf$day  <- factor(boundDf$day)
```
## Generates the plots
```
Title <- "Hardness Day 0 and day 10" # Choose a title based on the plotting 
boundDf$X <- factor(boundDf$X)
# Step 5) GENERATE the Plots: 
{plt <- ggplot2::ggplot(boundDf,
                       mapping = aes(x = X, y = Y))
   ggplot2::geom_col()# +
plt <- ggpubr::ggbarplot(boundDf, x = "X", y = "Y")+
  ggplot2::geom_errorbar(mapping = aes(ymin=Y-e, ymax=Y+e), width=.2)+
  ggplot2::ggtitle(Title) + facet_grid(.~day)+
  labs(x = "Treatments and controls", y = "Hardness")
  plt <- plt + geom_col_pattern(aes(pattern = X, fill = X))

print(plt)}

```

## The following codes were written for investigating the difference between bread quality in day 0 and 10.
# Walkthrough the code files

```x <- read.csv(file.choose(), header=T)
x %>% data.frame
adt <- as.data.frame(x)  # the dataFrame 
```

## calculate means
yeast variable day 0 and 10

## Extract yeast Variables  [yst_0, yst_2, and yst_4]

```
yst_0  <- adt$X.1 %>% as.numeric %>% na.omit %>% mean   # mean of day 0 yeast variable
yst_10 <- adt$X.2 %>% as.numeric %>% na.omit %>% mean   # mean of day 10 yeast variable
```
## yst 2%
```yst_2_d0  <- adt$X.9 %>% as.numeric %>% na.omit %>% mean
yst_2_d10 <- adt$X.10 %>% as.numeric %>% na.omit %>% mean
```

## yst 4%
```
yst_4_d0   <- adt$X.17 %>% as.numeric %>% na.omit %>% mean
yst_4_d10  <- adt$X.18 %>% as.numeric %>% na.omit %>% mean
```

## Extract control variables (days 0 and 10) [for Control 1, 2 and 3]: 

```
ctrl1_d0  <- adt$X.5 %>% as.numeric %>% na.omit %>% mean
ctrl1_d10 <- adt$X.6 %>% as.numeric %>% na.omit %>% mean
```
### Control2 variables (day0 and 10) 
```
ctrl2_d0  <- adt$X.13 %>% as.numeric %>% na.omit %>% mean
ctrl2_d10 <- adt$X.14 %>% as.numeric %>% na.omit %>% mean
```
### Control3  
```
ctrl3_d0  <- adt$X.21 %>% as.numeric %>% na.omit %>% mean
ctrl3_d10 <- adt$X.22 %>% as.numeric %>% na.omit %>% mean
```
# combine all means in one object
```
yst_Means <- c(yst_0, yst_10, ctrl1_d0,
               ctrl1_d10,yst_2_d0,
               yst_2_d10,ctrl2_d0, 
               ctrl2_d10, yst_4_d0, 
               yst_4_d10, ctrl3_d0, 
               ctrl3_d10
               )
```
# Calculate SEM  
```
plotrix::std.error(adt) %>% as.data.frame -> stdErors
SEM <- stdErors %>% na.omit 
colnames(SEM) <- c('SEM')   

Names  <- c('yst_0', 'yst_10', 'ctrl1_d0',
            'ctrl1_d10','yst_2_d0',
            'yst_2_d10','ctrl2_d0', 
            'ctrl2_d10', 'yst_4_d0', 
            'yst_4_d10', 'ctrl3_d0', 
            'ctrl3_d10')
```
# generate a df for the plotting  
```
df <- data.frame(x = as.factor(c(Names)), 
                 y = yst_Means,
                 e = SEM$SEM)
```
# Output Plot  
```
Title <- c('Mean and +/- SEM  ')    # title of the plot, can be changed here.
plt <- ggplot2::ggplot(df, 
                       ggplot2::aes(x = x, y = y))+
  ggplot2::geom_col(colour= df$x, fill = "bisque4")+
  ggplot2::geom_errorbar(ggplot2::aes(ymin=yst_Means-e, ymax=yst_Means+e), width=.2)+
  ggplot2::ggtitle(Title)+
  labs(x = "Treatments and controls", y = "Hardness") #x and y lables can be changed here
plt <- plt + geom_col_pattern(aes(pattern = x, fill = x))

print(plt)
```


