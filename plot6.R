# Data plot 6
library(ggplot2)

# Read in downloaded datasets.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Constants to identify Baltimore, California and road vehicles.
baltimore <- "24510"
california <- "06037"
vehicle <- "ON-ROAD"
maryland_state <- "Baltimore"
california_state <- "Los Angeles"

# Create subset of data for Maryland vehicles.
emissions_vehicles_baltimore_by_year <- group_by(subset(NEI, fips == baltimore & type == vehicle), year)
total_emissions_vehicles_baltimore_by_year <- summarise(emissions_vehicles_baltimore_by_year, total_emissions = sum(Emissions))
total_emissions_vehicles_baltimore_by_year$state <- maryland_state

# Create subset of data for California vehicles.
emissions_vehicles_california_by_year <- group_by(subset(NEI, fips == california & type == vehicle), year)
total_emissions_vehicles_california_by_year <- summarise(emissions_vehicles_california_by_year, total_emissions = sum(Emissions))
total_emissions_vehicles_california_by_year$state <- california_state

# Create single dataframe with Maryland and California data.
total_emissions_vehciles_baltimore_california_by_year <- rbind(total_emissions_vehicles_baltimore_by_year,total_emissions_vehicles_california_by_year)

# Create PNG device.
png('plot6.png', width = 800, height = 500, units = 'px')

ggplot(data = total_emissions_vehciles_baltimore_california_by_year, aes(x = year, y = total_emissions)) + geom_line(aes(group = 1, col = total_emissions)) + guides(fill = F) + ggtitle('Los Angeles & Baltimore Total Vehicle Emissions (1999 - 2008)') + ylab(expression('Tons of PM'[2.5])) + xlab('Year') + theme(legend.position = 'none') + facet_grid(. ~ state) + geom_text(aes(label = round(total_emissions, 0), size = 1, hjust = 0.5, vjust = -1))

# Cleanup.
dev.off()