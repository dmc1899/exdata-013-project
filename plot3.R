# Data plot 3
library(ggplot2)

# Read in downloaded datasets.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Constant to identify Baltimore.
baltimore <- "24510"

# Extract subset of data for Baltimore only and group by both year and type.
emissions_by_year_type_baltimore <- group_by(subset(NEI, fips == baltimore, select = c(Emissions, year, type)), year, type)

# Calculate total emissions for each year and type.
total_emissions_by_year_type_baltimore <- summarise(emissions_by_year_type_baltimore, total_emissions = sum(Emissions))

# Create PNG device.
png('plot3.png', width = 800, height = 500, units = 'px')

# Plot four lines and points for each of the four types, displaying total emissions for each year.
qplot(year,total_emissions, data = total_emissions_by_year_type_baltimore, color = type, xlab="Year", ylab = (expression('Tons of PM'[2.5])), geom = c("line", "point"), main = c("Baltimore Total Annual Emissions by Type (1999 - 2008)"))

# Cleanup.
dev.off()