# Data plot 2

# Read in downloaded datasets.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Constant for Baltimore FIPS value.
baltimore <- "24510"

# Extract subset of data for Baltimore only and group by year.
emissions_by_year_baltimore <- group_by(subset(NEI, fips == baltimore, select = c(Emissions, year)), year)

# Calculate total emissions for each year.
total_emissions_by_year_baltimore <- summarise(emissions_by_year_baltimore, total_emissions = sum(Emissions))

# Create PNG device.
png('plot2.png', width = 800, height = 500, units = 'px')

# Plot total annual emissions by year.
with(total_emissions_by_year_baltimore, plot(year, total_emissions, main = "Baltimore Total Annual Emissions (1999 - 2008)", ylab = (expression('Tons of PM'[2.5])), xlab = "Year", type = "b"))

# Cleanup.
dev.off()