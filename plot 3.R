library(ggplot2)

#Read in data
NEI <- readRDS("summarySCC_PM25.rds")

#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
#variable, which of these four sources have seen decreases in emissions from 1999–2008 
#for Baltimore City? Which have seen increases in emissions from 1999–2008? 

#sum up Baltimore emissions by year and type:
Bmore_emission_type = NEI %>% 
      filter(fips=="24510") %>% 
      group_by(year, type) %>% 
      summarise(Bmore_sum_type = sum(Emissions, na.rm = TRUE))

#ggplot:
png("plot3.png")
ggplot(Bmore_emission_type, aes(year, Bmore_sum_type, color=type)) + 
      geom_line(size=1) + 
      labs(title = "Total Annual Baltimore PM 2.5 Emissions by Type", x="Year", y="Total PM 2.5 (tons)") 
dev.off()
