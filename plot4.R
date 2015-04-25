# Data plot 4
library(ggplot2)

# Read in downloaded datasets.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

coal <- "coal"

coal_emission_codes <- SCC[grep(coal, SCC$Short.Name, ignore.case = TRUE), ]
coal_emissions_by_year <- group_by(merge(x = NEI, y = coal_emission_codes, by = c("SCC")),year)

# Calculate total emissions in kilotons for each year for coal-related pollutants.
total_coal_emissions_by_year <- mutate(summarise(coal_emissions_by_year, total_emissions = sum(Emissions)),total_emissions_kilotons = total_emissions/1000)

# Create PNG device.
png('plot4.png', width = 800, height = 500, units = 'px')

# Plot total emissions by each year for coal-related emissions.
qplot(year,total_emissions_kilotons, data = total_coal_emissions_by_year, xlab="Year", ylab = (expression('Kilotons of PM'[2.5])), geom = c("line", "point"), main = c("US Total Annual Coal Emissions (1999 - 2008)"))

# Cleanup.
dev.off()