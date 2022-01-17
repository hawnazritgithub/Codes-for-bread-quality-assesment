# Codes-for-bread-quality-assesment

# Walkthrough the code files
This repository contains R code to plot various bread quality assessment types. To start working on it first load your dataset and convert it to a dataframe using: 

```x <- read.csv(file.choose(), header=T)
x %>% data.frame
adt <- as.data.frame(x)  # the dataFrame 
```

## calculate means
yeast variable day 1 and 10

# Extract yeast Variables  [yst_0, yest_2, and yst_4]

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

## extract control variables (days 1 and 10) [for Control 1, 2 and 3]: 
```
ctrl1_d0  <- adt$X.5 %>% as.numeric %>% na.omit %>% mean
ctrl1_d10 <- adt$X.6 %>% as.numeric %>% na.omit %>% mean
```

# Control3 variables (day1 and 10) 
```
ctrl3_d0  <- adt$X.21 %>% as.numeric %>% na.omit %>% mean
ctrl3_d10 <- adt$X.22 %>% as.numeric %>% na.omit %>% mean
```





