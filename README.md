# Codes-for-bread-quality-assesment

# Walkthrough the code files
This repository contains R code to plot various bread quality assessment types. To start working on it first load your dataset and convert it to a dataframe using: 

```x <- read.csv(file.choose(), header=T)
x %>% data.frame
adt <- as.data.frame(x)  # the dataFrame 
```

## calculate means
yeast variable day 1 and 10


```
yst_0  <- adt$X.1 %>% as.numeric %>% na.omit %>% mean   # mean of day 0 yeast variable
yst_10 <- adt$X.2 %>% as.numeric %>% na.omit %>% mean   # mean of day 10 yeast variable
```
## extract control variables (days 1 and 10): 
```
ctrl1_d0  <- adt$X.5 %>% as.numeric %>% na.omit %>% mean
ctrl1_d10 <- adt$X.6 %>% as.numeric %>% na.omit %>% mean
```


