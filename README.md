# Codes-for-bread-quality-assesment
# The following codes were written for investigating the difference between bread quality in day 0 and 10.
# Walkthrough the code files
This repository contains R code to plot various bread quality assessment types. To start working on it first load your dataset and convert it to a dataframe using: 

```x <- read.csv(file.choose(), header=T)
x %>% data.frame
adt <- as.data.frame(x)  # the dataFrame 
```

## calculate means
yeast variable day 0 and 10

# Extract yeast Variables  [yst_0, yst_2, and yst_4]

```
yst_0  <- adt$X.1 %>% as.numeric %>% na.omit %>% mean   # mean of day 0 yeast variable
yst_10 <- adt$X.2 %>% as.numeric %>% na.omit %>% mean   # mean of day 10 yeast variable
```
# yst 2%
```yst_2_d0  <- adt$X.9 %>% as.numeric %>% na.omit %>% mean
yst_2_d10 <- adt$X.10 %>% as.numeric %>% na.omit %>% mean
```

# yst 4%
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

# The following codes were written for investigating the difference among different treatments in both day 0 and 10.
