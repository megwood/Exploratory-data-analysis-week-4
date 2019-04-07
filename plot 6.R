#Read in data
NEI <- readRDS("summarySCC_PM25.rds")

SCC <- readRDS("Source_Classification_Code.rds")

#Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources 
#in Los Angeles County, California (fips == "06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?

#Filter SCC for vehicle sources
cars = SCC %>% 
      filter(str_detect(Short.Name,"Veh") | str_detect(Short.Name, "veh"))

#Join emissions data with coal type, keeping only the values that have both
NEI_cars = inner_join(NEI, cars)

#sum up Baltimore vehicle emissions by year:
Coast_emission_cars = NEI_cars %>% 
      filter(fips=="24510" |fips=="06037") %>% 
      group_by(year, fips) %>% 
      summarise(sum_cars = sum(Emissions, na.rm = TRUE)) %>% 
      mutate(fips = ifelse(fips=="06037", "LA",
                           ifelse(fips=="24510", "Baltimore", NA)))

#ggplot:
png("plot6.png")
ggplot(Coast_emission_cars, aes(year, sum_cars, col=fips)) + 
      geom_line(size=1) + 
      labs(title = "Los Angeles vs. Baltimore PM 2.5 Emissions from Vehicles", 
           x="Year", y="Total PM 2.5 (tons)") 
dev.off()
