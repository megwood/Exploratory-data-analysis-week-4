#Read in data
NEI <- readRDS("summarySCC_PM25.rds")

SCC <- readRDS("Source_Classification_Code.rds")

# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
      
#Filter SCC for coal source types
coal = SCC %>% 
      filter(str_detect(Short.Name,"coal") | str_detect(Short.Name, "Coal"))

#Join emissions data with coal type, keeping only the values that have both
NEI_coal = inner_join(NEI, coal)

#summarize emissions from coal sources
Coal_emissions = NEI_coal %>% 
      group_by(year) %>% 
      summarise(Coal_emissions = sum(Emissions, na.rm = TRUE))

#ggplot:
png("plot4.png")
ggplot(Coal_emissions, aes(year, Coal_emissions)) + 
      geom_line(size=1, col="red") + 
      labs(title = "United States Total Annual PM 2.5 Emissions from Coal", 
           x="Year", y="Total PM 2.5 (tons)") 
dev.off()
