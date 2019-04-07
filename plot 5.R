#Read in data
NEI <- readRDS("summarySCC_PM25.rds")

SCC <- readRDS("Source_Classification_Code.rds")

#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

#Filter SCC for vehicle sources
cars = SCC %>% 
      filter(str_detect(Short.Name,"Veh") | str_detect(Short.Name, "veh"))

#Join emissions data with coal type, keeping only the values that have both
NEI_cars = inner_join(NEI, cars)

#sum up Baltimore vehicle emissions by year:
Bmore_emission_cars = NEI_cars %>% 
      filter(fips=="24510") %>% 
      group_by(year) %>% 
      summarise(Bmore_sum_cars = sum(Emissions, na.rm = TRUE))

#ggplot:
png("plot5.png")
ggplot(Bmore_emission_cars, aes(year, Bmore_sum_cars)) + 
      geom_line(size=1, col="red") + 
      labs(title = "Total Annual Baltimore PM 2.5 Emissions from Vehicles", 
           x="Year", y="Total PM 2.5 (tons)") 
dev.off()
