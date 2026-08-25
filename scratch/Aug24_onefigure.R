library(tidyverse)

# read in csv's
Bisley1 <- read_csv("data/knb-lter-luq.20.4923064/QuebradaCuenca1-Bisley.csv")
Bisley2 <- read_csv("data/knb-lter-luq.20.4923064/QuebradaCuenca2-Bisley.csv")
Bisley3 <- read_csv("data/knb-lter-luq.20.4923064/QuebradaCuenca3-Bisley.csv")
PRM <- read_csv("data/knb-lter-luq.20.4923064/RioMameyesPuenteRoto.csv")

# going to just create one graph for Potassium, time on the x-axis, 
# concentration on the y-axis, moving average 

# combine csvs
combined_data <- bind_rows(Bisley1, Bisley2, Bisley3, PRM) |> 
  select("Sample_ID", "Sample_Date", "NO3-N", "K", "Ca", "Mg", "NH4-N")


ggplot(
  data = Bisley1,
  mapping = aes(x = Sample_Date, y = K)
) + 
  geom_line()