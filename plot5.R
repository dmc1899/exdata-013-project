# Data plot 5
library(ggplot2)

# Read in downloaded datasets.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Constants to identify Baltimore and road vehicles.
baltimore <- "24510"
vehicle <- "ON-ROAD"

emissions_vehicles_baltimore_by_year <- group_by(subset(NEI, fips == baltimore & type == vehicle), year)

total_emissions_vehicles_baltimore_by_year <- summarise(emissions_vehicles_baltimore_by_year, total_emissions = sum(Emissions))

# Create PNG device.
png('plot5.png', width = 800, height = 500, units = 'px')

# Plot total emissions by each year for Baltimore road vehicles.
qplot(year,total_emissions, data = total_emissions_vehicles_baltimore_by_year, xlab="Year", ylab = (expression('Tons of PM'[2.5])), geom = c("line", "point"), main = c("Baltimore Total Annual Motor Vehicle Emissions (1999 - 2008)"))

# Cleanup.
dev.off()