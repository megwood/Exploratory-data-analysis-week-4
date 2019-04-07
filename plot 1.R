library(tidyverse)

#Read in data
NEI <- readRDS("summarySCC_PM25.rds")

SCC <- readRDS("Source_Classification_Code.rds")

#First Plot:
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Plot total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

#sum up emissions by year:
emissions_sum = NEI %>% 
      mutate(year = as.character(year)) %>% 
      group_by(year) %>% 
      summarise(sum = sum(Emissions, na.rm = TRUE))

#plot
png("plot1.png")
plot(emissions_sum$year, emissions_sum$sum,
     col="red", type = "b",
     main = "Total Annual PM 2.5 Emissions",
     ylab = "Total PM 2.5 (tons)",
     xlab = "Year")
dev.off()
