
{library(ggplot2)
library(ggpubr)
library(dplyr)
library(reshape)
library(ggpattern)
  }

# Read the two files of day 1 and day 10, then convert them to dataframes. 

# INSTRUCTIONS in steps: 

# STEP 1) Select file 1 and file 2 for comparisons: 
File_1 <- read.csv(file.choose(), header=T);   df1 <- data.frame(File_1); day1_df <- df1[1:6] %>% na.omit  
File_2 <- read.csv(file.choose(), header=T);   df2 <- data.frame(File_2) ; day2_df <- df2[1:6] %>% na.omit


#  a function to generate a dataframe to be used for plotting 
# STEP 2) run this function: 
dataFrames <- function(df){
  # calculate means
  {yst_1  <- df$Yeast%>% as.numeric %>% na.omit %>% mean 
  Ctr_l   <- df$Ctrl_1 %>% as.numeric %>% na.omit %>% mean 
  yst_2   <- df$Yeast.2. %>% as.numeric %>% na.omit %>% mean
  Ctrl_2  <- df$Ctrl_2 %>% as.numeric %>% na.omit %>% mean
  yst_3   <- df$Yeast.4. %>% as.numeric %>% na.omit %>% mean
  Ctrl_3  <- df$Ctrl_3 %>% as.numeric %>% na.omit %>% mean}
  # Bind means: 
  as.numeric(c(yst_1, Ctr_l, yst_2, Ctrl_2,yst_3,Ctrl_3)) ->> Means #
  
  # Generate Standard Errors from the means. 
  plotrix::std.error(df) %>% as.data.frame -> stdErors
  Names <- df %>% names
  df <- data.frame(X = as.factor(c(Names)), 
                   Y = Means,
                   e = stdErors$.[1:6])
  
  
  
  }


# Step 3) generate two dataFrames then bind them to prepare for faceted plots: 
# use file 1 and generate a data frame. 
file1_df <- dataFrames(df = day1_df); file1_df$day = "day_0"
file2_df <- dataFrames(df = day2_df) ; file2_df$day = "day_10"

# Write desirable combinations for comparisons: 
my_comparisons <-list(c("Yeast", "Ctrl_1"),
                      c("Yeast.2.", "Ctrl_2"),
                      c("Yeast.4.", "Ctrl_3"),
                      c("Yeast", "Ctrl_2"),
                      c("Ctrl_1","Ctrl_2"),
                      c("Ctrl_1","Ctrl_3"),
                      c("Ctrl_2","Ctrl_3")
                      )

boundDf <- rbind(file1_df, file2_df) # this is a bound dataFrame generated from the two dataFrames: 
boundDf$day  <- factor(boundDf$day) # make the day number as factor to make facetting possible: 



Title <- "Hardness Day 0 and day 10" # Choose a title based on the plotting 
boundDf$X <- factor(boundDf$X)
# Step 5) GENERATE the Plots: 
{plt <- ggplot2::ggplot(boundDf,
                       mapping = aes(x = X, y = Y))
   ggplot2::geom_col()# +
plt <- ggpubr::ggbarplot(boundDf, x = "X", y = "Y")+
  ggplot2::geom_errorbar(mapping = aes(ymin=Y-e, ymax=Y+e), width=.2)+
  ggplot2::ggtitle(Title) + facet_grid(.~day)+
  labs(x = "Treatments and controls", y = "Hardness")#
    # stat_compare_means()+
  # stat_compare_means( ref.group = "Yeast.2.", label = "p.signif")

plt <- plt + geom_col_pattern(aes(pattern = X, fill = X))

print(plt)}

#


