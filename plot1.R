# Data plot 1

# Read in downloaded datasets.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Sum the emissions for each year for all states in the dataset.
emissions_by_year <- group_by(NEI, year)
total_emissions_by_year <- summarise(emissions_by_year, total_emissions = sum(Emissions))

# Create PNG device.
png('plot1.png', width = 800, height = 500, units = 'px')

# Plot line graph with points.
with(total_emissions_by_year, plot(year, (total_emissions/1000), main = "US Total Annual Emissions (1999 - 2008)", ylab = (expression('Kilotons of PM'[2.5])), xlab = "Year", type = "b"))

# Cleanup.
dev.off()