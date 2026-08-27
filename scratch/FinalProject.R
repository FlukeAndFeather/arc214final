library(tidyverse)

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

# day 2 graph - one concentrations (potassium) graph with all sites
## first step create a tibble
potassium_smoothed <- tibble(
  window_start = seq(ymd("1988-01-01"), ymd("1994-06-01"), by = "9 weeks"),
  BQ1 = NA,
  BQ2 = NA,
  BQ3 = NA,
  PRM = NA
)
## second step create for loop featuring windowing and calculating mean
for (i in 1:nrow(potassium_smoothed)) {
  w1 <- potassium_smoothed$window_start[i]
  w2 <- potassium_smoothed$window_start[i] + (9 * 7)

  bis1 <- Bisley1$K[Bisley1$Sample_Date >= w1 & Bisley1$Sample_Date < w2]
  bis2 <- Bisley2$K[Bisley2$Sample_Date >= w1 & Bisley2$Sample_Date < w2]
  bis3 <- Bisley3$K[Bisley3$Sample_Date >= w1 & Bisley3$Sample_Date < w2]
  perm <- PRM$K[PRM$Sample_Date >= w1 & PRM$Sample_Date < w2]

  potassium_smoothed$BQ1[i] <- mean(bis1, na.rm = TRUE)
  potassium_smoothed$BQ2[i] <- mean(bis2, na.rm = TRUE)
  potassium_smoothed$BQ3[i] <- mean(bis3, na.rm = TRUE)
  potassium_smoothed$PRM[i] <- mean(perm, na.rm = TRUE)
}
## pivot data to long
potassium_long <- potassium_smoothed |>
  pivot_longer(
    cols = c(BQ1, BQ2, BQ3, PRM),
    names_to = "stream",
    values_to = "K"
  )
## graph
ggplot(potassium_long, aes(x = window_start, y = K, color = stream)) +
  geom_line() +
  labs(y = "K mg/L", x = "Year", color = "Stream")
