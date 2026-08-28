# Getting the necessary libraries and functions to have our code run properly
library(tidyverse)
source("R/moving-average.R")


# Reading in each stream's csv in order to create dataframes for each
Bisley1 <- read_csv("data/knb-lter-luq.20.4923064/QuebradaCuenca1-Bisley.csv")
Bisley2 <- read_csv("data/knb-lter-luq.20.4923064/QuebradaCuenca2-Bisley.csv")
Bisley3 <- read_csv("data/knb-lter-luq.20.4923064/QuebradaCuenca3-Bisley.csv")
PRM <- read_csv("data/knb-lter-luq.20.4923064/RioMameyesPuenteRoto.csv")

# Creating tibbles for 9 week moving average values for each nutrient
# for each stream by calling the moving_average
# function on each stream
bq1_smoothed <- moving_average(Bisley1)
bq2_smoothed <- moving_average(Bisley2)
bq3_smoothed <- moving_average(Bisley3)
prm_smoothed <- moving_average(PRM)

# Combining the tibbles created above in order to plot values from
# all the streams as well as adding stream identtification column
big_tibble <- bind_rows(
  bq1_smoothed |> mutate(stream = "BQ1"),
  bq2_smoothed |> mutate(stream = "BQ2"),
  bq3_smoothed |> mutate(stream = "BQ3"),
  prm_smoothed |> mutate(stream = "PRM")
)

# Pivoting the combined table in order to plot values properly with
# ggplot, in the process creating columns nutrients and concentration
big_tibble_longer <- pivot_longer(
  data = big_tibble,
  cols = c(k_mgl, mg_mgl, no3n_ugl, nh4n_ugl, ca_mgl),
  names_to = "Nutrients",
  values_to = "Concentration"
)

# writing a csv in order to create an intermediate output the quarto document can use.
write_csv(big_tibble_longer, "output/intermediate_output.csv")
