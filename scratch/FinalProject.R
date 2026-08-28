library(tidyverse)
library(lubridate)
source("R/moving-average.R")

# read in csv's
Bisley1 <- read_csv("data/knb-lter-luq.20.4923064/QuebradaCuenca1-Bisley.csv")
Bisley2 <- read_csv("data/knb-lter-luq.20.4923064/QuebradaCuenca2-Bisley.csv")
Bisley3 <- read_csv("data/knb-lter-luq.20.4923064/QuebradaCuenca3-Bisley.csv")
PRM <- read_csv("data/knb-lter-luq.20.4923064/RioMameyesPuenteRoto.csv")

# explore data
head(Bisley1)
head(Bisley2)
head(Bisley3)
head(PRM)
colnames(Bisley1)
colnames(Bisley2)
colnames(Bisley3)
colnames(PRM) # all datasets have similar amounts of rows and the same columns

# combine csvs / changed combined_data to joined_data
joined_data <- bind_rows(Bisley1, Bisley2, Bisley3, PRM) |>
  select("Sample_ID", "Sample_Date", "NO3-N", "K", "Ca", "Mg", "NH4-N")

# day 1 graph - plotting  sample date on the x axis, and K concentration on the y axis
ggplot(
  data = Bisley1,
  mapping = aes(x = Sample_Date, y = K)
) +
  geom_line()

## Calling ma function on each stream
bq1_smoothed <- moving_average(Bisley1)
bq2_smoothed <- moving_average(Bisley2)
bq3_smoothed <- moving_average(Bisley3)
prm_smoothed <- moving_average(PRM)

## Combining into a long format tibble
big_tibble <- bind_rows(
  bq1_smoothed |> mutate(stream = "BQ1"),
  bq2_smoothed |> mutate(stream = "BQ2"),
  bq3_smoothed |> mutate(stream = "BQ3"),
  prm_smoothed |> mutate(stream = "PRM")
)
# pivot the table
big_tibble_longer <- pivot_longer(
  data = big_tibble,
  cols = c(k_mgl, mg_mgl, no3n_ugl, nh4n_ugl, ca_mgl),
  names_to = "Nutrients",
  values_to = "Concentration"
)

## set the levels of nutrient graphs according to the order in the actual figure
big_tibble_longer |>
  mutate(
    Nutrients = fct_relevel(
      Nutrients,
      "k_mgl",
      "no3n_ugl",
      "mg_mgl",
      "ca_mgl",
      "nh4n_ugl"
    )
  ) |>
  mutate(
    Nutrients = fct_recode(
      Nutrients,
      "K mgl" = "k_mgl",
      "NO3-N ugl" = "no3n_ugl",
      "Mg mgl" = "mg_mgl",
      "Ca mgl" = "ca_mgl",
      "NH4-N ugl" = "nh4n_ugl"
    )
  ) |>
  ## graph
  ggplot(
    big_tibble_longer,
    mapping = aes(
      x = window_start,
      y = Concentration,
      linetype = stream
    )
  ) +
  geom_line() +
  facet_wrap("Nutrients", scales = "free", ncol = 1, strip.position = "left") +
  labs(
    title = "Concentrations in Bisley, Puerto Rico streams before and after Hurricane Hugo.",
    x = "Years"
  )
