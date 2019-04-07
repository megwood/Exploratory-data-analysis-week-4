
#Read in data
NEI <- readRDS("summarySCC_PM25.rds")

#Have total emissions from PM2.5 decreased in the Baltimore City, 
#Maryland (fips=="24510") from 1999 to 2008? 

#sum up Baltimore emissions by year:
Bmore_emissions = NEI %>% 
      filter(fips=="24510") %>% 
      group_by(year) %>% 
      summarise(Bmore_sum = sum(Emissions, na.rm = TRUE))

#plot
png("plot2.png")
plot(Bmore_emissions$year, Bmore_emissions$Bmore_sum,
     col="red", type = "b",
     main = "Total Annual Baltimore PM 2.5 Emissions",
     ylab = "Total PM 2.5 (tons)",
     xlab = "Year")
dev.off()
